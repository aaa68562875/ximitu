//
//  FTDBManager.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTDBManager.h"
#import <CoreData/CoreData.h>
@implementation FTDBManager
@synthesize backgroundObjectContext = _backgroundObjectContext;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (FTDBManager *)sharedManager
{
    static FTDBManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[FTDBManager alloc] init];
    });
    return _sharedManager;
}

- (id)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didSaveContext:) name:NSManagedObjectContextDidSaveNotification object:nil];
    }
    return self;
}

- (void)didSaveContext:(NSNotification *)notification
{
    @synchronized(self){
        [[self backgroundObjectContext] mergeChangesFromContextDidSaveNotification:notification];
    };
}


///返回document的路径
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



///保存当前的上下文
- (void)saveContext
{
    NSError *error = nil;
    if (self.managedObjectContext != nil) {
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"保存当前上下文失败 %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

/**
 返回上下文，动态的写法，只有到了需要的时候才去分配内存，不是一次性全部创建
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectContext *)backgroundObjectContext
{
    if (_backgroundObjectContext != nil) {
        return _backgroundObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _backgroundObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_backgroundObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _backgroundObjectContext;
}

///返回管理对象模型
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LYCampus_iPhone" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// 返回coordinator
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LYCampus_iPhone.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}







- (BOOL)insertNewObjectOfEntity:(NSString *)entityName fromDictionary:(NSDictionary *)jsonDict
{
    ///获取一个对象
    NSManagedObject *managedObj=[NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    ///返回一个对象，然后对该对象设置属性的数值
    NSDictionary *attributes = [[managedObj entity] attributesByName];
    for (NSString *attribute in attributes)
    {    id value = [jsonDict objectForKey:attribute];
        if (value == nil)
        {
            continue;
        }
        if ([value isKindOfClass:[NSNull class]] || value ==nil) {
            [managedObj setValue:@"null" forKey:attribute];
        }
        else{
            [managedObj setValue:value forKey:attribute];
        }
    }
    [self save];
    return YES;
}



- (NSArray *)fetchObjectsOfEntity:(NSString *)entityName withPredicateStr:(NSString *)pre sortDescriptor:(NSSortDescriptor *)sort
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    ///设置要查询的实体
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:entity];
    /// 设置排序
    if (sort) {
        request.sortDescriptors = [NSArray arrayWithObject:sort];
    }
    ///设置条件过滤(搜索name中包含字符串的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替)
    if (pre) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:pre];
        request.predicate = predicate;
    }
    ///执行请求
    NSError *error = nil;
    NSArray *objs = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:kLYDataBaseQueryError format:@"%@", [error localizedDescription]];
    }
    /// 返回获取的数组
    return objs;
}

- (BOOL)removeObjectsOfEntity:(NSString *)entityName withPredicateStr:(NSString *)pre
{
    NSFetchRequest* request=[[NSFetchRequest alloc]init];
    NSEntityDescription* entity=[NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    ///request设置对象
    [request setEntity:entity];
    ///request设置谓词,谓词为空删除所有该类型的对象
    if (pre) {
        NSPredicate* predicate=[NSPredicate predicateWithFormat:pre];
        [request setPredicate:predicate];
    }
    NSArray* objs=[[self managedObjectContext] executeFetchRequest:request error:NULL];
    NSLog(@"%@",objs);
    // 遍历所有查询满足条件的对象，然后进行delete操作
    BOOL success=YES;
    for (id object in objs) {
        [self.managedObjectContext deleteObject:object];
        NSError *error=nil;
        [self.managedObjectContext save:&error];
        if (error) {
            [NSException raise:kLYDataBaseRemoveError format:@"%@",[error localizedDescription]];
            success=NO;
        }
    }
    return success;
}

- (NSArray *)updateObjectsOfEntity:(id)obj withPredicateStr:(NSString *)p
{
    ///获取对象的类名
    NSString *className = nil;
    if ([obj isString]) {
        className=(NSString *)obj;
    }
    else{
        className=NSStringFromClass(([obj class]));
    }
    NSFetchRequest* request=[[NSFetchRequest alloc]init];
    NSEntityDescription* entity=[NSEntityDescription entityForName:className inManagedObjectContext:self.managedObjectContext];
    ///设置实体对象
    [request setEntity:entity];
    ///设置谓词
    NSPredicate* predicate=[NSPredicate predicateWithFormat:p];
    [request setPredicate:predicate];
    NSArray* objs=[self.managedObjectContext executeFetchRequest:request error:NULL];
    [self save];
    return objs;
}




- (BOOL)save
{
    NSError *error = nil;
    BOOL success = [[self managedObjectContext] save:&error];
    if (success) {
        return YES;
    }
    else if (error) {
        DLog(@"Core Data Manipulating Error = %@",[error localizedDescription]);
    }
    else{
        
    }
    return NO;
}

@end
