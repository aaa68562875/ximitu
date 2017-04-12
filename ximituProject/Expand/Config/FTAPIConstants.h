//
//  FTAPIConstants.h
//  XingSiluSend
//
//  Created by zlc on 15/8/28.
//  Copyright (c) 2015年 Wanrongtong. All rights reserved.
//

#ifndef MyFrame_FTAPIConstants_h
#define MyFrame_FTAPIConstants_h


/**
 网络连接测试接口
 */

#define KFTConnTestURL @"www.baidu.com"

#pragma mark - 演示环境

//内网测试82.25  /  80.57
//#define kFTBaseURL @"192.168.0.2:8080"    //
//#define kFTBaseURL @"192.168.0.117:8080"   //罗静
//#define kFTBaseURL @"192.168.0.110:8080"   //唐杰
//#define kFTBaseURL @"192.168.82.25:8080/api"   //PC
//外网测试
//#define kFTBaseURL @"120.132.85.103:8088/api"
//上线 地址
//#define kFTBaseURL @"120.132.85.103/api-1.1.8"

//#define kFTBaseURL @"192.168.1.111:7301"//内网
//#define kFTBaseURL @"218.6.173.17:7301"//外网

//#define kFTWebUrl @"http://218.6.173.17:8290/ec_b2c_html/"
//#define KFTImagePathUrl @"http://218.6.173.17:8290/ec_cloud/"


#define kFTBaseURL @"211.149.246.218:7301"//外网
//
//#define kFTWebUrl @"http://211.149.246.218:8088/ec_b2c_html/"
#define kFTWebUrl @"http://wx.360slqh.com/"

//#define kFTWebUrl @"http://192.168.1.110:7301/ec_b2c_html/"
#define KFTImagePathUrl @"http://211.149.246.218:8088/ec_cloud/"

#define kFTBasePort @"80"

//首页获取附近商家
#define kFTGetNearByWuliuInfo @"app/getNearbyLineInfo"

//获取注册验证码
#define KFTGetTheCode @"app/validCode"
//获取验证码
#define kFTGetCode @"app/getCode"
//注册
#define KFTConsignerRegister @"app/consignerRegister"
//登录
#define kFTLogin @"app/consignerLogin"
//退出登录
#define kFTLogout @"app/logout"


#pragma mark - 天府蜀珍
//获取首页分类商品
#define kFTHomeCategoryGoods @"goodsControl/homeCategoryGoods"

//获取图片轮播
#define kFTCarousel @"systemControl/carousel"

//商品一级分类
#define kFTFCategory @"categoryControl/FCategory"

//搜索商品
#define kFTSearchGoods @"goodsControl/searchGoods"

//购物车列表
#define kFTCartList @"cartControl/cartList"

//获取用户基本信息
#define kFTConsumerInfo @"consumerControl/consumerInfo"

//获取滚动
#define kFTGetSysArticleListByCategory @"systemControl/getSysArticleListByCategory"

//添加购物车数量
#define kFTShopCartAddNum @"cartControl/cartUp"

//删除购物车
#define kFTDelGoods @"cartControl/cartDel"



#endif
