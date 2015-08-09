//
//  RedEnvelopeViewController.h
//  jinpinhui
//
//  Created by 于海超 on 15/8/1.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"

@interface RedEnvelopeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *currencyLab;
- (IBAction)receiveClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *receiveBtn;
@property (weak, nonatomic) IBOutlet UIImageView *currencyImage;

@end
