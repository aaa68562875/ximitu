//
//  AFMultipartFormData.h
//  XingSiluSend
//
//  Created by 周良才 on 15/11/1.
//  Copyright © 2015年 Wanrongtong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  上传图片到服务器
 *
 *
 */
/*
 调用
 
 NSData *imageData = UIImagePNGRepresentation(editedImage);
 NSString *url = [NSString stringWithFormat:@"http://%@/%@",kFTBaseURL,kFTSendFileToServer];
 
 FileDetail *file = [FileDetail fileWithName:@"head.jpg" data:imageData];
 NSDictionary *params = @{@"file":file};
 NSDictionary *result = [AFMultipartFormData upload:url widthParams:params];
 NSString *statusCode = [NSString stringWithFormat:@"%@",result[@"code"]];
 NSLog(@"---- %@",result);
 if ([statusCode isEqualToString:@"000000"]) {
 NSString *pic_id = [NSString stringWithFormat:@"%@",result[@"id"]];
 [_headImg sd_setImageWithURL:[NSURL URLWithString:result[@"data"][@"url"]] placeholderImage:editedImage];
 
 [self.bl sendPictureIdToServerWithId:pic_id];
 }else{
 [self showHUDWithText:@"上传失败"];
 }

 */

@interface AFMultipartFormData : NSObject

+(id)upload:(NSString *)url widthParams:(NSDictionary *)params;

@end

@interface FileDetail : NSObject

@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSData *data;
+(FileDetail *)fileWithName:(NSString *)name data:(NSData *)data;

@end