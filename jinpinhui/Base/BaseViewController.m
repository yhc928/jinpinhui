//
//  BaseViewController.m
//  Shequ001
//
//  Created by 陈震 on 14-6-19.
//  Copyright (c) 2014年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h" //HUD指示器
//#import "BaiduMobStat.h"  //百度统计
#import "RegExp.h"        //正则验证

@interface BaseViewController ()

@property (nonatomic, strong) MBProgressHUD           *progressHUD;        //HUD
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;      //指示器
@property (nonatomic, strong) UIImageView             *loadImageView;      //加载图片view

@property (nonatomic, strong) UIAlertView             *noNetworkAlertView; //无网络提示view
@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置所有页面的背景色
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = ITEM_FRAME;
    [backButton setImage:[UIImage imageNamed:@"NavBack"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"NavBackHighlighted"] forState:UIControlStateHighlighted];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton addTarget:self action:@selector(didBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //导航栏右侧按钮
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = ITEM_FRAME;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
    if (IS_IOS_7) {
        //设置滑动返回手势
        self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
        
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        self.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    //子类中重写代理方法
}

//发送网络请求
- (void)jsonWithRequest:(CZRequestModel *)request delegate:(id<CZRequestHelperDelegate>)delegate code:(NSInteger)code object:(id)obj
{
    //检测网络状态
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //-1 未知 0 无连接 1 3G 2 WIFI
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //显示无网络提示
            if (self.noNetworkAlertView) {
                [self.noNetworkAlertView dismissWithClickedButtonIndex:0 animated:NO];
                self.noNetworkAlertView = nil;
            }
            
            self.noNetworkAlertView = [self showAlertViewWithTitle:@""
                                                           message:@"当前网络不可用，请检查您的网络设置…"
                                                            cancel:@"关闭"
                                                             other:@"电话下单"];
            
            //隐藏HUD、指示器
            [self hideProgressHUD];
        } else {
            //发送网络请求
            CZRequestHelper *helper = [[CZRequestHelper alloc] init];
            if (NULL_STR(request.jsonStr)) {
                [helper czGETWithRequest:request delegate:delegate code:code object:obj];
            } else {
                [helper czPOSTWithRequest:request delegate:delegate code:code object:obj];
            }
        }
    }];
}

//取消所有网络请求
- (void)cancelAllRequest
{
    [[CZRequestOperationManager sharedClient].operationQueue cancelAllOperations];
}

//显示简单提示
- (void)showAlertViewWithMessage:(NSString *)message
{
    [self showAlertViewWithTitle:@"提示" message:message cancel:@"关闭" other:nil];
}

//显示提示
- (UIAlertView *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel other:(NSString *)other
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:cancel
                                              otherButtonTitles:other, nil];
    [alertView show];
    
    return alertView;
}

#pragma mark - UIAlertViewDelegate iOS8以前
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"电话下单"]) {
        //显示打电话警告
        [self showActionSheetWithTitle:SERVICE_TEL];
    }
}

//显示打电话警告
- (void)showActionSheetWithTitle:(NSString *)title
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:title, nil];
    
    [actionSheet showInView:myAppDelegate.window];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    //正则验证是否是电话号码or手机号
    if ([RegExp isPhoneAndTelVerify:title]) {
        //调用打电话方法
        NSString *urlStr = [NSString stringWithFormat:@"tel://%@",title];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
}

//显示HUD
- (MBProgressHUD *)showProgressHUD
{
    return [self showProgressHUDWithText:nil];
}

//显示有文字HUD
- (MBProgressHUD *)showProgressHUDWithText:(NSString *)text
{
    if (self.progressHUD != nil) {
        [self hideProgressHUD];
    }
    
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    if (text) {
        self.progressHUD.labelText = text;
    }
    
    [self.view addSubview:self.progressHUD];
    [self.progressHUD show:YES];
    
    return self.progressHUD;
}

//显示自定义HUD
- (MBProgressHUD *)showCustomProgressHUD:(NSString *)text
{
    if (!NULL_STR(text)) {
        if (self.progressHUD != nil) {
            [self hideProgressHUD];
        }
        
        self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        self.progressHUD.mode = MBProgressHUDModeText;
        
        self.progressHUD.labelText = text;
        [self.view addSubview:self.progressHUD];
        [self.progressHUD show:YES];
        [self.progressHUD hide:YES afterDelay:1];
    }
    
    return self.progressHUD;
}

//隐藏HUD
- (void)hideProgressHUD
{
    if (self.progressHUD) {
        [self.progressHUD hide:YES];
        [self.progressHUD removeFromSuperview];
        self.progressHUD = nil;
    }
}

//显示指示器
- (void)showIndicatorView:(UIView *)view Frame:(CGRect)frame
{
    if (self.indicatorView) {
        [self hideIndicatorView];
    }
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorView.frame = frame;
    [view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
}

//隐藏指示器
- (void)hideIndicatorView
{
    if (self.indicatorView) {
        [self.indicatorView stopAnimating];
        [self.indicatorView removeFromSuperview];
        self.indicatorView = nil;
    }
}

/**
 * 功能：显示加载图片view
 */
- (void)showLoadImageView
{
    //隐藏加载图片
    [self hideLoadImageView];
    
    //动画图片
    NSMutableArray *loadImageArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 1; i <= 4; i++) {
        NSString *loadImageStr = [NSString stringWithFormat:@"LoadBig%d",i];
        UIImage *loadImage = [UIImage imageNamed:loadImageStr];
        [loadImageArray addObject:loadImage];
    }
    
    //加载图片view
    self.loadImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-64)/2, (SCREEN_HEIGHT-64-80)/2, 64, 80)];
    [self.view addSubview:self.loadImageView];
    
    //设置动画数组
    self.loadImageView.animationImages = loadImageArray;
    //设置动画播放次数
    self.loadImageView.animationRepeatCount = 99;
    //设置动画播放时间
    self.loadImageView.animationDuration = 0.4;
    //开始动画
    [self.loadImageView startAnimating];
}

//隐藏加载图片view
- (void)hideLoadImageView
{
    if (self.loadImageView) {
        [self.loadImageView stopAnimating];
        [self.loadImageView removeFromSuperview];
        self.loadImageView = nil;
    }
}

/**
 * 功能：重写页面名字的get方法
 */
- (NSString *)pageName
{
    if (_pageName == nil) {
        _pageName = self.navigationItem.title;
    }
    
    return _pageName;
}

//点击返回上一页面
- (void)didBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

//回收键盘
- (void)recycleKeyboard
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"%@收到内存警告",self.pageName);
    // Dispose of any resources that can be recreated.
}

@end
