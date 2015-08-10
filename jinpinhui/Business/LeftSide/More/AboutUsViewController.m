//
//  AboutUsViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    
    //背景
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT)];
    [self.view addSubview:bgScrollView];
    
    //图标
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about_us_icon"]];
    iconImageView.frame = CGRectMake((SCREEN_WIDTH-60)/2, 20, 60, 60);
    [bgScrollView addSubview:iconImageView];
    
    //版本号
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 80, 60, 30)];
    versionLabel.text = [NSString stringWithFormat:@"V%@",APP_VERSION];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = FONT_28PX;
    [bgScrollView addSubview:versionLabel];
    
    //取出协议字符串
    NSString *aboutUsPath = [[NSBundle mainBundle] pathForResource:@"aboutUs" ofType:@"txt"];
    NSString *aboutUsStr = [NSString stringWithContentsOfFile:aboutUsPath encoding:NSUTF8StringEncoding error:nil];
    
    //关于我们
    UILabel *aboutUsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, SCREEN_WIDTH-40, 0)];
    aboutUsLabel.text = aboutUsStr;
    aboutUsLabel.font = FONT_28PX;
    aboutUsLabel.numberOfLines = 0;
    [bgScrollView addSubview:aboutUsLabel];
    [aboutUsLabel sizeToFit];
    
    //设置scrollView的contentSize
    bgScrollView.contentSize = CGSizeMake(0, aboutUsLabel.frame.origin.y+CGRectGetHeight(aboutUsLabel.frame));
}

@end
