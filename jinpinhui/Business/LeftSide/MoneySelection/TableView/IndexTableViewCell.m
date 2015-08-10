//
//  IndexTableViewCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexTableViewCell.h"
#define label_width ((SCREEN_WIDTH-30)/4)

@implementation IndexTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 250, 20)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = FONT_28PX;
        [self.contentView addSubview:self.titleLabel];
        
        //状态
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 0, 50, 15)];
        self.statusLabel.textColor = [UIColor whiteColor];
        self.statusLabel.textAlignment = NSTextAlignmentCenter;
        self.statusLabel.font = FONT_24PX;
        [self.contentView addSubview:self.statusLabel];
        
        //投资起点
        self.originLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, label_width, 20)];
        self.originLabel.textColor = [UIColor blackColor];
        self.originLabel.textAlignment = NSTextAlignmentLeft;
        self.originLabel.font = FONT_28PX;
        [self.contentView addSubview:self.originLabel];
        
        //投资起点标题
        self.originTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, label_width, 15)];
        self.originTitleLabel.textColor = [UIColor grayColor];
        self.originTitleLabel.text = @"投资起点";
        self.originTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.originTitleLabel.font = FONT_24PX;
        [self.contentView addSubview:self.originTitleLabel];
        
        //投资期限
        self.deadlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width, 40, label_width, 20)];
        self.deadlineLabel.textColor = [UIColor blackColor];
        self.deadlineLabel.textAlignment = NSTextAlignmentCenter;
        self.deadlineLabel.font = FONT_28PX;
        [self.contentView addSubview:self.deadlineLabel];
        
        //投资期限标题
        self.deadlineTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width, 60, label_width, 15)];
        self.deadlineTitleLabel.textColor = [UIColor grayColor];
        self.deadlineTitleLabel.text = @"投资期限";
        self.deadlineTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.deadlineTitleLabel.font = FONT_24PX;
        [self.contentView addSubview:self.deadlineTitleLabel];
        
        //预期收益
        self.expectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width*2, 40, label_width, 20)];
        self.expectedLabel.textColor = [UIColor blackColor];
        self.expectedLabel.textAlignment = NSTextAlignmentCenter;
        self.expectedLabel.font = FONT_28PX;
        [self.contentView addSubview:self.expectedLabel];
        
        //预期收益标题
        self.expectedTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width*2, 60, label_width, 15)];
        self.expectedTitleLabel.textColor = [UIColor grayColor];
        self.expectedTitleLabel.text = @"预期收益";
        self.expectedTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.expectedTitleLabel.font = FONT_24PX;
        [self.contentView addSubview:self.expectedTitleLabel];
        
        //最高返佣
        self.rebateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width*3, 40, label_width, 20)];
        self.rebateLabel.textColor = [UIColor blackColor];
        self.rebateLabel.textAlignment = NSTextAlignmentRight;
        self.rebateLabel.font = FONT_28PX;
        [self.contentView addSubview:self.rebateLabel];
        
        //最高返佣标题
        self.rebateTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width*3, 60, label_width, 15)];
        self.rebateTitleLabel.textColor = [UIColor grayColor];
        self.rebateTitleLabel.text = @"最高返佣";
        self.rebateTitleLabel.textAlignment = NSTextAlignmentRight;
        self.rebateTitleLabel.font = FONT_24PX;
        [self.contentView addSubview:self.rebateTitleLabel];
    }
    
    return self;
}

- (void)setIstate:(NSString *)istate
{
    _istate = istate;
    
    NSInteger state = [_istate integerValue];
    switch (state) {
        case 0: {
            _statusLabel.text = @"在售";
            _statusLabel.backgroundColor = UIColorFromRGB(253, 131, 50);
            break;
        }
        case 1: {
            _statusLabel.text = @"新品";
            _statusLabel.backgroundColor =  UIColorFromRGB(82, 208, 112);
            break;
        }
        case 2: {
            _statusLabel.text = @"售馨";
            _statusLabel.backgroundColor = UIColorFromRGB(253, 131, 50);
            
            break;
        }
        case 3: {
            _statusLabel.text = @"爆款";
            _statusLabel.backgroundColor = UIColorFromRGB(253, 131, 50);
            break;
        }
            
        default:
            break;
    }
}

@end
