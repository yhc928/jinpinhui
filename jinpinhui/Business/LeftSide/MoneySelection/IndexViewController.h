//
//  IndexViewController.h
//  jinpinhui
//
//  Created by xiao7 on 15/7/6.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  首页VC
 */
#import "BaseViewController.h"
#import "TitleCollectionView.h"

@interface IndexViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,TitleCollectionViewDelegate>

@property (nonatomic, strong, readonly) UITableView *currentTableView; //当前页面的tableView

/**
 *  单例
 *
 *  @return IndexViewController
 */
+ (instancetype)sharedClient;

/**
 *  下拉刷新回调方法，在cell中使用
 */
- (void)loadNewData;

@end
