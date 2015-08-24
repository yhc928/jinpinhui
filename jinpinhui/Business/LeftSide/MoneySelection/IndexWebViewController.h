//
//  IndexWebViewController.h
//  jinpinhui
//
//  Created by 陈震 on 15/8/24.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"

@interface IndexWebViewController : BaseViewController<UIWebViewDelegate>

@property (nonatomic, strong) NSDictionary *info;

@end
