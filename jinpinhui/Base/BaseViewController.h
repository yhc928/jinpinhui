//
//  BaseViewController.h
//  Shequ001
//
//  Created by 陈震 on 14-6-19.
//  Copyright (c) 2014年 chenzhen. All rights reserved.
//

/**
 * 页面的基类
 */
#import <UIKit/UIKit.h>
#import "CZRequest.h" //在AFNetworking下二次封装网络请求
#import "MJRefresh.h" //下拉刷新

@class MBProgressHUD;

@interface BaseViewController : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate,CZRequestHelperDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton            *rightButton;//导航栏右侧按钮
@property (nonatomic, strong) NSMutableDictionary *Parameters;//post 请求参数
@property (nonatomic, strong) NSString            *encryption;//md5 加密参数
@property (nonatomic, strong) NSString            *getCurrentTime;

/**
 *  发送网路请求
 *
 *  @param request  请求model
 *  @param delegate 代理
 *  @param code     状态码
 *  @param obj      object
 */
- (void)jsonWithRequest:(CZRequestModel *)request
               delegate:(id<CZRequestHelperDelegate>)delegate
                   code:(NSInteger)code
                 object:(id)obj;

/**
 *  显示文字提示
 *
 *  @param message 提示内容
 */
- (void)showAlertViewWithMessage:(NSString *)message;

/**
 *  显示打电话警告
 *
 *  @param title 电话号码
 */
- (void)showActionSheetWithTitle:(NSString *)title;

#pragma mark - HUD

/**
 * 显示HUD
 */
- (void)showProgressHUD;

/**
 *  显示自定义HUD
 *
 *  @param text 提示文字
 */
- (void)showCustomProgressHUDWithText:(NSString *)text;

/**
 * 隐藏HUD
 */
- (void)hideProgressHUD;

/**
 * 点击返回上一页面
 */
- (void)didBack;

/**
 * 回收键盘
 */
- (void)recycleKeyboard;

@end
