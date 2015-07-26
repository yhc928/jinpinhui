//
//  GoldStoreCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/26.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "GoldStoreCell.h"

#define image_width ((SCREEN_WIDTH-30-5*4)/2)
#define image_height image_width

@implementation GoldStoreCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image_width+10, image_height+50)];
        bgView.layer.shadowOffset = CGSizeMake(3, 3);
        bgView.layer.shadowOpacity = 0.3;
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        //图片
        self.goodsImageView = [[UIImageView alloc] init];
        self.goodsImageView.backgroundColor = [UIColor brownColor];
        self.goodsImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [bgView addSubview:self.goodsImageView];
        
        //剩余时间时间
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.backgroundColor = UIColorFromRGB(251, 108, 66);
        self.dateLabel.textColor = [UIColor whiteColor];
        self.dateLabel.font = FONT_24PX;
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.goodsImageView addSubview:self.dateLabel];
        
        //标题
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = UIColorFromRGB(121, 193, 113);
        self.titleLabel.font = FONT_24PX;
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
                                          @"dateLabel":self.dateLabel,
                                          @"titleLabel":self.titleLabel,
                                          @"priceLabel":self.priceLabel,
                                          @"priceImageView":priceImageView};
        
        NSDictionary *metrics = @{@"image_height":@image_width,
                                  @"date_width":@(image_width/2)};
        
        //约束1 横向 Horizontal
        [bgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[goodsImageView]-5-|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
        [bgView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[titleLabel]->=0-[priceLabel]-5-[priceImageView(18)]-5-|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
        [self.goodsImageView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:[dateLabel(date_width)]|"
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
        
        [self.goodsImageView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[dateLabel(16)]"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
    }
    return self;
}

@end
