//
//  ConventionViewController.h
//  jinpinhui
//
//  Created by 于海超 on 15/8/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"

@interface ConventionViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
- (IBAction)submitAction:(id)sender;

@end
