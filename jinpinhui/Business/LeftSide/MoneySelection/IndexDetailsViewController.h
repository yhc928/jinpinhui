//
//  IndexDetailsViewController.h
//  jinpinhui
//
//  Created by xiao7 on 15/8/11.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  产品详情
 */
#import "BaseViewController.h"
#import "IndexDetailsTenView.h"

@interface IndexDetailsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,IndexDetailsTenViewDelegate>

@property (nonatomic, strong) NSString *iname; //产品名称
@property (nonatomic, strong) NSString *iD; //产品id

@end
