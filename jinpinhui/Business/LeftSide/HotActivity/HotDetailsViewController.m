//
//  HotDetailsViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "HotDetailsViewController.h"
#import "MyDrawerViewController.h"

@interface HotDetailsViewController ()

@end

@implementation HotDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.hotTitle;
    
    //网页视图
    UIWebView *webView = [[UIWebView alloc] init];
    webView.backgroundColor = [UIColor clearColor];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView constrainSubviewToMatchSuperview]; //设置autoLayout
    
    //加载链接
//    NSString *urlStr = [NSString stringWithFormat:@"%@/wap/alipay/alipayapi.php?order_id=%@",API_DOMAIN,self.order_id];
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    [webView loadRequest:request];
//    [self showProgressHUD];
    
//    NSLog(@"urlStr = %@",urlStr);

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置侧滑菜单不可点
    myAppDelegate.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //设置侧滑菜单可点
    myAppDelegate.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
}

@end
