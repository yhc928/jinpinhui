//
//  ContentDetailsViewController.h
//  jinpinhui
//
//  Created by 陈震 on 15/8/23.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"

@interface ContentDetailsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *info;

@end
