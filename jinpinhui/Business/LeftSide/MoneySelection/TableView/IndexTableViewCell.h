//
//  IndexTableViewCell.h
//  jinpinhui
//
//  Created by xiao7 on 15/8/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;         //标题

@property (nonatomic, strong) NSString *istate;
@property (nonatomic, strong) UILabel *statusLabel;        //状态

@property (nonatomic, strong) UILabel *originLabel;        //投资起点
@property (nonatomic, strong) UILabel *originTitleLabel;   //投资起点标题

@property (nonatomic, strong) UILabel *deadlineLabel;      //投资期限
@property (nonatomic, strong) UILabel *deadlineTitleLabel; //投资期限标题

@property (nonatomic, strong) UILabel *expectedLabel;      //预期收益
@property (nonatomic, strong) UILabel *expectedTitleLabel; //预期收益标题

@property (nonatomic, strong) UILabel *rebateLabel;        //最高返佣
@property (nonatomic, strong) UILabel *rebateTitleLabel;   //最高返佣标题

@end
