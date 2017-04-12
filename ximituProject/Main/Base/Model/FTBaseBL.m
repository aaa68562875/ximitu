//
//  FTBaseBL.m
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#import "FTBaseBL.h"
#import "FTDBManager.h"
@implementation FTBaseBL

- (id)init {
  if (self = [super init]) {
    if (self.remoteDao == nil) {
      self.remoteDao = [[FTBaseRemoteDAO alloc] init];
      self.remoteDao.delegate = self;
//        NSOrderedSet
    }
  }
  return self;
}

#pragma
#pragma mark - remoteDAO delegate
/*
 对message,statusCode,做初步处理
 */
- (void)didGetJSONResponse:(id)JSON forRequest:(NSString *)request {
  if ([self.delegate respondsToSelector:@selector(hideHUD)]) {
    [self.delegate performSelector:@selector(hideHUD)];
  }

  //隐藏网络风火轮
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

  ///返回数据为空
  if (JSON == nil) {
      Diss;
    [self.delegate showConnectionFailureView];
    [self.delegate showHUDWithText:@"网络连接失败，请检测网络"];
//      [self.delegate hideHUD];
    return;
  }
  ///返回数据成功
//    DLog(@"底层JSON：%@",JSON);
    if ([request isEqualToString:kFTHomeCategoryGoods] || [request isEqualToString:kFTCarousel]|| [request isEqualToString:kFTFCategory]|| [request isEqualToString:kFTCartList]|| [request isEqualToString:kFTConsumerInfo]|| [request isEqualToString:kFTGetSysArticleListByCategory]|| [request isEqualToString:kFTShopCartAddNum]|| [request isEqualToString:kFTDelGoods]) {
        [self.delegate hideConnectionFailureView];
        [self processJSONResponse:JSON forRequest:request];
    }else{
        if ([[NSString stringWithFormat:@"%@", [JSON valueForKey:@"code"]]isEqualToString:@"SUCCESS"]) {
            
            [self.delegate hideConnectionFailureView];
            if ([JSON valueForKey:@"data"] != nil) {
                [self processJSONResponse:[JSON valueForKey:@"data"] forRequest:request];
            } else {
                [self processJSONResponse:JSON forRequest:request];
            }
        }else {// 发生服务器数据错误，或者表单提交错误，返回服务器返回的错误
            
            id msg = [JSON valueForKey:@"msg"];
            if (msg == [NSNull null] || [msg isEqualToString:@"(null)"] || msg == nil || ((NSString *)msg).length == 0) {
                msg = @"网络连接失败，请检测网络";
            }
            //            [self.delegate showHUDWithText:JSON[@"msg"]];
            
            //            UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            //            while (topRootViewController.presentedViewController)
            //            {
            //                topRootViewController = topRootViewController.presentedViewController;
            //            }
            //            [topRootViewController.view makeToast:msg duration:2 position:CSToastPositionCenter];
            Fail(msg);
            NSLog(@"msg:%@  request:%@", msg,request);
    }
    
    }
  
}

//处理 返回状态信息  显示时间
- (void)showHudWithText:(NSString *)msg {
  [self.delegate showHUDWithText:msg];
}

//给子类继承的方法,子类根据类型做细化的处理
- (void)processJSONResponse:(id)JSON forRequest:(NSString *)request {
}
/**
 网络连接错误时的数据返回接口
 */
- (void)connectionFail {
  if ([self.delegate respondsToSelector:@selector(hideHUD)]) {
    [self.delegate performSelector:@selector(hideHUD)];
  }
  if ([self.delegate respondsToSelector:@selector(showHUDWithText:)]) {
    [self.delegate showHUDWithText:kFTUserAlertNetworkNotAvailable];
  }
  [self.delegate showConnectionFailureView];
}

// 将JSON串转化为字典或者数组
- (id)toArrayOrNSDictionary:(NSData *)jsonData {
  NSError *error = nil;
  id jsonObject =
      [NSJSONSerialization JSONObjectWithData:jsonData
                                      options:NSJSONReadingAllowFragments
                                        error:&error];

  if (jsonObject != nil && error == nil) {
    return jsonObject;
  } else {
    // 解析错误
    return nil;
  }
}

