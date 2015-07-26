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
#import "CycleScrollView.h"

@interface IndexViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,TitleCollectionViewDelegate,CycleScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end
