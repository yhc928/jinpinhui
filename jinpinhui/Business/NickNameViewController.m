//
//  NickNameViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/1.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "NickNameViewController.h"

@interface NickNameViewController ()

@end

@implementation NickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _nickNameText.layer.borderWidth = 1;
    _nickNameText.layer.borderColor = [UIColorFromRGB(202, 202, 208) CGColor];
    _nickNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nickNameText.text = self.nickName;
    _saveBtn.adjustsImageWhenHighlighted = NO;
    
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

- (IBAction)saveClick:(id)sender {
    
}
@end
