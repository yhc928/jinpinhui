//
//  CommissionViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/19.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "CommissionViewController.h"

@interface CommissionViewController ()

@end

@implementation CommissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的佣金";
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:@"Commission"]) {
         _cumulativeLab.text = [userDefault objectForKey:@"Commission"];
    }
    [self.Parameters setValue:@"GETE" forKey:@"cmd"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:119 object:nil];
}
-(void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj{
    if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
        _cumulativeLab.text = [resultDic objectForKey:@"info"];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setValue:[resultDic objectForKey:@"info"] forKey:@"Commission"];
        [userDefault synchronize];
    }
    NSLog(@"%@",resultDic);
    NSLog(@"%@",[resultDic objectForKey:@"error"]);
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

@end
