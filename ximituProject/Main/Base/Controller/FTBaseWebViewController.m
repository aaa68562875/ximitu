//
//  FTBaseWebViewController.m
//  new
//
//  Created by 王知 on 2016/11/28.
//  Copyright © 2016年 Wanrongtong. All rights reserved.
//

#import "FTBaseWebViewController.h"
#import "FTHomeViewController.h"
#import <UIImageView+WebCache.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "PaymentManager.h"
#import "FTRootTabBarController.h"

#import <UIImage+GIF.h>

@interface FTBaseWebViewController ()<UIWebViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *aniView;

@property (strong, nonatomic) UIImageView *flameAnimation;

@property (strong, nonatomic) NSString *uploadPath;

@property (strong, nonatomic) NSDictionary *dicInfo;

@property (strong, nonatomic) NSString *type;

/** 加载失败 */
@property (strong, nonatomic) UIImageView *loadFailImageView;

@end

@implementation FTBaseWebViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    HIDE_KEYBOARD();
    [self cleanCacheAndCookie];
    if ([[FTAccountManager sharedManager].dicInfo[@"data"][@"callBack"] isEqualToString:@"refreshLoad"]) {
        JSValue *refresh = self.jsContext[[FTAccountManager sharedManager].dicInfo[@"data"][@"callBack"]];
        [refresh callWithArguments:@[]];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //释放资源,防止闪退
    self.webView.delegate = nil;
    [self cleanCacheAndCookie];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebView];
}


- (void)initPlaceHolderView {
    self.view.backgroundColor = WhiteColor;
    _topView = [[UIView alloc] initWithFrame:FRAME(0, 0, kFTScreenWidth, 64)];

    UIView *lineView = [[UIView alloc] initWithFrame:FRAME(0, 63, kFTScreenWidth, 1)];
    lineView.backgroundColor = UIColorGromRGBV(237, 237, 239);
    [_topView addSubview:lineView];
    
    UIView *backView = [[UIView alloc] initWithFrame:FRAME(6, 10, 72, 48)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:FRAME(17, 20, 10, 20)];
    imageView.image = IMAGE(@"顶部返回");
    [backView addSubview:imageView];
    
    [_topView addSubview:backView];
    
    GESTURE_TAP(backView, @selector(backViewVC));
    
    [self.view addSubview:_topView];
    
    
    self.flameAnimation = [[UIImageView alloc] init];
    
    self.flameAnimation.bounds = FRAME(0, 0, 107, 107);
    self.flameAnimation.center = self.view.center;
    

    _flameAnimation.image = [UIImage sd_animatedGIFNamed:@"【签到中】【兑换中】动图"];
    

    [self.view addSubview:_flameAnimation];
}


#pragma mark - private method
- (void)initWebView {
    
    UIView *view = [[UIView alloc] initWithFrame:FRAME(0, 0, kFTScreenWidth, 20)];
    view.backgroundColor = ClearColor;
    [self.view addSubview:view];
    [self initPlaceHolderView];
    self.webView = [[UIWebView alloc] initWithFrame:FRAME(0, CGRectGetMaxY(view.frame), kFTScreenWidth, kFTScreenHeight - 20)];
    self.webView.hidden = YES;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self.webUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    [self.webView loadRequest:request];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.webView];
    
    

}

- (void)openGallery {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从手机相册选择" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
}

- (void)openCameraOrPhoto {
    [self openGallery];
}

/**清除缓存和cookie*/
- (void)cleanCacheAndCookie{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}


- (void)call:(NSString *)phoneNumber {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_S(@"tel:%@",phoneNumber)]];
}


- (void)uploadImage {
    Load(@"上传中...");
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = self.uploadPath;
//    NSString *url = @"http://192.168.1.111:7301/systemControl/upload";
    [manager POST:url parameters:@{@"type":self.type} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:self.imageData
                                    name:@"file"
                                fileName:@"fileName1.jpg"
                                mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Diss;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:noErr error:nil];
        NSLog(@"%@",dic);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            JSValue *imageCallBack = self.jsContext[self.imageCallBack];
            NSLog(@"%@",dic[@"path"]);
            [imageCallBack callWithArguments:@[dic[@"path"]]];
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Diss;
        Fail(@"上传失败");
        DLog(@"--%@",error.localizedDescription);
    }];
}

