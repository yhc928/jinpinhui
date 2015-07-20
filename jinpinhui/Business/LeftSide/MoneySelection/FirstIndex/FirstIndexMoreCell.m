//
//  FirstIndexMoreCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/20.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "FirstIndexMoreCell.h"

@implementation FirstIndexMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //按钮
        self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.moreButton.frame = CGRectMake(15, 15, SCREEN_WIDTH-30, 45);
        [self.moreButton setBackgroundImage:[UIImage imageNamed:@"first_index_more_normal"] forState:UIControlStateNormal];
        [self.moreButton setBackgroundImage:[UIImage imageNamed:@"first_index_more_highlighted"] forState:UIControlStateHighlighted];
        [self.moreButton setTitle:@"点击或向左滑动查看更多产品" forState:UIControlStateNormal];
        [self.moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.moreButton.titleLabel.font = FONT_32PX;
//        [self.moreButton addTarget:self action:@selector(didMoreButton) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.moreButton];
    }
    
    return self;
}

@end
