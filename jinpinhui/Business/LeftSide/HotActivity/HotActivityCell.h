//
//  HotActivityCell.h
//  jinpinhui
//
//  Created by xiao7 on 15/7/20.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  热门活动cell
 */
#import <UIKit/UIKit.h>

@interface HotActivityCell : UITableViewCell

@property (nonatomic, strong) UIImageView *hotImageView; //图片
@property (nonatomic, strong) UILabel     *titleLabel;   //标题标题
@property (nonatomic ,strong) UILabel     *dateLabel;    //结束时间

@end
