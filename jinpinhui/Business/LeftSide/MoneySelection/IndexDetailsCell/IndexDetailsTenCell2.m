//
//  IndexDetailsTenCell2.m
//  jinpinhui
//
//  Created by 陈震 on 15/10/9.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsTenCell2.h"
#define label_width (SCREEN_WIDTH/4)

@implementation IndexDetailsTenCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //沪深300
        UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(50, 20, 10, 10)];
        hView.backgroundColor = UIColorFromRGB(78, 158, 28);
        [self.contentView addSubview:hView];
        
        UILabel *hLabel = [[UILabel alloc] initWithFrame:CGRectMake(63, 20, 60, 10)];
        hLabel.textColor = UIColorFromRGB(78, 158, 28);
        hLabel.text = @"沪深300";
        hLabel.font = FONT_22PX;
        [self.contentView addSubview:hLabel];
        
        //复权净值
        UIView *fView = [[UIView alloc] initWithFrame:CGRectMake(130, 20, 10, 10)];
        fView.backgroundColor = UIColorFromRGB(178, 31, 121);
        [self.contentView addSubview:fView];
        
        UILabel *fLabel = [[UILabel alloc] initWithFrame:CGRectMake(143, 20, 60, 10)];
        fLabel.textColor = UIColorFromRGB(178, 31, 121);
        fLabel.text = @"复权净值";
        fLabel.font = FONT_22PX;
        [self.contentView addSubview:fLabel];
        
        //分割线
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(35, 56, SCREEN_WIDTH-90, 0.5)];
        lineView2.backgroundColor = UIColorFromRGB(200, 200, 200);
        [self.contentView addSubview:lineView2];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(35, 56+50, SCREEN_WIDTH-90, 0.5)];
        lineView1.backgroundColor = UIColorFromRGB(200, 200, 200);
        [self.contentView addSubview:lineView1];
        
        UIView *lineView0 = [[UIView alloc] initWithFrame:CGRectMake(35, 56+50+50, SCREEN_WIDTH-90, 0.5)];
        lineView0.backgroundColor = UIColorFromRGB(200, 200, 200);
        [self.contentView addSubview:lineView0];
        
        //For Line Chart
        _lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH-30, 150.0)];
        _lineChart.backgroundColor = [UIColor clearColor];
        _lineChart.yLabelColor = [UIColor grayColor];
        _lineChart.yLabelFont = FONT_22PX;
        _lineChart.xLabelColor = [UIColor grayColor];
        _lineChart.xLabelFont = FONT_22PX;
        _lineChart.yFixedValueMax = 2;
        _lineChart.yFixedValueMin = 0;
        [self.contentView addSubview:_lineChart];
        
        //分割线
        UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 190, SCREEN_WIDTH, 0.5)];
        lineView3.backgroundColor = UIColorFromRGB(200, 200, 200);
        [self.contentView addSubview:lineView3];
        
        UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, 0.5)];
        lineView4.backgroundColor = UIColorFromRGB(200, 200, 200);
        [self.contentView addSubview:lineView4];
        
        NSArray *titleArray = @[@"净值日期",@"单位净值",@"累计净值",@"增长率"];
        for (int i = 0; i < 4; i ++) {
            NSString *title = titleArray[i];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(label_width*i, 190, label_width, 30)];
            label.text = title;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = FONT_28PX;
            [self.contentView addSubview:label];
        }
    }
    
    return self;
}

- (void)setBlocks:(NSArray *)blocks
{
    _blocks = blocks;
    
    NSMutableArray *xLabels = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *data01Array = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *data02Array = [[NSMutableArray alloc] initWithCapacity:0];
    
    //移除详情view
    for (UIView *view in self.contentView.subviews) {
        if (view.tag > 0) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < _blocks.count; i ++) {
        NSDictionary *block = _blocks[i];
        NSNumber *fvalue = [NSNumber numberWithDouble:[block[@"fvalue"] doubleValue]];
        NSNumber *h300 = [NSNumber numberWithDouble:[block[@"h300"] doubleValue]];
        
        [xLabels addObject:block[@"ndate"]];
        [data01Array addObject:fvalue];
        [data02Array addObject:h300];
        
        NSArray *valueArray = @[block[@"ndate"],block[@"nvalue"],block[@"cvalue"],block[@"rate"]];
        for (int j = 0; j < 4 && j < valueArray.count; j ++) {
            NSString *value = valueArray[j];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(label_width*j, 220+30*i, label_width, 30)];
            label.text = value;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = FONT_28PX;
            label.tag = 11;
            [self.contentView addSubview:label];
        }
    }
    
    //x y轴数据
    _lineChart.xLabels = xLabels;
    _lineChart.yLabels = @[@"0",@"1",@"2"];
    
    // Line Chart No.1
    PNLineChartData *data01 = [[PNLineChartData alloc] init];
    data01.lineWidth = 1;
    data01.color = UIColorFromRGB(78, 158, 28);
    data01.itemCount = _lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart No.2
    PNLineChartData *data02 = [[PNLineChartData alloc] init];
    data02.lineWidth = 1;
    data02.color = UIColorFromRGB(178, 31, 121);
    data02.itemCount = _lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    _lineChart.chartData = @[data01, data02];
    [_lineChart strokeChart];
}

@end
