//
//  RegisteredViewController.h
//  jinpinhui
//
//  Created by 于海超 on 15/7/12.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisteredViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *confirmText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIButton *sendcodeBtn;
- (IBAction)sendcodeClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *regBtn;
- (IBAction)regClick:(id)sender;

@end
