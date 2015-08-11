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
{
    NSInteger _nextPage; //下一页
}

@property (nonatomic, strong) UITableView         *tableView;//产品tableView
@property (nonatomic, strong) NSMutableArray      *dataArray;//数据源
@property (nonatomic, strong) NSString            *tpID;//产品id
@property (nonatomic, strong) NSString            *tsubcount;//产品数量
@property (nonatomic, strong) NSMutableDictionary *moreDict;

@end
