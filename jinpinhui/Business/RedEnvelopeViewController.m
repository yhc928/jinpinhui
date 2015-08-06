//
//  RedEnvelopeViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/1.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "RedEnvelopeViewController.h"
#import "LoginUser.h"
@interface RedEnvelopeViewController ()

@end

@implementation RedEnvelopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"领取红包";
    if (![[[LoginUser sharedLoginUser] redpackets] isEqualToString:@"0"]) {
        _currencyLab.hidden = NO;
        [_receiveBtn setTitle:@"邀请好友赚200" forState:UIControlStateNormal];
    }else{
        _currencyLab.hidden = YES;
        
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

- (IBAction)receiveClick:(id)sender {
    if ([[[LoginUser sharedLoginUser] redpackets] isEqualToString:@"0"]) {
        
        [self.Parameters setValue:@"SETF" forKey:@"cmd"];
        [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
        [self.Parameters setValue:[self encryption] forKey:@"md5"];
        NSLog(@"%@",self.Parameters);
        CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
        [self jsonWithRequest:request delegate:self code:116 object:nil];
    }
}
-(void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj{
    NSLog(@"%@",resultDic);
    if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
        _currencyLab.hidden = NO;
          [_receiveBtn setTitle:@"邀请好友赚200" forState:UIControlStateNormal];
        [[LoginUser sharedLoginUser] setRedpackets:@"1"];
        //金币变更通知
        NSInteger currency = [[[LoginUser sharedLoginUser] ugold] integerValue];
        [[LoginUser sharedLoginUser] setUgold:[NSString stringWithFormat:@"%zi",currency + 500]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CurrencyAddNotification" object:nil];
    }
}
@end
