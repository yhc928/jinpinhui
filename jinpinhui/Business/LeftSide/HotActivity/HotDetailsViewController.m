//
//  HotDetailsViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "HotDetailsViewController.h"
#import "UMSocialHelper.h"

@interface HotDetailsViewController ()

@end

@implementation HotDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.hotTitle;
    
    //右侧按钮
    UIButton *righButton = [UIButton buttonWithType:UIButtonTypeCustom];
    righButton.frame = ITEM_FRAME;
    [righButton setImage:[UIImage imageNamed:@"nav_right_share"] forState:UIControlStateNormal];
    righButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [righButton addTarget:self action:@selector(didShare) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:righButton];
    
    //网页视图
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    webView.backgroundColor = [UIColor clearColor];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView constrainSubviewToMatchSuperview];
    
    //加载链接
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.bimg]];
    [webView loadRequest:request];
    
    [self showProgressHUD];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideProgressHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideProgressHUD];
}

/**
 *  点击分享
 */
- (void)didShare
{
    [UMSocialHelper shareWithModel:@"qqqqqq" viewController:self];
}

@end
