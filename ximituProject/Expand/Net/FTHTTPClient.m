//
//  FTHTTPClient.m
//  LastMilesCommunity
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 lastmiles. All rights reserved.
//

#import "FTHTTPClient.h"
#import "FTNetworkQueue.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
//#import "MySingleton.h"

static FTHTTPClient *_sharedClient = nil;

@implementation FTHTTPClient
//网络连接类单例
+ (FTHTTPClient *)shareClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[FTHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"www.baidu.com"]];
    });
    return _sharedClient;
}

- (void)requestWithPath:(NSString *)path dao:(FTBaseRemoteDAO *)dao andMethod:(NSString *)method
{
    [self requestWithPath:path parameters:nil dao:dao andMethod:method];
}

- (void)requestWithPath:(NSString *)path parameters:(NSDictionary *)params dao:(FTBaseRemoteDAO *)dao andMethod:(NSString *)method
{
    //    NSLog(@"---%@",params);
    // type请求的数据类型
    [self requestWithMethod:method path:path targetPath:nil parameters:params dao:dao type:FTRequestTypeJSON];
}


///网络请求的方法，需要定义method(POST,GET,HEAD...) path(相对路径) params(参数表)
/// type(请求资源的类型)
- (void)requestWithMethod:(NSString *)method path:(NSString *)path targetPath:(NSString *)target parameters:(NSDictionary *)params dao:(FTBaseRemoteDAO *)dao type:(int)requestType
{
    
    NSString *fullPath = @"";
    
    //    if ([MySingleton sharedSingleton].isSelectList) {
    //        fullPath = [NSString stringWithFormat:@"http://%@/%@",KFTListBaseUrl,path];
    //    }else {
    //
    //    }
    fullPath = [NSString stringWithFormat:@"http://%@/%@",kFTBaseURL,path];
    
    DLog(@"%@ \n%@",fullPath,params);
    
    switch (requestType) {
            //请求为json数据
        case FTRequestTypeJSON:
        {
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            
            if ([method isEqualToString:@"GET"]) {
                [manager GET:fullPath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //把收到的responseObject 转换一下编码 并转换成字符串（登陆接口会将空行转换成<br/>,所以需要将<br/>转换成空字符串）
                    NSString *JSON = [[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding] replace:@"<br/>" to:@""];
                    //                NSString *jj = [JSON ]
                    //                NSLog(@"%@",JSON);
                    if (JSON!=nil &&JSON.length>0) {
                        JSON = [JSON substringFromIndex:[JSON rangeOfString:@"{"].location];
                        
                    }
                    //转换成data
                    NSData *data =  [JSON dataUsingEncoding:NSUTF8StringEncoding];
                    
                    //转换成字典
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:nil];
                    
                    
                    [dao didReceiveJSONResponse:dic forRequest:path];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    //请求失败
                    DLog(@"error: %@", error);
                    
                    [dao didReceiveJSONResponse:nil forRequest:path];
                }];
            }else {
                [manager POST:fullPath parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //把收到的responseObject 转换一下编码 并转换成字符串（登陆接口会将空行转换成<br/>,所以需要将<br/>转换成空字符串）
                    NSString *JSON = [[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding] replace:@"<br/>" to:@""];
                    //                NSString *jj = [JSON ]
                    //                NSLog(@"%@",JSON);
                    if (JSON!=nil &&JSON.length>0) {
                        JSON = [JSON substringFromIndex:[JSON rangeOfString:@"{"].location];
                        
                    }
                    //转换成data
                    NSData *data =  [JSON dataUsingEncoding:NSUTF8StringEncoding];
                    
                    //转换成字典
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:nil];
                    
                    
                    [dao didReceiveJSONResponse:dic forRequest:path];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    //请求失败
                    DLog(@"error: %@", error);
                    
                    [dao didReceiveJSONResponse:nil forRequest:path];
                }];
            }
            
            
            
            
            
            
            
        }
            break;
        case FTRequestTypeXML: //请求为xml数据
        {
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            //            NSDictionary *dict = @{@"format":@"xml"};
            
            [manager POST:fullPath parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                /**
                 *  结果是XML，需要做处理
                 */
                NSLog(@"receive xml data:%@",responseObject);
                [dao didReceiveJSONResponse:nil forRequest:path];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"error:%@",error);
                [dao didReceiveJSONResponse:nil forRequest:path];
            }];
        }
            break;
        case FTRequestTypeImage: //请求为图片数据
        {
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            [manager POST:fullPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                // 在此位置生成一个要上传的数据体
                // form对应的是html文件中的表单
                
                UIImage *image = params[@"image"];
                NSData *data = UIImagePNGRepresentation(image);
                
                // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                // 要解决此问题，
                // 可以在上传时使用当前的系统时间作为文件名
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                
                
                /*
                 此方法参数
                 1. 要上传的[二进制数据]
                 2. 对应网站上[upload.php中]处理文件的[字段"file"]
                 3. 要保存在服务器上的[文件名]
                 4. 上传文件的[mimeType]
                 */
                [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //把收到的responseObject 转换一下编码 并转换成字符串（登陆接口会将空行转换成<br/>,所以需要将<br/>转换成空字符串）
                NSString *JSON = [[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding] replace:@"<br/>" to:@""];
                
                //转换成data
                NSData *data =  [JSON dataUsingEncoding:NSUTF8StringEncoding];
                
                //转换成字典
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
                //                     DLog(@"JSON: %@", dic);
                [dao didReceiveJSONResponse:dic forRequest:path];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"上传失败->%@", error);
                [dao didReceiveJSONResponse:nil forRequest:path];
            }];
        }
            break;
        case FTRequestTypePropertyList: //请求为plist数据
        {
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
            manager.responseSerializer = [AFPropertyListResponseSerializer serializer];
            [manager POST:fullPath parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DLog(@"responseObject:%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                ELog(error);
            }];
        }
            break;
        case FTRequestTypeDownLoad: //请求为文件下载数据
        {
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fullPath]];
            NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                //回传下载进度
                NSLog(@"progress:%@",downloadProgress);
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                NSURL *documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                
                return [documentsDirectory URLByAppendingPathComponent:[response suggestedFilename]];
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                
                NSLog(@"File downloaded to:%@",filePath);
            }];
            [downloadTask resume];
        }
            break;
        default:
            break;
    }
}

@end
