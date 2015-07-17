//
//  RegisteredViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/12.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "RegisteredViewController.h"
#import "RegExp.h"
@interface RegisteredViewController ()
{
    NSInteger noteM;
}
@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = UIColorFromRGB(231, 232, 234);
    self.title = @"注册";
    //高亮
    [_regBtn setBackgroundImage:[UIImage imageNamed:@"loginback_highlighted"] forState:UIControlStateHighlighted];
    [self setLeftTextView];
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
    _accountText.backgroundColor = UIColorFromRGB(240, 241, 242);
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
    passwordLab.text = @"输入密码";
    [passwordView addSubview:passwordLab];
    _passwordText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _passwordText .leftView = passwordView;
    _passwordText.leftViewMode = UITextFieldViewModeAlways;
    _passwordText.layer.borderWidth = 1;
    _passwordText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _passwordText.keyboardType = UIReturnKeyDone;
    _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //确认密码
    UIView *confirmView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, CGRectGetHeight(_confirmText.frame))];
    accountView.backgroundColor = [UIColor clearColor];
    UILabel *confirmLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, CGRectGetHeight(_confirmText.frame))];
    confirmLab.backgroundColor = [UIColor clearColor];
    confirmLab.font = [UIFont systemFontOfSize:12.0];
    confirmLab.text = @"确认密码";
    [confirmView addSubview:confirmLab];
    _confirmText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _confirmText .leftView = confirmView;
    _confirmText.leftViewMode = UITextFieldViewModeAlways;
    _confirmText.layer.borderWidth = 1;
    _confirmText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _confirmText.keyboardType = UIReturnKeyDone;
    _confirmText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //验证码
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, CGRectGetHeight(_codeText.frame))];
    accountView.backgroundColor = [UIColor clearColor];
    UILabel *codeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, CGRectGetHeight(_codeText.frame))];
    codeLab.backgroundColor = [UIColor clearColor];
    codeLab.font = [UIFont systemFontOfSize:12.0];
    codeLab.text = @"验证码";
    [codeView addSubview:codeLab];
    _codeText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _codeText .leftView = codeView;
    _codeText.leftViewMode = UITextFieldViewModeAlways;
    _codeText.layer.borderWidth = 1;
    _codeText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _codeText.keyboardType = UIReturnKeyDone;
    _codeText.clearButtonMode = UITextFieldViewModeWhileEditing;
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
-(void)note:(NSTimer *)timer
{
    noteM--;
    NSString *gainnotetitle=[NSString stringWithFormat:@"重新获取(%zi)",noteM];
    [_sendcodeBtn setTitle:gainnotetitle forState:UIControlStateDisabled];
    if (noteM==1) {
        
        [_sendcodeBtn setEnabled:YES];
        [_sendcodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendcodeBtn setTitleColor:UIColorFromRGB(14, 146, 214) forState:UIControlStateNormal];
        [timer invalidate];
        return;
    }
}

- (IBAction)sendcodeClick:(id)sender {
    if (_accountText.text.length>0) {
        //判断手机号是否正确
        if ([RegExp isPhoneAndTelVerify:_accountText.text]) {
            [_sendcodeBtn setEnabled:NO];
            [_sendcodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
            noteM = 60;
            NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(note:) userInfo:nil repeats:YES];
            [timer fire];
        }else [self showAlertViewWithMessage:@"请输入正确的手机号！"];
    }else [self showAlertViewWithMessage:@"请输入手机号！"];
    
}
- (IBAction)regClick:(id)sender {
    if (_accountText.text.length == 0)
        [self showAlertViewWithMessage:@"请输入手机号！"];
    else if (_passwordText.text.length == 0)
        [self showAlertViewWithMessage:@"请输入密码！"];
    else if (_confirmText.text.length == 0)
          [self showAlertViewWithMessage:@"请输入确认密码！"];
    else if (![_passwordText.text isEqualToString:_confirmText.text])
         [self showAlertViewWithMessage:@"密码输入不一致！"];
    else if (_passwordText.text.length < 6||_passwordText.text.length > 20)
        [self showAlertViewWithMessage:@"密码长度不正确！"];
    else {
        [self.Parameters setValue:_accountText.text forKey:@"username"];
        [self.Parameters setValue:_passwordText.text forKey:@"password"];
        [self.Parameters setValue:@"REG" forKey:@"cmd"];
        [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
        [self.Parameters setValue:[self encryption] forKey:@"md5"];
        NSLog(@"%@",self.Parameters);
        CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
        [self jsonWithRequest:request delegate:self code:111 object:nil];
    }
//    else if (_codeText.text.length == 0)
//        [self showAlertViewWithMessage:@"请输入验证码！"];
    
}
#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
        NSUserDefaults *userdefaules = [NSUserDefaults standardUserDefaults];
        [userdefaules setValue:_accountText.text forKey:@"username"];
        [userdefaules setValue:_passwordText.text forKey:@"password"];
        [userdefaules synchronize];
        [self showAlertViewWithMessage:[resultDic objectForKey:@"info"]];
    }else {
        [self showAlertViewWithMessage:[resultDic objectForKey:@"error"]];
    }

}
@end
