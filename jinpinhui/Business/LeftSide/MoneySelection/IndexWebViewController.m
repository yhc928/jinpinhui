//
//  IndexWebViewController.m
//  jinpinhui
//
//  Created by 陈震 on 15/8/24.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexWebViewController.h"

@interface IndexWebViewController ()

@end

@implementation IndexWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [self.info objectForKey:@"title"];
    
    //网页视图
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    webView.backgroundColor = [UIColor clearColor];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView constrainSubviewToMatchSuperview];
    
    //加载链接
    NSString *urlStr = [self.info objectForKey:@"content"];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
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
