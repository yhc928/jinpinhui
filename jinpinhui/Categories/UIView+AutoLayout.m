//
//  UIView+AutoLayout.m
//  Shequ001
//
//  Created by cz on 15/3/11.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

/**
 * 要实现自动布局，必须把该属性设置为NO
 * self.translatesAutoresizingMaskIntoConstraints = NO;
 * 通过宏映射成字典[NSDictionary dictionaryWithObjectsAndKeys:v1, @"v1", nil];
 * NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self);
 */

//设置autoLayout，subview和superview尺寸一样
- (void)constrainSubviewToMatchSuperview
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self);
    //约束1 横向 Horizontal
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    //约束2 纵向 Vertical
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
}

//设置autoLayout，subview距离superview上下左右边距
- (void)constrainSubviewToMatchSuperviewWithEdgeInsets:(UIEdgeInsets)edgeInsets
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self);
    
    //约束1 横向 Horizontal
    NSString *formatH = [NSString stringWithFormat:@"H:|-%f-[self]-%f-|",edgeInsets.left,edgeInsets.right];
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:formatH
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    //约束2 纵向 Vertical
    NSString *formatV = [NSString stringWithFormat:@"V:|-%f-[self]-%f-|",edgeInsets.top,edgeInsets.bottom];
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:formatV
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
}

//设置autoLayout，subview距离superview下左右的边距，设置高度
- (void)constrainSubviewToMatchSuperviewWithEdgeInsets:(UIEdgeInsets)edgeInsets height:(CGFloat)height
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self);
    
    //约束1 横向 Horizontal
    NSString *formatH = [NSString stringWithFormat:@"H:|-%f-[self]-%f-|",edgeInsets.left,edgeInsets.right];
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:formatH
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    //约束2 纵向 Vertical
    NSString *formatV = [NSString stringWithFormat:@"V:|->=0-[self(%f)]-%f-|",height,edgeInsets.bottom];
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:formatV
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
}

//设置autoLayout，subview距离scrollView上左右的边距，设置宽高
- (void)constrainSubviewToMatchScrollViewWithEdgeInsets:(UIEdgeInsets)edgeInsets size:(CGSize)size
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self);
    
    //约束1 横向 Horizontal
    NSString *formatH = [NSString stringWithFormat:@"H:|-%f-[self(%f)]-%f-|",edgeInsets.left,size.width,edgeInsets.right];
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:formatH
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    //约束2 纵向 Vertical
    NSString *formatV = [NSString stringWithFormat:@"V:|-%f-[self(%f)]-%f-|",edgeInsets.top,size.height,edgeInsets.bottom];
    [self.superview addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:formatV
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
}

@end
