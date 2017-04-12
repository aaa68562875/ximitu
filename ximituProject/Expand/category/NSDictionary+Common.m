//
//  NSDictionary+Common.m
//  XingSiluSend
//
//  Created by zlc on 15/9/1.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "NSDictionary+Common.h"

@implementation NSDictionary (Common)

-(id)keyForValue:(id)value
{
    return [[self allKeysForObject:value] lastObject];
}

//判断对应词典中有对应key的Value
- (BOOL)isContainKey:(NSString *)key{
    for (NSString *obj in self.allKeys) {
        if ([obj isEqualToString:key]) {
            return YES;
        }
    }
    
    return NO;
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSString *)getValueForKey:(NSString *)key{
    for (NSString *obj in self.allKeys) {
        if ([obj isEqualToString:key]) {
            
            return self[key];
        }
    }
    
    return @"";
}

//判断对应词典中有对应的Value
- (BOOL)isContainVaue:(NSString *)value{
    for (NSString *obj in self.allValues) {
        if ([obj isEqualToString:value]) {
            return YES;
        }
    }
    
    return NO;
    
}

- (NSString *)keyOfValue:(NSString *)value{
    NSString * KEY = @"";
    for (NSString * key in self.allKeys) {
        if ([value isEqualToString:self[key]]) {
            KEY = key;
            NSLog(@"hehe %@",KEY);
            break;
        }
    }
    return KEY;
}

- (NSMutableArray *)getArrayFromDictionary{
    
    NSMutableArray *array = [NSMutableArray array];
    for (id obj in self.allValues) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [array addObject:obj];
        }
    }
    
    return array;
}



@end

@implementation NSMutableDictionary(Common)

/**
 将一个int给字典赋值
 将会将int转换为字符串
 @param value 值
 @param key 键
 */
-(void)setInt:(int)value forKey:(NSString*)key
{
    [self setObject:[NSString stringWithFormat:@"%d",value] forKey:key];
}
/**
 将一个float给字典赋值
 将会将float转换为字符串
 @param value 值
 @param key 键
 */
-(void)setFloat:(float)value forKey:(NSString*)key
{
    [self setObject:[NSString stringWithFormat:@"%f",value] forKey:key];
}

-(void)setDouble:(double)value forKey:(NSString *)key
{
    [self setObject:[NSString stringWithFormat:@"%f",value] forKey:key];
}



@end


@interface NSCacheMutableDicionary ()

///用于存储数据的dictionary
@property (nonatomic,retain) NSMutableDictionary *dictionary;

-(NSMutableDictionary*)readableDictionary;
@end

@implementation NSCacheMutableDicionary

- (id)init
{
    self = [super init];
    if (self) {
        [self loadDictionary];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveDictionary) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveDictionary) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    self.dictionary=nil;
    
}

///返回可读的dictionary, dictionary会在收到内存警告时从内存中移除
-(NSMutableDictionary*)readableDictionary
{
    if (self.dictionary==nil) {
        [self loadDictionary];
    }
    return self.dictionary;
}

-(void)loadDictionary
{
    self.dictionary=[NSMutableDictionary dictionaryWithContentsOfFile:self.cachePath];
    if (self.dictionary==nil) {
        self.dictionary=[NSMutableDictionary dictionary];
    }
}

-(void)saveDictionary
{
    [self.dictionary writeToFile:self.cachePath atomically:YES];
    self.dictionary=nil;
}

-(void)setObject:(id)object forKey:(id<NSCopying>)aKey
{
    [self.readableDictionary setObject:object forKey:aKey];
}

-(id)objectForKey:(id<NSCopying>)aKey
{
    return [self.readableDictionary objectForKey:aKey];
}

-(NSString*)cachePath
{
    NSString *cacheDir=[NSString stringWithFormat:@"%@/Documents/Cache/",NSHomeDirectory()];
    BOOL isDir=NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheDir isDirectory:&isDir]==NO||isDir==NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [NSString stringWithFormat:@"%@/cache.cache",cacheDir];
}

+(id)shareCache
{
    static id instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[[self class] alloc] init];
    });
    return instance;
}
@end

