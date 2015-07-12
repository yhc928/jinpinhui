//
//  JPHNavigationController.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/12.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "JPHNavigationController.h"
#import "AppMacro.h"
@interface JPHNavigationController ()

@end

@implementation JPHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加手势返回
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    //navigationBar背景图
    
    if (IS_IOS_7) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarbackios7"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarbackios6"] forBarMetrics:UIBarMetricsDefault];
    }
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // fix 'nested pop animation can result in corrupted navigation bar'
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
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
