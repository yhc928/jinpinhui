//
//  CycleScrollView.h
//  UISrollView-循环滚动
//
//  Created by 陈震 on 14-6-29.
//  Copyright (c) 2014年 chenzhen. All rights reserved.
//

/**
 *  首页循环滚动
 */
#import <UIKit/UIKit.h>

@protocol CycleScrollViewDelegate;

@interface CycleScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray                 *imageArray;  //图片数据源
@property (nonatomic, strong) UIScrollView            *scrollView;  //滚动背景
@property (nonatomic, weak  ) id<CycleScrollViewDelegate> delegate; //代理

@end

//代理
@protocol CycleScrollViewDelegate <NSObject>

/**
 *  点击第几张图片回调
 *
 *  @param cycleScrollView CycleScrollView
 *  @param index           图片的位置
 */
- (void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectImageView:(NSInteger)index;

@end