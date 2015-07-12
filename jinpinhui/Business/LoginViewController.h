//
//  LoginViewController.h
//  jinpinhui
//
//  Created by 于海超 on 15/7/12.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"
@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *rememberBtn;
@property (weak, nonatomic) IBOutlet UIButton *automaticBtn;
- (IBAction)rememberClick:(id)sender;
- (IBAction)automaticClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginClick:(id)sender;

@end
