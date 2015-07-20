//
//  LeftSideViewController.h
//  jinpinhui
//
//  Created by xiao7 on 15/7/12.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  左侧VC
 */
#import "BaseViewController.h"

@interface LeftSideViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UINavigationController *indexNav;

@end
