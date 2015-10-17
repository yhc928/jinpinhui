//
//  IndexBannerWebViewController.m
//  jinpinhui
//
//  Created by 陈震 on 15/10/17.
//  Copyright © 2015年 chenzhen. All rights reserved.
//

#import "IndexBannerWebViewController.h"

@interface IndexBannerWebViewController ()

@end

@implementation IndexBannerWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //网页视图
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    webView.backgroundColor = [UIColor clearColor];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView constrainSubviewToMatchSuperview];
    
    //加载链接
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
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

@end
