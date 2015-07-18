//
//  TitleCollectionView.h
//  jinpinhui
//
//  Created by xiao7 on 15/7/17.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  首页标题CollectionView
 */
#import <UIKit/UIKit.h>

@interface TitleCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIView *_selectedView;
}

@property (nonatomic, strong) NSArray *dataArray; //数据源

@end
