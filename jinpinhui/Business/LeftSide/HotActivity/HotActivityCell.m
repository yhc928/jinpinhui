//
//  HotActivityCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/20.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "HotActivityCell.h"

@implementation HotActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //背景
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, HOT_IMAGE_WIDTH, HOT_IMAGE_HEIGHT+50)];
        bgView.layer.shadowOffset = CGSizeMake(3, 3);
        bgView.layer.shadowOpacity = 0.3;
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        //图片
        self.hotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, HOT_IMAGE_WIDTH, HOT_IMAGE_HEIGHT)];
        [bgView addSubview:self.hotImageView];
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, HOT_IMAGE_HEIGHT, HOT_IMAGE_WIDTH-30, 50)];
        self.titleLabel.textColor = UIColorFromRGB(253, 118, 42);
        self.titleLabel.font = FONT_36PX;
        [bgView addSubview:self.titleLabel];
        
        //结束时间
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, HOT_IMAGE_HEIGHT+30, HOT_IMAGE_WIDTH-10, 20)];
        self.dateLabel.textColor = UIColorFromRGB(253, 118, 42);
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        self.dateLabel.font = FONT_26PX;
        [bgView addSubview:self.dateLabel];
    }
    
    return self;
}

@end
