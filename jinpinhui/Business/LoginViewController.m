//
//  LoginViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/12.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisteredViewController.h"
#import "MyDrawerViewController.h"
#import "IndexViewController.h"
#import "LeftSideViewController.h"
#import "RightSideViewController.h"
#import "LoginUser.h"

@interface LoginViewController ()
@property (nonatomic ,assign)NSInteger loginStatus;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = nil;
    [self setLeftTextView];
    //设置记住密码、自动登录按钮
    _rememberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _automaticBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.rightButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.rightButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.rightButton addTarget:self action:@selector(regAction:) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginback_highlighted"] forState:UIControlStateHighlighted];
    //默认
    _loginStatus = 2; //自动登录
}
//设置text左侧标题
-(void) setLeftTextView{
    //手机号码
    UIView *accountView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_accountText.frame))];
    accountView.backgroundColor = [UIColor clearColor];
    UILabel *accountLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_accountText.frame))];
    accountLab.backgroundColor = [UIColor clearColor];
    accountLab.font = [UIFont systemFontOfSize:14.0];
    accountLab.text = @"手机号码";
    [accountView addSubview:accountLab];
    _accountText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _accountText .leftView = accountView;
    _accountText.leftViewMode = UITextFieldViewModeAlways;
    _accountText.layer.borderWidth = 1;
    _accountText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _accountText.keyboardType = UIKeyboardTypeNumberPad;
    _accountText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //记住账号
    _accountText.text =[[LoginUser sharedLoginUser] userName];
    //密码
    UIView *passwordView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_passwordText.frame))];
    accountView.backgroundColor = [UIColor clearColor];
    UILabel *passwordLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_passwordText.frame))];
    passwordLab.backgroundColor = [UIColor clearColor];
    passwordLab.font = [UIFont systemFontOfSize:14.0];
    passwordLab.text = @"登录密码";
    [passwordView addSubview:passwordLab];
    _passwordText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _passwordText .leftView = passwordView;
    _passwordText.leftViewMode = UITextFieldViewModeAlways;
    _passwordText.layer.borderWidth = 1;
    _passwordText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _passwordText.keyboardType = UIReturnKeyDone;
    _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)regAction:(id)sender{
     _loginStatus = 1; //记住账号
    RegisteredViewController *registered = [[RegisteredViewController alloc]init];
    [self.navigationController pushViewController:registered animated:YES];
}
- (IBAction)rememberClick:(id)sender {
    [_rememberBtn setImage:[UIImage imageNamed:@"selectedyes"] forState:UIControlStateNormal];
    [_automaticBtn setImage:[UIImage imageNamed:@"selectedno"] forState:UIControlStateNormal];
}

- (IBAction)automaticClick:(id)sender {
     _loginStatus = 2; //自动登录
    [_automaticBtn setImage:[UIImage imageNamed:@"selectedyes"] forState:UIControlStateNormal];
    [_rememberBtn setImage:[UIImage imageNamed:@"selectedno"] forState:UIControlStateNormal];
}
- (IBAction)loginClick:(id)sender {
    if (_accountText.text.length == 0)
        [self showAlertViewWithMessage:@"请输入手机号！"];
    else if (_passwordText.text.length == 0)
        [self showAlertViewWithMessage:@"请输入密码！"];
    else{
        [self.Parameters setValue:_accountText.text forKey:@"username"];
        [self.Parameters setValue:_passwordText.text forKey:@"password"];
        [self.Parameters setValue:@"LOG" forKey:@"cmd"];
        [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
        [self.Parameters setValue:[self encryption] forKey:@"md5"];
        CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
        [self jsonWithRequest:request delegate:self code:111 object:nil];
        
    }
}
#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
        [[LoginUser sharedLoginUser] setUserName:_accountText.text];
        [[LoginUser sharedLoginUser] setPassword:_passwordText.text];
        [[LoginUser sharedLoginUser] setLoginStatus:[NSString stringWithFormat:@"%zi",_loginStatus]];
        /*//首页
        IndexViewController *indexVC = [[IndexViewController alloc] init];
        UINavigationController *indexNav = [[UINavigationController alloc] initWithRootViewController:indexVC];
        
        //左侧边栏
        LeftSideViewController *leftSideVC = [[LeftSideViewController alloc] init];
        
        //右侧边栏
        RightSideViewController *rightSideVC = [[RightSideViewController alloc] init];
    
        
        MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:indexNav
                                                                               leftDrawerViewController:leftSideVC
                                                                              rightDrawerViewController:rightSideVC];
        
        drawerController.showsShadow = YES;
        drawerController.maximumLeftDrawerWidth = SCREEN_WIDTH-55;
        drawerController.maximumRightDrawerWidth = SCREEN_WIDTH-55;
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll; */
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStatusSuccessful" object:nil];  //发送登录成功状态请求个人信息
        myAppDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:myAppDelegate.drawerController];;
    }else {
        [self showCustomProgressHUDWithText:[resultDic objectForKey:@"error"]];
    }
    
}
-(void)dismissKeyboard{
    
    [self.view endEditing:YES];
}
@end
