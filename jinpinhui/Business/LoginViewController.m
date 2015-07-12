//
//  LoginViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/12.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "LoginViewController.h"
#import "AppMacro.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = UIColorFromRGB(231, 232, 234);
    self.title = @"登录";
    [self setLeftTextView];
    //设置记住密码、自动登录按钮
    _rememberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _automaticBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.rightButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
}
//设置text左侧标题
-(void) setLeftTextView{
    //手机号码
    UIView *accountView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, CGRectGetHeight(_accountText.frame))];
    accountView.backgroundColor = [UIColor clearColor];
    UILabel *accountLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, CGRectGetHeight(_accountText.frame))];
    accountLab.backgroundColor = [UIColor clearColor];
    accountLab.font = [UIFont systemFontOfSize:12.0];
    accountLab.text = @"手机号码";
    [accountView addSubview:accountLab];
    _accountText .leftView = accountView;
    _accountText.leftViewMode = UITextFieldViewModeAlways;
    _accountText.layer.borderWidth = 1;
    _accountText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _accountText.keyboardType = UIKeyboardTypeNumberPad;
    _accountText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //密码
    UIView *passwordView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, CGRectGetHeight(_passwordText.frame))];
    accountView.backgroundColor = [UIColor clearColor];
    UILabel *passwordLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, CGRectGetHeight(_passwordText.frame))];
    passwordLab.backgroundColor = [UIColor clearColor];
    passwordLab.font = [UIFont systemFontOfSize:12.0];
    passwordLab.text = @"登录密码";
    [passwordView addSubview:passwordLab];
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

- (IBAction)rememberClick:(id)sender {
    [_rememberBtn setImage:[UIImage imageNamed:@"selectedyes"] forState:UIControlStateNormal];
    [_automaticBtn setImage:[UIImage imageNamed:@"selectedno"] forState:UIControlStateNormal];
}

- (IBAction)automaticClick:(id)sender {
    [_automaticBtn setImage:[UIImage imageNamed:@"selectedyes"] forState:UIControlStateNormal];
    [_rememberBtn setImage:[UIImage imageNamed:@"selectedno"] forState:UIControlStateNormal];
}
@end
