//
//  UIView+AutoLayout.h
//  Shequ001
//
//  Created by cz on 15/3/11.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)

/**
 * 功能：设置autoLayout，subview和superview尺寸一样
 */
- (void)constrainSubviewToMatchSuperview;

/**
 * 功能：设置autoLayout，subview距离superview上下左右边距
 */
- (void)constrainSubviewToMatchSuperviewWithEdgeInsets:(UIEdgeInsets)edgeInsets;

/**
 * 功能：设置autoLayout，subview距离superview下左右的边距，设置高度
 */
//- (void)constrainSubviewToMatchSuperviewWithEdgeInsets:(UIEdgeInsets)edgeInsets height:(CGFloat)height;

/**
 * 功能：设置autoLayout，subview距离scrollView上左右的边距，设置宽高
 */
//- (void)constrainSubviewToMatchScrollViewWithEdgeInsets:(UIEdgeInsets)edgeInsets size:(CGSize)size;

@end
