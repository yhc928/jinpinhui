//
//  IndexDetailsTenView.m
//  jinpinhui
//
//  Created by 陈震 on 15/10/8.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsTenView.h"

@implementation IndexDetailsTenView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(235, 235, 235);
        CGFloat width = SCREEN_WIDTH/4;
        
        for (int i = 0; i < 4; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(width*i, 0, width, 40);
            [button setBackgroundImage:[UIImage imageNamed:@"index_details_button_nor"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"index_details_button_hl"] forState:UIControlStateHighlighted];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = FONT_30PX;
            button.tag = i + 1;
            [button addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            if (i == 0) {
                [button setBackgroundImage:[UIImage imageNamed:@"index_details_button_sel"] forState:UIControlStateNormal];
            }
        }
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    for (int i = 0; i < 4; i ++) {
        UIButton *button = self.subviews[i];
        NSDictionary *content5 = _dataArray[i];
        NSString *title = content5[@"title"];
        [button setTitle:title forState:UIControlStateNormal];
    }
}

- (void)didButton:(UIButton *)sender
{
    UIImage *selImage = [UIImage imageNamed:@"index_details_button_sel"];
    UIImage *norImage = [UIImage imageNamed:@"index_details_button_nor"];
    
    for (UIButton *button in self.subviews) {
        if (button == sender) {
            [button setBackgroundImage:selImage forState:UIControlStateNormal];
        } else {
            [button setBackgroundImage:norImage forState:UIControlStateNormal];
        }
    }
    
    if ([_delegate respondsToSelector:@selector(indexDetailsTenView:didSelectedIndex:)]) {
        [_delegate indexDetailsTenView:self didSelectedIndex:sender.tag-1];
    }
}

@end
