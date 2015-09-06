//
//  HotDetailsViewController.h
//  jinpinhui
//
//  Created by xiao7 on 15/8/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  活动详情
 */
#import "BaseViewController.h"

@interface HotDetailsViewController : BaseViewController<UIWebViewDelegate>

@property (nonatomic, strong) NSString *hotTitle; //标题
@property (nonatomic, strong) NSString *bimg; //活动地址

@end
