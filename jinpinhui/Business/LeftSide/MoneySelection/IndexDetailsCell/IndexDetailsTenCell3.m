//
//  IndexDetailsTenCell3.m
//  jinpinhui
//
//  Created by 陈震 on 15/10/9.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsTenCell3.h"

@implementation IndexDetailsTenCell3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 40)];
        self.titleLabel.font = FONT_30PX;
        [self.contentView addSubview:self.titleLabel];
        
        //分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = UIColorFromRGB(200, 199, 204);
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
