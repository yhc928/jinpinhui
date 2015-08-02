//
//  AddressViewController.h
//  jinpinhui
//
//  Created by 于海超 on 15/8/1.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
@property (weak, nonatomic) IBOutlet UITextField *consigneeText;
@property (weak, nonatomic) IBOutlet UITextField *cityText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UIView *cityView;
- (IBAction)SvaeClick:(id)sender;

@end
