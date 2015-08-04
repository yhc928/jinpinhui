//
//  SecondCollectionCell.h
//  jinpinhui
//
//  Created by xiao7 on 15/7/26.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  首页第二种CollectionViewCell
 */
#import <UIKit/UIKit.h>
#import "CZRequest.h"

@interface SecondCollectionCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate,CZRequestHelperDelegate>

@property (nonatomic, strong) UITableView *tableView; //产品tableView
@property (nonatomic, strong) NSArray     *dataArray; //数据源
@property (nonatomic, strong) NSString    *ttp; //项目类别类型

@end
