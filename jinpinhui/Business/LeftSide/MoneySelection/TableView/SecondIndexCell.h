//
//  SecondIndexCell.h
//  jinpinhui
//
//  Created by xiao7 on 15/7/20.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondIndexCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;    //标题
@property (nonatomic, strong) UILabel *statusLabel;   //状态

@property (nonatomic, strong) UILabel *originLabel;   //投资起点
@property (nonatomic, strong) UILabel *deadlineLabel; //累计净值
@property (nonatomic, strong) UILabel *expectedLabel; //累计收益
@property (nonatomic, strong) UILabel *rebateLabel;   //最高返佣

@end
