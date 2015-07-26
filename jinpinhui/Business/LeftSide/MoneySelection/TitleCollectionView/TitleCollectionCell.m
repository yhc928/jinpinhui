//
//  TitleCollectionCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/17.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "TitleCollectionCell.h"

@implementation TitleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //标题标签
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.titleLabel.highlightedTextColor = UIColorFromRGB(252, 102, 34);
        self.titleLabel.font = FONT_30PX;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel constrainSubviewToMatchSuperview]; //设置autolayout
        
    }
    return self;
}


@end
