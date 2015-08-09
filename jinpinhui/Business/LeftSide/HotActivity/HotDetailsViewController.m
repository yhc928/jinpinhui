//
//  HotDetailsViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "HotDetailsViewController.h"

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
    [self showProgressHUD];
    
//    NSLog(@"urlStr = %@",urlStr);

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
