//
//  ConventionViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "ConventionViewController.h"
#import "RegExp.h"
@interface ConventionViewController ()

@end

@implementation ConventionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"预约";
    _phoneNumText.layer.borderWidth = 1;
    _phoneNumText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
   
}

- (void)requestConvention{
    [self.Parameters setValue:_phoneNumText.text forKey:@"para"];
    [self.Parameters setValue:@"SETG" forKey:@"cmd"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    NSLog(@"%@",self.Parameters);
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:115 object:nil];
    
}
-(void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj{
    NSLog(@"%@",resultDic);
    NSLog(@"%@",[resultDic objectForKey:@"error"]);
    if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
        [self showAlertViewWithMessage:@"预约成功！"];
    }else{
        [self showCustomProgressHUDWithText:[resultDic objectForKey:@"error"]];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)submitAction:(id)sender {
    if (_phoneNumText.text.length > 0 && [RegExp isPhoneVerify:_phoneNumText.text]) {
        [self requestConvention];
    }else{
        [self showCustomProgressHUDWithText:@"请输入正确手机号"];
    }
}
@end
