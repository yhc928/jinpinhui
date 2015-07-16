//
//  BaseViewController.m
//  Shequ001
//
//  Created by 陈震 on 14-6-19.
//  Copyright (c) 2014年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"
#import <CommonCrypto/CommonDigest.h>    //MD5
#import "AFNetworkReachabilityManager.h" //AFNetworking网络检测
#import "MBProgressHUD.h"                //HUD指示器
#import "RegExp.h"                       //正则验证

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
    [backButton setImage:[UIImage imageNamed:@"navback"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navback"] forState:UIControlStateHighlighted];
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
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    
    NSLog(@"status = %ld",(long)status);
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
        if (request.parameters == nil) {
            [helper czGETWithRequest:request delegate:delegate code:code object:obj];
        } else {
            [helper czPOSTWithRequest:request delegate:delegate code:code object:obj];
        }
    }
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
//    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
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
- (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for(int i =0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}
//MD5加密
- (NSString *)encryption
{
    NSString *encryptionStr = [NSString stringWithFormat:@"%@%@%@%@%@",[_Parameters objectForKey:@"cmd"],[_Parameters objectForKey:@"username"],[_Parameters objectForKey:@"password"],[self getMD5Time:[_Parameters objectForKey:@"date"]],@"436x7f6dz2ah53xc"];
    NSLog(@"%@",encryptionStr);
    const char *cStr = [encryptionStr UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for(int i =0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
        _encryption =[[result substringToIndex:24] substringFromIndex:8];
     return _encryption;//即9～25位
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}
//获取日期 yyyy-MM-dd HH:mm:ss
-(NSString *)getCurrentTime{

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datetime = [formatter stringFromDate:[NSDate date]];
    return datetime;
}
//获取日期 yyyyMMdd HHmmss MD5加密需要的格式
-(NSString *)getMD5Time:(NSString *)reqtime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *md5date = [formatter dateFromString:reqtime];
    
    NSDateFormatter *Newformatter = [[NSDateFormatter alloc]init];
    [Newformatter setDateFormat:@"yyyyMMddHHmmss"];
    _getCurrentTime = [Newformatter stringFromDate:md5date];
    return _getCurrentTime;
}

//post 请求参数
-(NSMutableDictionary *)Parameters{
    if (!_Parameters) {
        _Parameters = [[NSMutableDictionary alloc]init];
        NSUserDefaults *userdefaults =[NSUserDefaults standardUserDefaults];
        [_Parameters setValue:[userdefaults objectForKey:@"username"] forKey:@"username"];
        [_Parameters setValue:[userdefaults objectForKey:@"password"] forKey:@"password"];
        [_Parameters setValue:@"" forKey:@"cmd"];
        [_Parameters setValue:@"" forKey:@"date"];
        [_Parameters setValue:@"" forKey:@"md5"];
    }
   
    return _Parameters;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
