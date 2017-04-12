//
//  FTFileManager.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

#define kFTDBSubPath @"FTDB.sqlite"
#define kFTListCacheSubPath @"FTListCache"
#define kFTImageCacheSubPath @"JMCache"
#define kFTHDImageCacheSubPath @"com.hackemist.SDWebImageCache.default"
@interface FTFileManager : NSFileManager
/**
 获取单例
 */
+ (FTFileManager *)sharedManager;

/**
 文件是否存在路径下
 */
- (BOOL)fileExistsAtPath:(NSString *)path;

/**
 数据库根路径
 */
- (NSString *)rootDBDirectory;

/**
 缓存根路径
 */
- (NSString *)rootCacheDirectory;

/**
 缓存列表路径
 */
- (NSString *)fileCacheDirectory;

/**
 缓存素材图片路径
 */
- (NSString *)commonImageCacheDirectory;

/**
 缓存高清图片路径
 */
- (NSString *)hdImageCacheDirectory;

/**
 文件路径
 */
- (NSString *)documentDirectory;


/**
 在某路径下创建子路径
 */
- (BOOL)createDirectoryAtPath:(NSString *)path withSubPath:(NSString *)subPath;

/**
 把数据写到某路径下
 */
- (BOOL)writeFile:(id)data toPath:(NSString *)path;

/**
 从某路径获取数据
 */
- (id)readFileFromPath:(NSString *)path;

/**
 将某路径下的文件清除
 */
- (BOOL)removeItemAtPath:(NSString *)path;

/**
 *  获取路径下文件大小
 */
- (float ) folderSizeAtPath:(NSString*) folderPath;

/**
 *  获取缓存总大小
 */
- (float) totalCacheSize;

/**
 *  清除所有缓存
 */
- (BOOL) clearAllCaches;


/**
 *  创建下载文件的存放路径
 */
- (BOOL)createDownloadFileDirectory;

//---------------------------将数组写入本地plist文件
/**
 *  数组写入本地plist
 */
- (void)writeArrayToPlistFileWithData:(NSArray *)data andFileName:(NSString *)fileName;
/**
 *  读取本地plist文件
 */
- (NSArray *)readDataFromPlistWithFileName:(NSString *)fileName;
/**
 *  判断plist文件存在
 */
- (BOOL)judgePlistFileExistOfFileName:(NSString *)fileName;
//-----------------------------------------------------
@end
