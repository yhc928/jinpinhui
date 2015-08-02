//
//  NickNameViewController.h
//  jinpinhui
//
//  Created by 于海超 on 15/8/1.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface NickNameViewController : BaseViewController
@property(nonatomic ,strong)NSString *nickName;
@property (weak, nonatomic) IBOutlet UITextField *nickNameText;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)saveClick:(id)sender;

@end
