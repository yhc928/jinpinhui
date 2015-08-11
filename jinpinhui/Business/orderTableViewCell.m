//
//  orderTableViewCell.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "orderTableViewCell.h"

@implementation orderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 20)];
        _titleLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLab];
        
        _amountLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLab.frame) + 10, SCREEN_WIDTH / 4, 20)];
        _amountLab.font = [UIFont systemFontOfSize:14];
        _amountLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_amountLab];
        
        UILabel *amoutInfo = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_amountLab.frame), SCREEN_WIDTH / 4, 20)];
        amoutInfo.font = [UIFont systemFontOfSize:14];
        amoutInfo.text = @"成交金额";
        amoutInfo.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:amoutInfo];
        
        _commissionLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_amountLab.frame), CGRectGetMaxY(_titleLab.frame) + 10, SCREEN_WIDTH / 4, 20)];
        _commissionLab.font = [UIFont systemFontOfSize:15];
        _commissionLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_commissionLab];
        
        UILabel *commissionInfo = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_amountLab.frame), CGRectGetMaxY(_amountLab.frame), SCREEN_WIDTH / 4, 20)];
        commissionInfo.font = [UIFont systemFontOfSize:15];
        commissionInfo.text = @"应得佣金";
        commissionInfo.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:commissionInfo];
        
        _settlementLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_commissionLab.frame), CGRectGetMaxY(_titleLab.frame) + 10, SCREEN_WIDTH / 4, 20)];
        _settlementLab.font = [UIFont systemFontOfSize:14];
        _settlementLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_settlementLab];
        
        UILabel *settlementInfo = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_commissionLab.frame), CGRectGetMaxY(_commissionLab.frame), SCREEN_WIDTH / 4, 20)];
        settlementInfo.font = [UIFont systemFontOfSize:14];
        settlementInfo.text = @"结算情况";
        settlementInfo.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:settlementInfo];
        
        _dateLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_settlementLab.frame), CGRectGetMaxY(_titleLab.frame) + 10, SCREEN_WIDTH / 4, 20)];
        _dateLab.font = [UIFont systemFontOfSize:14];
        _dateLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_dateLab];
        
        UILabel *dateInfo = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_settlementLab.frame), CGRectGetMaxY(_commissionLab.frame), SCREEN_WIDTH / 4, 20)];
        dateInfo.font = [UIFont systemFontOfSize:14];
        dateInfo.text = @"成交日期";
        dateInfo.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:dateInfo];
        
    }
    return self;
}
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    _titleLab.text = [dataDic objectForKey:@"pid"];
    _amountLab.text = [dataDic objectForKey:@"goldB"];
    _commissionLab.text = [dataDic objectForKey:@"goldA"];
    _settlementLab.text = [dataDic objectForKey:@"js"];
    _dateLab.text = [dataDic objectForKey:@"cdate"];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
