//
//  IndexDetailsTenCell2.m
//  jinpinhui
//
//  Created by 陈震 on 15/10/9.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsTenCell2.h"

@implementation IndexDetailsTenCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        self.lineChart.backgroundColor = [UIColor clearColor];
        self.lineChart.xLabels = @[@"净值日期",@"单位净值",@"累计净值"];
        self.lineChart.yLabels = @[@0,@1,@2];
        [self.lineChart setYValues:@[@1.1,@1.02,@1.2]];
        [self.lineChart strokeChart];
        [self.contentView addSubview:self.lineChart];
    }
    
    return self;
}

@end
