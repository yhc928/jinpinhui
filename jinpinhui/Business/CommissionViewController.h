//
//  CommissionViewController.h
//  jinpinhui
//
//  Created by 于海超 on 15/7/19.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"

@interface CommissionViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *expectLab;  // 预计赚取
@property (weak, nonatomic) IBOutlet UILabel *cumulativeLab;//累计赚取

@end
