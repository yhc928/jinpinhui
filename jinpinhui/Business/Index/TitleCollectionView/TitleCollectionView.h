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
@protocol TitleCollectionViewDelegate;

@interface TitleCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIView *_selectedView;
    NSInteger _lastMultiple;
    NSInteger _currentMultiple;
}

@property (nonatomic, assign) BOOL                        isScroll;
@property (nonatomic, strong) NSArray                     *dataArray; //数据源
@property (nonatomic, weak  ) id<TitleCollectionViewDelegate> myDelegate;

- (void)bgScrollViewDidScroll:(CGFloat)content_x;

@end

@protocol TitleCollectionViewDelegate <NSObject>

- (void)titleCollectionView:(TitleCollectionView *)titleCollectionView didSelectedIndex:(NSInteger)index;

@end
