//
//  IndexDetailsTenCell2.h
//  jinpinhui
//
//  Created by 陈震 on 15/10/9.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h"

@interface IndexDetailsTenCell2 : UITableViewCell
{
    PNLineChart *_lineChart;
}

@property (nonatomic, strong) NSArray *blocks;

@end
