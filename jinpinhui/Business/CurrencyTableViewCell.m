//
//  CurrencyTableViewCell.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/1.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "CurrencyTableViewCell.h"

@implementation CurrencyTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        _datetimeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 3, CGRectGetHeight(self.frame))];
        _datetimeLab.font = [UIFont systemFontOfSize:14];
        _datetimeLab.textColor = UIColorFromRGB(129, 130, 131);
        _datetimeLab.backgroundColor = [UIColor clearColor];
        _datetimeLab.textAlignment = NSTextAlignmentCenter;
        _datetimeLab.numberOfLines = 0;
        
        _infoLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 0, SCREEN_WIDTH / 3, CGRectGetHeight(self.frame))];
        _infoLab.font = [UIFont systemFontOfSize:14];
        _infoLab.textColor = UIColorFromRGB(129, 130, 131);
        _infoLab.backgroundColor = [UIColor clearColor];
        _infoLab.textAlignment = NSTextAlignmentCenter;
        _infoLab.numberOfLines = 0;
        
        _currencyLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * 2, 0, SCREEN_WIDTH / 3, CGRectGetHeight(self.frame))];
        _currencyLab.font = [UIFont systemFontOfSize:14];
        _currencyLab.textColor = UIColorFromRGB(166, 46, 48);
        _currencyLab.backgroundColor = [UIColor clearColor];
        _currencyLab.textAlignment = NSTextAlignmentCenter;
        _currencyLab.numberOfLines = 0;
        [self.contentView addSubview:_datetimeLab];
        [self.contentView addSubview:_infoLab];
        [self.contentView addSubview:_currencyLab];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
