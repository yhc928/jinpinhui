//
//  HotActivityViewController.h
//  jinpinhui
//
//  Created by xiao7 on 15/7/20.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  热门活动
 */
#import "BaseViewController.h"

@interface HotActivityViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
