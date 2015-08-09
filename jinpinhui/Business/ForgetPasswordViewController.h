//
//  ForgetPasswordViewController.h
//  jinpinhui
//
//  Created by 于海超 on 15/8/8.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"

@interface ForgetPasswordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *confirmText;
@property (weak, nonatomic) IBOutlet UIButton *confirmClick;

@end
