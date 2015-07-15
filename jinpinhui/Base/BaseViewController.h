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
#import "CZRequest.h"         //在AFNetworking下二次封装网络请求
#import "UIView+AutoLayout.h" //自动布局类目
#import "MJRefresh.h"         //下拉刷新

@class MBProgressHUD;

@interface BaseViewController : UIViewController<UIScrollViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,CZRequestHelperDelegate>

@property (nonatomic, strong) UIButton *rightButton; //导航栏右侧按钮
@property (nonatomic, strong) NSMutableDictionary *Parameters; //post 请求参数
@property (nonatomic, strong) NSString *encryption;//md5 加密参数
@property (nonatomic, strong) NSString *getCurrentTime;
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
 *  显示提示
 *
 *  @param title   标题
 *  @param message 内容
 *  @param cancel  取消按钮
 *  @param other   其他按钮
 *
 *  @return alertView
 */
- (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                                 cancel:(NSString *)cancel
                                  other:(NSString *)other;

/**
 *  显示打电话警告
 *
 *  @param title 电话号码
 */
- (void)showActionSheetWithTitle:(NSString *)title;

/**
 * 显示HUD
 */
- (MBProgressHUD *)showProgressHUD;

/**
 *  显示有文字HUD
 *
 *  @param text 提示文字
 *
 *  @return HUD
 */
- (MBProgressHUD *)showProgressHUDWithText:(NSString *)text;

/**
 *  显示自定义HUD
 *
 *  @param text 提示文字
 *
 *  @return HUD
 */
- (MBProgressHUD *)showCustomProgressHUD:(NSString *)text;

/**
 * 隐藏HUD
 */
- (void)hideProgressHUD;

/**
 *  显示指示器
 *
 *  @param view  父视图
 *  @param frame 位置
 */
- (void)showIndicatorView:(UIView *)view
                    Frame:(CGRect)frame;

/**
 * 隐藏指示器
 */
- (void)hideIndicatorView;

/**
 * 点击返回上一页面
 */
- (void)didBack;

/**
 * 回收键盘
 */
- (void)recycleKeyboard;

@end
