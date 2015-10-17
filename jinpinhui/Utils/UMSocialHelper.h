//
//  UMSocialHelper.h
//  doctor
//
//  Created by 陈震 on 15/9/6.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  友盟分享助手类
 */
#import <Foundation/Foundation.h>
#import "UMSocial.h"              //友盟SDK
#import "UMSocialWechatHandler.h" //微信分享SDK
#import "UMSocialQQHandler.h"     //QQ/QQ空间分享SDK
#import "WXApi.h"                 //微信

@interface UMSocialHelper : NSObject

/**
 * 初始化友盟分享
 */
+ (void)startUMSocial;

/**
 *  分享的方法
 *
 *  @param model          model
 *  @param viewController 分享所在的页面
 */
+ (void)shareWithModel:(id)model viewController:(UIViewController *)viewController;

/**
 *  检查微信是否按钮
 *
 *  @return 安装返回YES
 */
+ (BOOL)isWechatInstalled;

/**
 *  微信登录
 *
 *  @param viewController 所在的页面
 */
+ (void)wechatLoginWithViewController:(UIViewController *)viewController;

@end
