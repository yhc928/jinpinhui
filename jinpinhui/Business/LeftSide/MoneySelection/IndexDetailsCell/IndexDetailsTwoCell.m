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
        
        //标题
        self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
        self.subtitleLabel.textColor = [UIColor grayColor];
        self.subtitleLabel.font = FONT_30PX;
        [self.contentView addSubview:self.subtitleLabel];
        
        //正文
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 11, SCREEN_WIDTH-120, 0)];
        self.contentLabel.font = FONT_30PX;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
    }
    
    return self;
}

@end
