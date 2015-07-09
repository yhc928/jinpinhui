//
//  UtilsMacro.h
//  Shequ001
//
//  Created by xiao7 on 15/6/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  工具宏定义
 */
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

//正式服务器
//#define API_MAIN   @"http://m.shequ001.com"

//测试服务器
#define API_MAIN   @"http://beijing.shequ001.me"

#define DOMAIN_NAME @"http://111.202.34.253:25046/szmobileapi/mobile/"

#define API_DOMAIN ([[NSUserDefaults standardUserDefaults] objectForKey:@"local_url"])

#define myAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate]) //appdelegate

#define EXT_API_USER   ([[NSUserDefaults standardUserDefaults]  objectForKey:@"EXT-API-USER"]) //用户
#define EXT_API_TOKEN  ([[NSUserDefaults standardUserDefaults]  objectForKey:@"EXT-API-TOKEN"]) //验证
#define APP_VERSION    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]) //app版本号
#define SYSTEM_VERSION ([UIDevice currentDevice].systemVersion) //系统版本号

#define ALIPAY              @"alipay"              //支付宝支付id
#define MOBILEPAY           @"mobilepay"           //支付宝钱包
#define SERVICE_TEL         @"10108001"            //客服电话
#define OBSERVE_LOGIN       @"loginAndRegister"    //通知注册登录
#define SHEQU001_URL        @"http://shequ001.com" //社区001官网地址

#define IS_IOS_6                   ([SYSTEM_VERSION floatValue] >= 6.0)         //是否iOS6以上
#define IS_IOS_7                   ([SYSTEM_VERSION floatValue] >= 7.0)         //是否iOS7以上
#define IS_IOS_8                   ([SYSTEM_VERSION floatValue] >= 8.0)         //是否iOS8以上
#define SCREEN_HEIGHT              ([[UIScreen mainScreen] bounds].size.height) //屏幕高度
#define SCREEN_WIDTH               ([[UIScreen mainScreen] bounds].size.width)  //屏幕宽度
#define IS_IPHONE_4                (SCREEN_HEIGHT == 480)                       //是否iPhone4
#define IS_IPHONE_5                (SCREEN_HEIGHT == 568)                       //是否iPhone5
#define IS_IPHONE_6                (SCREEN_HEIGHT >= 667)                       //是否iPhone6

#define NAV_HEIGHT                 (IS_IOS_7 ? 0.0 : 64.0)                      //导航栏高度

//原点的y值
#define ORIGIN_Y (IS_IOS_7 ? 64 : 0)

#define STATUS_HEIGHT              (IS_IOS_7 ? 20.0 : 0.0)                      //状态栏高度，iOS7 20 iOS6 0
#define ITEM_FRAME                 CGRectMake(0, 0, 44, 44)                     //导航栏按钮坐标

#define BUTTON_RADIUS 3    //按钮的弧度
#define LAYER_RADIUS  2    //layer层的边框弧度
#define LAYER_WIDTH   0.5  //layer层的边框宽度
#define RIGHT_SIZE    60.0 //右侧边栏的宽度
#define VER_CODE_TIME 61   //验证码时间间隔

#define NULL_STR(str) (str == nil || (NSNull *)str == [NSNull null] || str.length == 0) //判断对象为空

//从页面进入的枚举状态
typedef NS_ENUM(NSInteger, Status) {
    StatusLife = 0,       //生活超市
    StatusBoutique,       //精品超市
    StatusMetro,          //麦德龙
    StatusBraStreet,      //品牌街
    
    StatusRegister,       //注册
    StatusForgetPassword, //忘记密码
    StatusPhoneBinding,   //绑定手机
    StatusCardBinding     //绑定社区卡
};
