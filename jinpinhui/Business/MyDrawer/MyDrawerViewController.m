//
//  MyDrawerViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/19.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "MyDrawerViewController.h"

@interface MyDrawerViewController ()

@end

@implementation MyDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
