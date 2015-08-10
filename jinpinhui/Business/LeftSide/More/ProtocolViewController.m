//
//  ProtocolViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "ProtocolViewController.h"

@interface ProtocolViewController ()

@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户信息保密承诺";
    
    //背景
    UIScrollView *bgScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:bgScrollView];
    [bgScrollView constrainSubviewToMatchSuperview]; //设置autoLayout
    
    //取出协议字符串
    NSString *protocolPath = [[NSBundle mainBundle] pathForResource:@"registerProtocol" ofType:@"txt"];
    NSString *protocolStr = [NSString stringWithContentsOfFile:protocolPath encoding:NSUTF8StringEncoding error:nil];
    
    //协议标签
    UILabel *protocolLabel = [[UILabel alloc] init];
    protocolLabel.backgroundColor = [UIColor clearColor];
    protocolLabel.text = protocolStr;
    protocolLabel.numberOfLines = 0;
    protocolLabel.font = FONT_28PX;
    protocolLabel.preferredMaxLayoutWidth = SCREEN_WIDTH-40;
    [bgScrollView addSubview:protocolLabel];
    [protocolLabel constrainSubviewToMatchSuperviewWithEdgeInsets:UIEdgeInsetsMake(10, 20, 0, 20)]; //设置autoLayout
}

@end
