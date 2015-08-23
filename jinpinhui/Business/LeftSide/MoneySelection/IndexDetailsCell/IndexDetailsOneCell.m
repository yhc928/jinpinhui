//
//  IndexDetailsOneCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/11.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsOneCell.h"

@implementation IndexDetailsOneCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, 40)];
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.font = FONT_28PX;
        [self.contentView addSubview:self.titleLabel];
        
        //正文
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH-95, 0)];
        self.contentLabel.font = FONT_28PX;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
    }
    
    return self;
}

@end
