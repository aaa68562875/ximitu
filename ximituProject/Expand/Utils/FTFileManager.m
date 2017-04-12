//
//  FTFileManager.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTFileManager.h"

@implementation FTFileManager
+ (FTFileManager *)sharedManager
{
    
    static FTFileManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[FTFileManager alloc] init];
    });
    return _sharedManager;
}

- (BOOL)fileExistsAtPath:(NSString *)path
{
    return [super fileExistsAtPath:path];
}

- (NSArray *)filesListUnderDirectory:(NSString *)dir
{
    return [self contentsOfDirectoryAtPath:dir error:nil];
}

- (BOOL)writeFile:(id)data toPath:(NSString *)path
{
    return [self writeFile:data toPath:path option:NSDataWritingFileProtectionNone];
}

- (BOOL)writeFile:(id)data toPath:(NSString *)path option:(NSDataWritingOptions)option
{
    NSError *error = nil;
    BOOL success= [data writeToFile:path options:option error:&error];
    if (success) {
        return YES;
    }
    return NO;
}

- (BOOL)removeItemAtPath:(NSString *)path
{
    NSError *error = nil;
    BOOL success= [super removeItemAtPath:path error:&error];
    if (error) {
        
    }
    return success;
}

- (BOOL)createDirectoryAtPath:(NSString *)path withSubPath:(NSString *)subPath
{
    BOOL success = [self createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",path,subPath]
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:nil];
    return success;
}


#pragma mark - 常用路径

- (NSString *)rootDBDirectory
{
    NSString *documentDirectory = [self documentDirectory];
    return [documentDirectory stringByAppendingPathComponent:kFTDBSubPath];
}

- (NSString *)commonImageCacheDirectory
{
    NSString *rootCacheDirectory = [self rootCacheDirectory];
    return [rootCacheDirectory stringByAppendingPathComponent:kFTImageCacheSubPath];
}

- (NSString *)hdImageCacheDirectory
{
    NSString *rootCacheDirectory = [self rootCacheDirectory];
    return [rootCacheDirectory stringByAppendingPathComponent:kFTHDImageCacheSubPath];
}

- (NSString *)fileCacheDirectory
{
    NSString *rootCacheDirectory = [self rootCacheDirectory];
    return [rootCacheDirectory stringByAppendingPathComponent:kFTListCacheSubPath];
}


- (NSString *)rootCacheDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

- (NSString *)documentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (BOOL)createDownloadFileDirectory
{
    NSMutableString *filePath = [NSMutableString stringWithString:[[FTFileManager sharedManager] fileCacheDirectory]];
    if (![[FTFileManager sharedManager] fileExistsAtPath:filePath]) {
        NSError *error = nil;
        [[FTFileManager sharedManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"download file directory create fail error: %@",[error localizedDescription]);
            return NO;
        }
        
    }
    return YES;
}

- (float) totalCacheSize
{
    float totalSize = 0.0f;
    if ([self fileExistsAtPath:[self commonImageCacheDirectory]]) {
        totalSize+=[self folderSizeAtPath:[self commonImageCacheDirectory]];
    }
    
    if ([self fileExistsAtPath:[self hdImageCacheDirectory]]) {
        totalSize+=[self folderSizeAtPath:[self hdImageCacheDirectory]];
    }
    
    if ([self fileExistsAtPath:[self fileCacheDirectory]]) {
        totalSize+=[self folderSizeAtPath:[self fileCacheDirectory]];
    }
    return totalSize;
}

- (BOOL) clearAllCaches
{
    
    NSDirectoryEnumerator *dirEnum1 = [self enumeratorAtPath:[self commonImageCacheDirectory]];
    NSString *fileName1;
    NSError *error1 = nil;
    while (fileName1= [dirEnum1 nextObject]) {
        NSString *pathName1 =[NSString stringWithFormat:@"%@/%@",[self commonImageCacheDirectory],fileName1];
        [[FTFileManager sharedManager] removeItemAtPath:pathName1 error:&error1];
    }
    NSDirectoryEnumerator *dirEnum2 = [[FTFileManager sharedManager] enumeratorAtPath:[self fileCacheDirectory]];
    NSString *fileName2;
    NSError *error2 = nil;
    while (fileName2= [dirEnum2 nextObject]) {
        NSString *pathName2 =[NSString stringWithFormat:@"%@/%@",[self fileCacheDirectory],fileName2];
        [[FTFileManager sharedManager] removeItemAtPath:pathName2 error:&error2];
    }
    NSDirectoryEnumerator *dirEnum3 = [[FTFileManager sharedManager] enumeratorAtPath:[self hdImageCacheDirectory]];
    NSString *fileName3;
    NSError *error3 = nil;
    while (fileName3= [dirEnum3 nextObject]) {
        NSString *pathName3 =[NSString stringWithFormat:@"%@/%@",[self hdImageCacheDirectory],fileName3];
        [[FTFileManager sharedManager] removeItemAtPath:pathName3 error:&error3];
    }
    if (error1) {
        NSLog(@"image remove = %@",[error1 localizedDescription]);
        return NO;
    }
    if (error2) {
        NSLog(@"file remove = %@",[error2 localizedDescription]);
        return NO;
    }
    if (error3) {
        NSLog(@"image remove = %@",[error3 localizedDescription]);
        return NO;
    }
    return YES;
}
- (id)readFileFromPath:(NSString *)path
{
    
    return self;
}

/**
 *  数组写入本地plist
 */
- (void)writeArrayToPlistFileWithData:(NSArray *)data andFileName:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths     objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    [data writeToFile:filename  atomically:YES];
}
/**
 *  读取本地plist文件
 */
- (NSArray *)readDataFromPlistWithFileName:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filename1 = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:filename1];
    return data;
}
/**
 *  判断plist文件存在
 */
- (BOOL)judgePlistFileExistOfFileName:(NSString *)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //Get documents directory
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];
    NSString *filename1=[documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    
    if ([fileManager fileExistsAtPath:filename1]==YES) {
        return YES;
    }
    return NO;
}

@end
