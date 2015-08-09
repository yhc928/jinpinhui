//
//  ForgetPasswordViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/8.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "RegExp.h"
@interface ForgetPasswordViewController ()<UITextFieldDelegate>
{
    NSInteger noteM;
}
@property (nonatomic ,strong) UIButton *sendCodeBtn;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"找回密码";
    //注册键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    [self setLeftTextView];
}
//设置text左侧标题
-(void) setLeftTextView{
    //手机号码
    UIView *accountView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_PhoneNumText.frame))];
    accountView.backgroundColor = [UIColor clearColor];
    UILabel *accountLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_PhoneNumText.frame))];
    accountLab.backgroundColor = [UIColor clearColor];
    accountLab.font = [UIFont systemFontOfSize:14.0];
    accountLab.text = @"手机号码";
    [accountView addSubview:accountLab];
    _PhoneNumText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _PhoneNumText .leftView = accountView;
    _PhoneNumText.leftViewMode = UITextFieldViewModeAlways;
    _PhoneNumText.layer.borderWidth = 1;
    _PhoneNumText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _PhoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    _PhoneNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //密码
    UIView *passwordView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_passwordText.frame))];
    accountView.backgroundColor = [UIColor clearColor];
    UILabel *passwordLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_passwordText.frame))];
    passwordLab.backgroundColor = [UIColor clearColor];
    passwordLab.font = [UIFont systemFontOfSize:14.0];
    passwordLab.text = @"输入密码";
    [passwordView addSubview:passwordLab];
    _passwordText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _passwordText .leftView = passwordView;
    _passwordText.leftViewMode = UITextFieldViewModeAlways;
//    _passwordText.delegate = self;
    _passwordText.layer.borderWidth = 1;
    _passwordText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _passwordText.keyboardType = UIReturnKeyDone;
    _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //确认密码
    UIView *confirmView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_confirmText.frame))];
    accountView.backgroundColor = [UIColor clearColor];
    UILabel *confirmLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_confirmText.frame))];
    confirmLab.backgroundColor = [UIColor clearColor];
    confirmLab.font = [UIFont systemFontOfSize:14.0];
    confirmLab.text = @"确认密码";
    [confirmView addSubview:confirmLab];
    _confirmText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _confirmText .leftView = confirmView;
    _confirmText.leftViewMode = UITextFieldViewModeAlways;
    _confirmText.delegate = self;
    _confirmText.layer.borderWidth = 1;
    _confirmText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _confirmText.keyboardType = UIReturnKeyDone;
    _confirmText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //验证码
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_codeText.frame))];
    accountView.backgroundColor = [UIColor clearColor];
    UILabel *codeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_codeText.frame))];
    codeLab.backgroundColor = [UIColor clearColor];
    codeLab.font = [UIFont systemFontOfSize:14.0];
    codeLab.text = @"验证码";
    [codeView addSubview:codeLab];
    _codeText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _codeText .leftView = codeView;
    _codeText.leftViewMode = UITextFieldViewModeAlways;
//    _codeText.delegate = self;
    _codeText.layer.borderWidth = 1;
    _codeText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
//    _codeText.keyboardType = UIReturnKeyDone;
    _codeText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendCodeBtn.frame = CGRectMake(SCREEN_WIDTH - 90, 0, 90, CGRectGetHeight(_codeText.frame));
    [_sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    _sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_sendCodeBtn setTitleColor:UIColorFromRGB(14, 146, 214) forState:UIControlStateNormal];
    [_sendCodeBtn addTarget:self action:@selector(sendcodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [_codeText addSubview:_sendCodeBtn];
    
}
- (IBAction)sendcodeClick:(id)sender {
    if (_PhoneNumText.text.length>0) {
        //判断手机号是否正确
        if ([RegExp isPhoneAndTelVerify:_PhoneNumText.text]) {
            [self.Parameters setValue:_PhoneNumText.text forKey:@"username"];
            [self.Parameters setValue:@"GETICODE" forKey:@"cmd"];
            [self.Parameters setValue:@"" forKey:@"para"];
            [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
            [self.Parameters setValue:[self encryption] forKey:@"md5"];
            NSLog(@"%@",self.Parameters);
            CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
            [self jsonWithRequest:request delegate:self code:21 object:nil];
            [_sendCodeBtn setEnabled:NO];
            [_sendCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
            noteM = 60;
            NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(note:) userInfo:nil repeats:YES];
            [timer fire];
            
        }else [self showAlertViewWithMessage:@"请输入正确的手机号！"];
    }else [self showAlertViewWithMessage:@"请输入手机号！"];
    
}
-(void)note:(NSTimer *)timer
{
    noteM--;
    NSString *gainnotetitle=[NSString stringWithFormat:@"重新获取(%zi)",noteM];
    [_sendCodeBtn setTitle:gainnotetitle forState:UIControlStateDisabled];
    if (noteM==1) {
        
        [_sendCodeBtn setEnabled:YES];
        [_sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendCodeBtn setTitleColor:UIColorFromRGB(14, 146, 214) forState:UIControlStateNormal];
        [timer invalidate];
        return;
    }
}
#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    if (code == 20) {
        if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
          
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:[resultDic objectForKey:@"info"]
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
            alertView.tag = 188;
            [alertView show];
        }else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:[resultDic objectForKey:@"error"]
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
            alertView.tag = 199;
            [alertView show];
        }
    }else if (code == 21){
        if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
            [self showCustomProgressHUDWithText:@"验证码已发送!"];
        }
    }
    
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_confirmText]) {
        if (SCREEN_HEIGHT == 480 || SCREEN_HEIGHT == 568) {
            [UIView animateWithDuration:0.33 animations:^{
                self.view.frame = CGRectMake(0, -60, SCREEN_WIDTH, SCREEN_HEIGHT);
            }];
        }
        
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if (SCREEN_HEIGHT == 480 || SCREEN_HEIGHT == 568) {
        [UIView animateWithDuration:0.33 animations:^{
            self.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }
    
    
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

- (IBAction)confirmClicl:(id)sender {
    [self.view endEditing:YES];
    if (_PhoneNumText.text.length == 0)
        [self showAlertViewWithMessage:@"请输入手机号！"];
    else if (_passwordText.text.length == 0)
        [self showAlertViewWithMessage:@"请输入密码！"];
    else if (_confirmText.text.length == 0)
        [self showAlertViewWithMessage:@"请输入确认密码！"];
    else if (![_passwordText.text isEqualToString:_confirmText.text])
        [self showAlertViewWithMessage:@"密码输入不一致！"];
    else if (_passwordText.text.length < 6||_passwordText.text.length > 20)
        [self showAlertViewWithMessage:@"密码长度不正确！"];
    else if (_codeText.text.length == 0)
        [self showAlertViewWithMessage:@"请输入验证码！"];
    else {
        [self.Parameters setValue:_PhoneNumText.text forKey:@"username"];
        [self.Parameters setValue:_passwordText.text forKey:@"password"];
        [self.Parameters setValue:@"FIX2" forKey:@"cmd"];
        [self.Parameters setValue:_codeText.text forKey:@"para"];
        [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
        [self.Parameters setValue:[self encryption] forKey:@"md5"];
        NSLog(@"%@",self.Parameters);
        CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
        [self jsonWithRequest:request delegate:self code:20 object:nil];
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 188) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