#pragma
#pragma mark - object reflection methods
- (BOOL)reflectArray:(NSArray *)arr toManagedObject:(NSString *)entityName {
  for (int i = 0; i < arr.count; i++) {
    NSDictionary *dict = [arr objectAtIndex:i];
    [[FTDBManager sharedManager] insertNewObjectOfEntity:entityName
                                          fromDictionary:dict];
  }
  return YES;
}

- (BOOL)reflectDictionary:(NSDictionary *)dic
          toManagedObject:(NSString *)entityName {
  BOOL success = [[FTDBManager sharedManager] insertNewObjectOfEntity:entityName
                                                       fromDictionary:dic];
  return success;
}

- (NSArray *)parseArray:(NSArray *)arr withClass:(NSString *)className {
  DCKeyValueObjectMapping *parser =
      [DCKeyValueObjectMapping mapperForClass:NSClassFromString(className)];
  NSArray *parsedArr = [parser parseArray:arr];
  return parsedArr;
}

- (NSDictionary *)parseDictionary:(NSDictionary *)dic
                        withClass:(NSString *)className {
  DCKeyValueObjectMapping *parser =
      [DCKeyValueObjectMapping mapperForClass:NSClassFromString(className)];
  NSDictionary *parsedDic = [parser parseDictionary:dic];
  return parsedDic;
}

- (NSArray *)addManagedObject:(NSString *)entityName
                    withArray:(NSArray *)arr
                    predicate:(NSString *)pre
               sortDescriptor:(NSSortDescriptor *)descriptor {
  ///把数组中的元素插入到数据库中
  for (int i = 0; i < arr.count; i++) {
    NSDictionary *dic = [arr objectAtIndex:i];
    [[FTDBManager sharedManager] insertNewObjectOfEntity:entityName
                                          fromDictionary:dic];
  }
  ///插入完成后返回被插入的数据
  return [[FTDBManager sharedManager] fetchObjectsOfEntity:entityName
                                          withPredicateStr:nil
                                            sortDescriptor:descriptor];
}

- (NSArray *)updateManagedObject:(NSString *)entityName
                       withArray:(NSArray *)arr
                       predicate:(NSString *)pre
                  sortDescriptor:(NSSortDescriptor *)descriptor {
  ///查看数据库是否存在该种元素
  NSArray *objs = [[FTDBManager sharedManager] fetchObjectsOfEntity:entityName
                                                   withPredicateStr:pre
                                                     sortDescriptor:nil];
  ///如果元素不为空,删除所有的该种元素
  BOOL success = NO;
  if (objs != nil) {
    success = [[FTDBManager sharedManager] removeObjectsOfEntity:entityName
                                                withPredicateStr:pre];
  }
  //    while (1) {
  //        if (success) break;
  //    }
  ///把数组中的元素插入到数据库中
  for (int i = 0; i < arr.count; i++) {
    NSDictionary *dic = [arr objectAtIndex:i];
    [[FTDBManager sharedManager] insertNewObjectOfEntity:entityName
                                          fromDictionary:dic];
  }
  ///插入完成后返回被插入的数据
  return [[FTDBManager sharedManager] fetchObjectsOfEntity:entityName
                                          withPredicateStr:nil
                                            sortDescriptor:descriptor];
}

- (NSArray *)updateManagedObject:(NSString *)entityName
                  withDictionary:(NSDictionary *)dic
                       predicate:(NSString *)pre {
  ///查看数据库是否存在该种元素
  NSArray *objs = [[FTDBManager sharedManager] fetchObjectsOfEntity:entityName
                                                   withPredicateStr:pre
                                                     sortDescriptor:nil];
  ///如果元素不为空,删除所有的该种元素
  if (objs != nil) {
    [[FTDBManager sharedManager] removeObjectsOfEntity:entityName
                                      withPredicateStr:pre];
  }
  ///把字典转化为一个元素插入到数据库中
  [[FTDBManager sharedManager] insertNewObjectOfEntity:entityName
                                        fromDictionary:dic];
  ///插入完成后返回被插入的数据
  return [[FTDBManager sharedManager] fetchObjectsOfEntity:entityName
                                          withPredicateStr:nil
                                            sortDescriptor:nil];
}

@end
