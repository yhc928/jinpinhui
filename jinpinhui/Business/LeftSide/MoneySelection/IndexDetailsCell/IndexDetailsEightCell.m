//
//  IndexDetailsEightCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/11.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsEightCell.h"

@implementation IndexDetailsEightCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.lineView1 = [[UIView alloc] init];
        self.lineView1.backgroundColor = LAYER_COLOR;
        [self.contentView addSubview:self.lineView1];
        
        self.lineView2 = [[UIView alloc] init];
        self.lineView2.backgroundColor = LAYER_COLOR;
        [self.contentView addSubview:self.lineView2];
        
        self.lineView3 = [[UIView alloc] init];
        self.lineView3.backgroundColor = LAYER_COLOR;
        [self.contentView addSubview:self.lineView3];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = FONT_28PX;
        [self.contentView addSubview:self.titleLabel];
        
        self.subtitleLabel1 = [[UILabel alloc] init];
        self.subtitleLabel1.textColor = [UIColor grayColor];
        self.subtitleLabel1.textAlignment = NSTextAlignmentCenter;
        self.subtitleLabel1.font = FONT_28PX;
        [self.contentView addSubview:self.subtitleLabel1];
        
        self.subtitleLabel2 = [[UILabel alloc] init];
        self.subtitleLabel2.textColor = [UIColor grayColor];
        self.subtitleLabel2.textAlignment = NSTextAlignmentCenter;
        self.subtitleLabel2.font = FONT_28PX;
        [self.contentView addSubview:self.subtitleLabel2];
        
        self.detailsLabel1 = [[UILabel alloc] init];
        self.detailsLabel1.textColor = [UIColor grayColor];
        self.detailsLabel1.numberOfLines = 0;
        self.detailsLabel1.font = FONT_28PX;
        [self.contentView addSubview:self.detailsLabel1];
        
        self.detailsLabel2 = [[UILabel alloc] init];
        self.detailsLabel2.textColor = [UIColor grayColor];
        self.detailsLabel2.numberOfLines = 0;
        self.detailsLabel2.font = FONT_28PX;
        [self.contentView addSubview:self.detailsLabel2];
    }
    
    return self;
}

@end
