//
//  ModifyPasswordViewController.h
//  jinpinhui
//
//  Created by 于海超 on 15/8/2.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"

@interface ModifyPasswordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordText;

@property (weak, nonatomic) IBOutlet UITextField *NewPasswordText;
@property (weak, nonatomic) IBOutlet UITextField *determineText;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
- (IBAction)completeClick:(id)sender;

@end
