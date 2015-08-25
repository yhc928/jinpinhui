//
//  IndexDetailsTwoCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/11.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsTwoCell.h"

@implementation IndexDetailsTwoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 40)];
        self.titleLabel.font = FONT_28PX;
        self.titleLabel.userInteractionEnabled = YES;
        [self.contentView addSubview:self.titleLabel];
        
        //箭头
        self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 8, 24, 24)];
        [self.contentView addSubview:self.arrowImageView];
        
        //分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = LAYER_COLOR;
        [self.contentView addSubview:lineView];
        
        //正文
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40.5, SCREEN_WIDTH-30, 0)];
        self.contentLabel.textColor = [UIColor grayColor];
        self.contentLabel.font = FONT_28PX;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
    }
    
    return self;
}

@end
