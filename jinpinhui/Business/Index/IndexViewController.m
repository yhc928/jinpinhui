//
//  IndexViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/6.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    
    [self requestUserAction];
    
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    NSLog(@"resultDic = %@",resultDic);
}

/**
 *  request
 */
- (void)requestBin_cmd
{
    NSDictionary *parameters = @{@"username":@"123",
                                 @"password":@"a234",
                                 @"cmd":@"reg",
                                 @"date":@"2015-06-28 16:36:20",
                                 @"md5":@"deda6cfcf3c03080"};
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:parameters];
    [self jsonWithRequest:request delegate:self code:111 object:nil];
}

- (void)requestUserAction
{
    NSDictionary *parameters = @{@"connector":@"homeRedPort",
                                 @"account":@"13141215988"};
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getUserActionWithParameters:parameters];
    [self jsonWithRequest:request delegate:self code:112 object:nil];
}

@end
