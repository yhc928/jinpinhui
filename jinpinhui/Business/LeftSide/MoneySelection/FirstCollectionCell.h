//
//  FirstCollectionCell.h
//  jinpinhui
//
//  Created by xiao7 on 15/7/26.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  首页CollectionViewCell
 */
#import <UIKit/UIKit.h>
#import "CycleScrollView.h"

@interface FirstCollectionCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource,CycleScrollViewDelegate>

@property (nonatomic, strong) UITableView     *tableView;       //产品tableView
@property (nonatomic, strong) CycleScrollView *cycleScrollView; //轮播图

@property (nonatomic, strong) NSArray         *dataArray;       //数据源
@property (nonatomic, strong) NSArray         *imageArray;      //轮播图数据源

@end
