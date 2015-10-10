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
        
        //For Line Chart
        PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-15, 200.0)];
        [lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3"]];
        [lineChart setYLabels:@[@"0",@"1",@"2"]];
        lineChart.showCoordinateAxis = YES;
        lineChart.yFixedValueMax = 2;
        lineChart.yFixedValueMin = 0;
        
        // Line Chart No.1
        NSArray * data01Array = @[@1.1, @1.2, @0.9];
        PNLineChartData *data01 = [PNLineChartData new];
        data01.lineWidth = 1;
        data01.color = PNFreshGreen;
        data01.itemCount = lineChart.xLabels.count;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        // Line Chart No.2
        NSArray * data02Array = @[@1.1, @1.01, @1.1];
        PNLineChartData *data02 = [PNLineChartData new];
        data02.lineWidth = 1;
        data02.color = PNTwitterColor;
        data02.itemCount = lineChart.xLabels.count;
        data02.getData = ^(NSUInteger index) {
            CGFloat yValue = [data02Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        lineChart.chartData = @[data01, data02];
        [lineChart strokeChart];
        
        [self.contentView addSubview:lineChart];
    }
    
    return self;
}

@end
