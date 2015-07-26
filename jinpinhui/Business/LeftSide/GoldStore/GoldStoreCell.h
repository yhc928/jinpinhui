//
//  GoldStoreCell.h
//  jinpinhui
//
//  Created by xiao7 on 15/7/26.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoldStoreCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *goodsImageView; //图片
@property (nonatomic, strong) UILabel *dateLabel; //剩余时间
@property (nonatomic, strong) UILabel *titleLabel; //标题
@property (nonatomic, strong) UILabel *priceLabel; //价格

@end
