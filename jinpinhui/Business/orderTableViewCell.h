//
//  orderTableViewCell.h
//  jinpinhui
//
//  Created by 于海超 on 15/8/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderTableViewCell : UITableViewCell
@property(nonatomic ,strong) UILabel *titleLab;
@property(nonatomic ,strong) UILabel *amountLab;
@property(nonatomic ,strong) UILabel *commissionLab;
@property(nonatomic ,strong) UILabel *settlementLab;
@property(nonatomic ,strong) UILabel *dateLab;
@property(nonatomic ,strong) NSDictionary *dataDic;
@end
