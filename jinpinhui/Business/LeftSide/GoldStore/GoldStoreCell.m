//
//  GoldStoreCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/26.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "GoldStoreCell.h"

@implementation GoldStoreCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GOLD_IMAGE_WIDTH+10, GOLD_IMAGE_HEIGHT+50)];
        bgView.layer.shadowOffset = CGSizeMake(3, 3);
        bgView.layer.shadowOpacity = 0.3;
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        //图片
        self.goodsImageView = [[UIImageView alloc] init];
        self.goodsImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [bgView addSubview:self.goodsImageView];
        
        //剩余时间背景
        UIView *dateBgView = [[UIView alloc] init];
        dateBgView.backgroundColor = UIColorFromRGB(251, 108, 66);
        dateBgView.translatesAutoresizingMaskIntoConstraints = NO;
        [bgView addSubview:dateBgView];
        
        //剩余时间图标
        UIImageView *dateImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gold_time_icon"]];
        dateImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [dateBgView addSubview:dateImageView];
        
        //剩余时间时间
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.textColor = [UIColor whiteColor];
        self.dateLabel.font = FONT_22PX;
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [dateBgView addSubview:self.dateLabel];
        
        //标题
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = UIColorFromRGB(121, 193, 113);
        self.titleLabel.font = FONT_26PX;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [bgView addSubview:self.titleLabel];
        
        //价格
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.textColor = UIColorFromRGB(253, 157, 94);
        self.priceLabel.font = FONT_30PX;
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [bgView addSubview:self.priceLabel];
        
        //价格图标
        UIImageView *priceImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gold_store_coins"]];
        priceImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [bgView addSubview:priceImageView];
        
        //设置autoLayout
        NSDictionary *viewsDictionary = @{@"goodsImageView":self.goodsImageView,
                                          @"dateBgView":dateBgView,
                                          @"dateImageView":dateImageView,
                                          @"dateLabel":self.dateLabel,
                                          @"titleLabel":self.titleLabel,
                                          @"priceLabel":self.priceLabel,
                                          @"priceImageView":priceImageView};
        
        NSDictionary *metrics = @{@"image_height":@GOLD_IMAGE_HEIGHT,
                                  @"date_width":@(GOLD_IMAGE_WIDTH/2)};
        
        //约束1 横向 Horizontal
        [bgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[goodsImageView]-5-|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
        [bgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[titleLabel]->=0-[priceLabel]-10-[priceImageView(18)]-10-|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
        [bgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:[dateBgView(date_width)]-5-|"
                                                 options:0
                                                 metrics:metrics
                                                   views:viewsDictionary]];
        
        [dateBgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[dateImageView(10)]->=0-[dateLabel]-5-|"
                                                 options:0
                                                 metrics:metrics
                                                   views:viewsDictionary]];
        
        //约束2 纵向 Vertical
        [bgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[goodsImageView(image_height)]->=0-[titleLabel]-10-|"
                                                 options:0
                                                 metrics:metrics
                                                   views:viewsDictionary]];
        
        [bgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[priceLabel]-10-|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
        [bgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[priceImageView(19)]-10-|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
        [bgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[dateBgView(16)]"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
        [bgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[dateImageView(10)]-3-|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
        [bgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[dateLabel]|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
    }
    return self;
}

@end
