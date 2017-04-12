//
//  FTDBManager.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//


#define kLYDataBaseQueryError @"数据库查询错误"
#define kLYDataBaseInsertError @"数据库插入错误"
#define kLYDataBaseRemoveError @"数据库删除错误"
#define kLYDataBaseUpdateError @"数据库更新错误"


#import "FTBaseManager.h"

@class NSManagedObjectContext;
@interface FTDBManager : FTBaseManager


@property (readonly, strong, nonatomic) NSManagedObjectContext *backgroundObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 保存当前的上下文
 */
- (void)saveContext;
/**
 保存操作之后的结果
 */
- (BOOL)save;
/**
 返回document directory
 */
- (NSURL *)applicationDocumentsDirectory;
/**
 获取单例
 */
+(FTDBManager *)sharedManager;

/**
 获取上下文
 */
- (NSManagedObjectContext *)managedObjectContext;
/**
 向数据库中插入某一类对象
 */
- (BOOL)insertNewObjectOfEntity:(NSString *)entityName fromDictionary:(NSDictionary *)jsonDict;

/**
 按照谓词从数据库中获取对象的数组，并按照指定的顺序排序
 */
- (NSArray *)fetchObjectsOfEntity:(NSString *)entityName withPredicateStr:(NSString *)pre sortDescriptor:(NSSortDescriptor *)sort;

/**
 按照谓词从数据库删除符合条件的对象
 */
- (BOOL)removeObjectsOfEntity:(NSString *)entityName withPredicateStr:(NSString *)pre;

/**
 按照谓词更新数据库中符合条件的对象
 */
- (NSArray *)updateObjectsOfEntity:(id)obj withPredicateStr:(NSString *)p;

@end
