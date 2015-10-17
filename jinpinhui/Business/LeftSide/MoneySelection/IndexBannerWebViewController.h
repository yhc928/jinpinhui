//
//  IndexBannerWebViewController.h
//  jinpinhui
//
//  Created by 陈震 on 15/10/17.
//  Copyright © 2015年 chenzhen. All rights reserved.
//

#import "BaseViewController.h"

@interface IndexBannerWebViewController : BaseViewController<UIWebViewDelegate>

@property (nonatomic, strong) NSString *urlStr;

@end
