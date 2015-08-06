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
//#define DOMAIN_NAME   @""

//测试服务器
#define DOMAIN_NAME @"http://111.202.34.253:25046/szmobileapi/mobile/"

#define myAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate]) //appdelegate

#define APP_VERSION    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]) //app版本号
#define SYSTEM_VERSION ([UIDevice currentDevice].systemVersion) //系统版本号

#define ALIPAY              @"alipay"              //支付宝支付id
#define MOBILEPAY           @"mobilepay"           //支付宝钱包
#define OBSERVE_LOGIN       @"loginAndRegister"    //通知注册登录

#define IS_IOS_7                   ([SYSTEM_VERSION floatValue] >= 7.0)         //是否iOS7以上
#define IS_IOS_8                   ([SYSTEM_VERSION floatValue] >= 8.0)         //是否iOS8以上

#define SCREEN_HEIGHT              ([[UIScreen mainScreen] bounds].size.height) //屏幕高度
#define SCREEN_WIDTH               ([[UIScreen mainScreen] bounds].size.width)  //屏幕宽度

//原点的y值
#define ORIGIN_Y (IS_IOS_7 ? 64 : 0)

#define ITEM_FRAME                 CGRectMake(0, 0, 44, 44)                     //导航栏按钮坐标

#define BUTTON_RADIUS 3    //按钮的弧度
#define LAYER_RADIUS  2    //layer层的边框弧度
#define LAYER_WIDTH   0.5  //layer层的边框宽度
#define RIGHT_SIZE    60.0 //右侧边栏的宽度
#define VER_CODE_TIME 61   //验证码时间间隔

#define NULL_STR(str) (str == nil || (NSNull *)str == [NSNull null] || str.length == 0) //判断对象为空

//登录信息、状态
#define LOGINSTATUS @"loginstatus"   //记住密码、自动登录
#define UserImageKey @"userimage"
#define UserNameKey @"userName"
#define PasswordKey @"password"
#define RealNameKey @"realName"
#define AddressKey @"address"
#define ChecksKey @"checks"
#define UgoldKey @"ugold"
#define UsertradeKey @"usertrade"
#define UservcardKey @"uservcard"
#define CityKey @"city"
#define ConsigneeKey @"consignee"
#define TelKey @"tel"
#define RedpacketsKey @"redpackets"