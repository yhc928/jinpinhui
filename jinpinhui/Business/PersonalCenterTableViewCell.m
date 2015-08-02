//
//  PersonalCenterTableViewCell.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/18.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "PersonalCenterTableViewCell.h"

@implementation PersonalCenterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, (CGRectGetHeight(self.frame) - 20) / 2, 100, 20)];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textColor = UIColorFromRGB(86, 87, 88);
        _titleLab.backgroundColor = [UIColor clearColor];
        
        _infoLab = [[UILabel alloc]initWithFrame:CGRectMake(110, (CGRectGetHeight(self.frame) - 20) / 2, SCREEN_WIDTH - 110 - 30, 20)];
        _infoLab.textAlignment = NSTextAlignmentRight;
        _infoLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLab];
        [self.contentView addSubview:_infoLab];
      
    }
    return self;
}
//-(UIImageView *)redenvelopeImg{
//    UIImage *image = [UIImage imageNamed:@"user_info_red_packet"];
//    _redenvelopeImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50 - image.size.width, (CGRectGetHeight(self.frame) - image.size.height) / 2, image.size.width, image.size.height)];
//    _redenvelopeImg .image = image;
//    return _redenvelopeImg;
//}
//-(void)setDataList:(NSMutableArray *)dataList{
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