- (void)startLocation {
    _locService = [[BMKLocationService alloc] init];
    _search = [[BMKGeoCodeSearch alloc] init];
    _locService.delegate = self;
    _search.delegate = self;
//    [self showLoadingHUD];
    //启动定位
    [_locService startUserLocationService];
}


#pragma mark - BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    self.coordinate2D = userLocation.location.coordinate;
    
    CGFloat latitude = userLocation.location.coordinate.latitude;
    CGFloat longitude = userLocation.location.coordinate.longitude;
    
    
    NSLog(@"%f---%f",latitude, longitude);
    
    [self reverseGeoCodeResultWithLatitude:latitude andLongtitude:longitude andCoordinate:userLocation.location.coordinate];
}

/** 定位失败 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    [self hideHUD];
    DLog(@"定位失败:%@",error.localizedDescription);
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == 0) {
        [self hideHUD];
        _address = result.addressDetail;
        NSLog(@"%@---%@---%@",_address.province, _address.city, _address.district);
        
        
        JSValue *LocationCallBack = self.jsContext[@"LocationCallBack"];
        [LocationCallBack callWithArguments:@[_S(@"%@%@%@",self.address.province, self.address.city, self.address.district)]];
        [_locService stopUserLocationService];
        _locService.delegate = nil;
        _search.delegate = nil;
    }
}

//反地理编码出地理位置
- (void)reverseGeoCodeResultWithLatitude:(CGFloat)__latitude
                           andLongtitude:(CGFloat)__longtitude
                           andCoordinate:(CLLocationCoordinate2D)coord
{
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){ 0, 0 };
    pt = (CLLocationCoordinate2D){ __latitude, __longtitude };
    self.coordinate2D = coord;
    if (!option) {
        option = [[BMKReverseGeoCodeOption alloc] init];
    }
    option.reverseGeoPoint = coord;
    
    BOOL flag = [_search reverseGeoCode:option];
    if (flag) {
        
    }
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"TIO"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    self.webView.frame = FRAME(0, 20, kFTScreenWidth, kFTScreenHeight - 20);
    self.webView.hidden = NO;
    [self.topView removeFromSuperview];
    [self.flameAnimation removeFromSuperview];
    [self hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    [self hideHUD];
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
    }
    return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"-----%@",error.localizedDescription);
    [self.flameAnimation setHidden:YES];
    self.loadFailImageView = [[UIImageView alloc] init];
    
    self.loadFailImageView.bounds = FRAME(0, 0, 128, 114);
    self.loadFailImageView.center = self.view.center;
    self.loadFailImageView.image = IMAGE(@"加载失败(1)");
    GESTURE_TAP(self.loadFailImageView, @selector(repetLoad));
    [self.view addSubview:_loadFailImageView];
    
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    if ([imageFilePath containsString:@"selfPhoto.jpg"]) {
    }
    
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    
    [UIImageJPEGRepresentation(image, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    UIImage  *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    self.imageData = UIImageJPEGRepresentation(selfPhoto, 0.1);
    self.imagePath = imageFilePath;
    
    
     [self uploadImage];

    
}



#pragma mark - action
- (void)repetLoad {
    [self.flameAnimation setHidden:NO];
    [self.loadFailImageView setHidden:YES];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    [self.webView loadRequest:request];
}

- (void)backViewVC {
    if (self.isPush == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - htmlDelegate
-(void)app:(NSString *)string {
    NSDictionary *dic = [self dictionaryWithJsonString:string];
    
    NSLog(@"%@",dic);
    if ([dic[@"type"] isEqualToString:@"toHttp"]) {
        FTHomeViewController *web = [[FTHomeViewController alloc] init];
        web.url = dic[@"data"];
        web.ispushVC = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:web animated:YES];
        });
    }else if([dic[@"type"] isEqualToString:@"toFile"]) {

    /** 调用系统方法 */
    }else if ([dic[@"type"] isEqualToString:@"function"]) {
        
        if ([dic[@"data"][@"msg"] isEqualToString:@"callPhone"]) {//打电话
            dispatch_async(dispatch_get_main_queue(), ^{
                [self call:dic[@"data"][@"code"]];
            });
            
        }else if ([dic[@"data"][@"msg"] isEqualToString:@"openAlbum"]) {//调用相册
            self.uploadPath = dic[@"data"][@"code"][@"API"];
            self.imageCallBack = dic[@"data"][@"callBack"];
            self.type = dic[@"data"][@"code"][@"type"];
            [self openCameraOrPhoto];
        }
        else if ([dic[@"data"][@"msg"] isEqualToString:@"goBack"]) {//返回
            
            
            [self cleanCacheAndCookie];
            
            if ([dic[@"data"][@"code"] integerValue] == 2) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }else if ([dic[@"data"][@"code"] integerValue] == 3) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }else if ([_S(@"%@",dic[@"data"][@"code"]) isEqualToString:@"toHome"]){
                if (self.isMine) {//如果是从我的点击进去订单界面，则直接返回
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }else {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        
                        FTRootTabBarController *tar = [main instantiateViewControllerWithIdentifier:@"rootTabBar"];
                        UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                        while (topRootViewController.presentedViewController)
                        {
                            topRootViewController = topRootViewController.presentedViewController;
                        }
                        [topRootViewController presentViewController:tar animated:YES completion:nil];
                    });
                }
                
            }else if (self.isPush == YES) {
                [FTAccountManager sharedManager].dicInfo = [NSDictionary dictionaryWithDictionary:dic];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else if (self.isPush == NO) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }
            
            
        }else if ([dic[@"data"][@"msg"] isEqualToString:@"Share"]) {//分享
            
                
        }else if ([dic[@"data"][@"msg"] isEqualToString:@"Payment"]) {//支付
            JSValue *payStatue = self.jsContext[dic[@"data"][@"callBack"]];
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            app.paytype = payStatue;
            NSDictionary *Paydic = [NSDictionary dictionaryWithJsonString:dic[@"data"][@"code"]];
            
            if ([Paydic[@"payid"] isEqualToString:@"wx"]) {//微信支付
                WXPayDataModel *model = [[WXPayDataModel alloc] initWithDictionary:Paydic[@"API"] error:nil];
                [PaymentManager wechatPayWithPaymentInfo:model];
                
            }else {//支付宝
                
                
                [PaymentManager alipayWithPaymentInfo:Paydic[@"API"] payResultCallBack:^(BOOL status) {
                    if(status) {

                        [payStatue callWithArguments:@[@"1"]];
                    }
                    else {

                        [payStatue callWithArguments:@[@"0"]];
                    }
                }];
            }
        }else if ([dic[@"data"][@"msg"] isEqualToString:@"Location"]) {//定位
            [self startLocation];
        }else if ([dic[@"data"][@"msg"] isEqualToString:@"Chat"]) {
            
            
        }
    }
}

#pragma mark - json
-(void)didReceiveProcessedResponse:(id)JSON forRequest:(NSString *)request {
    if ([request isEqualToString:kFTCartList]) {
        Diss;
        if ([JSON[@"cartList"] isKindOfClass:[NSArray class]]) {
            
        }
    }
}

-(NSString *)getUserInfo {

    if (USER_DEFAULTS_GET(@"UserOpenIdent")) {
        return USER_DEFAULTS_GET(@"UserOpenIdent");
    }else {
        return nil;
    }
}

- (void)saveOpenIdent:(NSString *)openIdent {
    
    if (openIdent.length) {
        [FTAccountManager sharedManager].openIdent = openIdent;
        USER_DEFAULTS_SET(openIdent, @"UserOpenIdent");
    }
    NSLog(@"%@",openIdent);
}

@end
