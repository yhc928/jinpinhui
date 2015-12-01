//
//  DaKuanViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/23.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "DaKuanViewController.h"

@interface DaKuanViewController ()

@end

@implementation DaKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"打款";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hotac/remit.asp",DOMAIN_NAME]];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.webView reload];
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
