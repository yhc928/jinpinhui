//
//  IndexDetailsViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/11.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsViewController.h"

@interface IndexDetailsViewController ()

@end

@implementation IndexDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.iname;
    [self requestProduct];
}

- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    NSLog(@"resultDic = %@",resultDic);
}

/**
 *  获取产品
 */
- (void)requestProduct
{
    [self.Parameters setValue:@"GETAL" forKey:@"cmd"];
    [self.Parameters setValue:self.iD forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:112 object:nil];
}

@end
