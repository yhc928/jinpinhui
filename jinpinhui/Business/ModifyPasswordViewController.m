//
//  ModifyPasswordViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/2.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@interface ModifyPasswordViewController ()

@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改登录密码";
    [self setLeftTextView];
}
//设置text左侧标题
-(void) setLeftTextView{
    //旧密码
    UIView *oldPasswordView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_oldPasswordText.frame))];
    oldPasswordView.backgroundColor = [UIColor clearColor];
    UILabel *oldPasswordLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_oldPasswordText.frame))];
    oldPasswordLab.backgroundColor = [UIColor clearColor];
    oldPasswordLab.font = [UIFont systemFontOfSize:14.0];
    oldPasswordLab.text = @"旧密码";
    [oldPasswordView addSubview:oldPasswordLab];
    _oldPasswordText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _oldPasswordText .leftView = oldPasswordView;
    _oldPasswordText.leftViewMode = UITextFieldViewModeAlways;
    _oldPasswordText.placeholder = @"请输入旧密码";
//    _oldPasswordText.text = [[LoginUser sharedLoginUser] tel];
//    _oldPasswordText.delegate = self;
    _oldPasswordText.layer.borderWidth = 1;
    _oldPasswordText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
//    _oldPasswordText.keyboardType = UIKeyboardTypeNumberPad;
    _oldPasswordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //新密码
    UIView *NewPasswordView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_NewPasswordText.frame))];
    NewPasswordView.backgroundColor = [UIColor clearColor];
    UILabel *NewPasswordLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_NewPasswordText.frame))];
    NewPasswordLab.backgroundColor = [UIColor clearColor];
    NewPasswordLab.font = [UIFont systemFontOfSize:14.0];
    NewPasswordLab.text = @"新密码";
    [NewPasswordView addSubview:NewPasswordLab];
    _NewPasswordText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _NewPasswordText .leftView = NewPasswordView;
    _NewPasswordText.leftViewMode = UITextFieldViewModeAlways;
    _NewPasswordText.placeholder = @"请输入新密码";
//    _NewPasswordText.text = [[LoginUser sharedLoginUser] consignee];
//    _NewPasswordText.delegate = self;
    _NewPasswordText.layer.borderWidth = 1;
    _NewPasswordText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    //    _consigneeText.keyboardType = UIReturnKeyDone;
    _NewPasswordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //确认密码
    UIView *determineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, CGRectGetHeight(_determineText.frame))];
    determineView.backgroundColor = [UIColor clearColor];
    UILabel *determineLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_determineText.frame))];
    determineLab.backgroundColor = [UIColor clearColor];
    determineLab.font = [UIFont systemFontOfSize:14.0];
    determineLab.text = @"确认密码";
    [determineView addSubview:determineLab];
    _determineText.backgroundColor = UIColorFromRGB(240, 241, 242);
    _determineText .leftView = determineView;
    _determineText.leftViewMode = UITextFieldViewModeAlways;
    _determineText.placeholder = @"请再次输入密码";
    _determineText.layer.borderWidth = 1;
    _determineText.userInteractionEnabled = YES;
    _determineText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _determineText.keyboardType = UIReturnKeyDone;
   //按钮
    _completeBtn.adjustsImageWhenHighlighted = NO;
  
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

- (IBAction)completeClick:(id)sender {
    
}
@end
