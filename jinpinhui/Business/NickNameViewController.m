//
//  NickNameViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/1.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "NickNameViewController.h"
#import "LoginUser.h"
@interface NickNameViewController ()

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置昵称";
    _nickNameText.layer.borderWidth = 1;
    _nickNameText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _nickNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    if ([self.nickName isEqualToString:@""]) {
        _nickNameText.text = @"";
//        _nickNameText.placeholder = @"请输入您的昵称";
    }else{
        _nickNameText.text = self.nickName;
    }
    
    
    _saveBtn.adjustsImageWhenHighlighted = NO;
//    [_saveBtn setBackgroundImage:[UIImage imageNamed:@"loginback_highlighted"] forState:UIControlStateHighlighted];
    
}
-(void)RequestSetNickName{
    
    //   NSString *dataGBK = [_cityText.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //      NSString *dataUTF8 = [_cityText.text  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSLog(@"%@",dataUTF8);
    //     NSString *dataGBK = [dataUTF8 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.Parameters setValue:@"SETE" forKey:@"cmd"];
    [self.Parameters setValue:_nickNameText.text forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:113 object:nil];
}
-(void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj{
    if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
        [[LoginUser sharedLoginUser] setRealName:_nickNameText.text];
        [self showAlertViewWithMessage:@"保存成功！"];
    }
    NSLog(@"%@",resultDic);
    NSLog(@"%@",[resultDic objectForKey:@"error"]);
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateNickName" object:nil];
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

- (IBAction)saveClick:(id)sender {
    if (_nickNameText.text.length == 0) {
        [self showCustomProgressHUDWithText:@"请输入昵称"];
    }else if (_nickNameText.text.length > 6){
        [self showCustomProgressHUDWithText:@"昵称输入过长"];
    }else{
        [self RequestSetNickName];
    }
}
@end
