//
//  SqliteOperator.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "SqliteOperator.h"

@implementation SqliteOperator
@synthesize colnum;
//打开数据库,参数 dbpath 类型（NSString *） 数据库路径，有该数据库，打开，没有则创建，成功 返回YES，否则，返回NO
-(BOOL) openDatabase:(NSString*)dbpath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:dbpath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL find = [fileManager fileExistsAtPath:path];
    
    //找到数据库文件mydb.sql
    if (find)
    {
        if(sqlite3_open([path UTF8String], &database) != SQLITE_OK) {
            
            sqlite3_close(database);
            
            return NO;
        }
        return YES;
    }
    if(sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        
        return YES;
    }
    else {
        
        sqlite3_close(database);
        
        return NO;
    }
    return NO;
    
}

//创建数据库,参数 sql 创建表的SQL语句，成功 返回YES，否则，返回NO
-(BOOL)createTable:(NSString *)sql
{
    sqlite3_stmt *statement;
    
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) != SQLITE_OK) {
        
        return NO;
    }
    
    int success = sqlite3_step(statement);
    
    sqlite3_finalize(statement);
    
    if ( success != SQLITE_DONE) {
        
        return NO;
    }
    
    return YES;
}

//执行无结果集操作（插入，删除，更新）参数 sql 类型(char*)，SQL语句 成功 返回YES，否则，返回NO
-(BOOL)execNoResult:(NSString *)sql
{
    char *errorMsg=NULL;
    
    if (sqlite3_exec(database, [sql UTF8String], 0, NULL, &errorMsg)==SQLITE_OK) {
        
        return YES;
    }
    else {
        
        sqlite3_free(errorMsg);
        
        return NO;
    }
}
//执行有结果集（查询）参数，sql 类型（NSString *），SQL语句
//成功，返回结果集（NSMutableArray*）类型 失败，返回NO
-(NSMutableArray *)execResult:(NSString *)sql
{
    
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];//所有记录
    
    sqlite3_stmt *statement = nil;
    
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        
        colnum=sqlite3_column_count(statement);
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSMutableArray *row = [[NSMutableArray alloc] init];
            
            NSString *rescount=[NSString stringWithFormat:@"%d",sqlite3_column_count(statement)];
            NSLog(@"%@",rescount);
            
            for(int i=0; i<sqlite3_column_count(statement); i++){
                
                NSString  *filedata=[[NSString alloc]init];
                
                if ((char *)sqlite3_column_text(statement, i)!=NULL) {
                    
                    filedata=[NSString stringWithCString:(char *)sqlite3_column_text(statement, i) encoding:NSUTF8StringEncoding];
                    
                    [row addObject:filedata];
                    
                } else{
                    
                    [row addObject:@" "];
                }
                
            }
            
            [returnArray addObject:row];
        }
    }
    else {
        
        NSLog(@"查询失败");
        
        return nil;
    }
    
    sqlite3_finalize(statement);
    
    return returnArray;
}

//关闭数据库，成功 返回YES，否则，返回NO

-(BOOL)close
{
    if ( sqlite3_close(database)!=SQLITE_OK) {
        
        return NO;
    }
    
    return YES;
    
}

@end
