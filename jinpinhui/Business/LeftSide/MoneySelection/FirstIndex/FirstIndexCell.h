//
//  FirstIndexCell.h
//  jinpinhui
//
//  Created by xiao7 on 15/7/20.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstIndexCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;    //标题
@property (nonatomic, strong) UILabel *statusLabel;   //状态

@property (nonatomic, strong) UILabel *originLabel;   //投资起点
@property (nonatomic, strong) UILabel *deadlineLabel; //投资期限
@property (nonatomic, strong) UILabel *expectedLabel; //预期收益
@property (nonatomic, strong) UILabel *rebateLabel;   //最高返佣

@property (nonatomic, strong) UIView *progressView;   //进度条
@property (nonatomic, strong) UILabel *raiseLabel;    //已募集

@end
