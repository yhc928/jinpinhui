//
//  InvitationViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/19.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "InvitationViewController.h"

@interface InvitationViewController ()

@end

@implementation InvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"邀请好友赚金币";
     [_invitationBtn setBackgroundImage:[UIImage imageNamed:@"loginback_highlighted"] forState:UIControlStateHighlighted];
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
