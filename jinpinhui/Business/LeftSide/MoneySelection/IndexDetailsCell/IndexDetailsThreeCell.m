//
//  IndexDetailsThreeCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/11.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsThreeCell.h"

@implementation IndexDetailsThreeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //正文
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 0)];
        self.contentLabel.textColor = [UIColor grayColor];
        self.contentLabel.font = FONT_28PX;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
    }
    
    return self;
}

@end
