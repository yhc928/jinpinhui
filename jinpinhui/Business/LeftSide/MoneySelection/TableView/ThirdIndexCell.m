//
//  ThirdIndexCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/30.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "ThirdIndexCell.h"
#define label_width ((SCREEN_WIDTH-30)/4)

@implementation ThirdIndexCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 20)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = FONT_28PX;
        [self.contentView addSubview:self.titleLabel];
        
        //状态
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 0, 50, 15)];
        self.statusLabel.textColor = [UIColor whiteColor];
        self.statusLabel.textAlignment = NSTextAlignmentCenter;
        self.statusLabel.font = FONT_26PX;
        [self.contentView addSubview:self.statusLabel];
        
        //投资起点
        self.originLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, label_width, 20)];
        self.originLabel.textColor = [UIColor blackColor];
        self.originLabel.textAlignment = NSTextAlignmentLeft;
        self.originLabel.font = FONT_32PX;
        [self.contentView addSubview:self.originLabel];
        
        //投资起点标题
        UILabel *originTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, label_width, 15)];
        originTitleLabel.textColor = [UIColor grayColor];
        originTitleLabel.text = @"投资起点";
        originTitleLabel.textAlignment = NSTextAlignmentLeft;
        originTitleLabel.font = FONT_24PX;
        [self.contentView addSubview:originTitleLabel];
        
        //投资期限
        self.deadlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width, 40, label_width, 20)];
        self.deadlineLabel.textColor = [UIColor blackColor];
        self.deadlineLabel.textAlignment = NSTextAlignmentCenter;
        self.deadlineLabel.font = FONT_32PX;
        [self.contentView addSubview:self.deadlineLabel];
        
        //投资期限标题
        UILabel *deadlineTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width, 60, label_width, 15)];
        deadlineTitleLabel.textColor = [UIColor grayColor];
        deadlineTitleLabel.text = @"投资期限";
        deadlineTitleLabel.textAlignment = NSTextAlignmentCenter;
        deadlineTitleLabel.font = FONT_24PX;
        [self.contentView addSubview:deadlineTitleLabel];
        
        //募集状态
        self.expectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width*2, 40, label_width, 20)];
        self.expectedLabel.textColor = [UIColor blackColor];
        self.expectedLabel.textAlignment = NSTextAlignmentCenter;
        self.expectedLabel.font = FONT_32PX;
        [self.contentView addSubview:self.expectedLabel];
        
        //募集状态标题
        UILabel *expectedTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width*2, 60, label_width, 15)];
        expectedTitleLabel.textColor = [UIColor grayColor];
        expectedTitleLabel.text = @"募集状态";
        expectedTitleLabel.textAlignment = NSTextAlignmentCenter;
        expectedTitleLabel.font = FONT_24PX;
        [self.contentView addSubview:expectedTitleLabel];
        
        //最高返佣
        self.rebateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width*3, 40, label_width, 20)];
        self.rebateLabel.textColor = [UIColor blackColor];
        self.rebateLabel.textAlignment = NSTextAlignmentRight;
        self.rebateLabel.font = FONT_32PX;
        [self.contentView addSubview:self.rebateLabel];
        
        //最高返佣标题
        UILabel *rebateTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+label_width*3, 60, label_width, 15)];
        rebateTitleLabel.textColor = [UIColor grayColor];
        rebateTitleLabel.text = @"最高返佣";
        rebateTitleLabel.textAlignment = NSTextAlignmentRight;
        rebateTitleLabel.font = FONT_24PX;
        [self.contentView addSubview:rebateTitleLabel];
    }
    
    return self;
}

@end
