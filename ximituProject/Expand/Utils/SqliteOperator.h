//
//  SqliteOperator.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface SqliteOperator : NSObject{
    
    //SQLite3的对象
    sqlite3 *database;
    
    //查询的列数 即字段数
    NSUInteger colnum;
}
@property(nonatomic)NSUInteger colnum;

/**
 *  打开数据库
 */
-(BOOL)openDatabase:(NSString *)dbpath;

/**
 *  创建数据表
 */
-(BOOL)createTable:(NSString *)sql;

/**
 *  执行无结果集操作（插入，删除，更新）
*/
-(BOOL)execNoResult:(NSString *)sql;

/**
 *  执行有结果集（查询）
 */
-(NSMutableArray *)execResult:(NSString *)sql;

/**
 *  关闭数据库
*/
-(BOOL)close;

@end
