//
//  IndexDetailsTenView.h
//  jinpinhui
//
//  Created by 陈震 on 15/10/8.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IndexDetailsTenViewDelegate;

@interface IndexDetailsTenView : UIView

@property (nonatomic, weak) id<IndexDetailsTenViewDelegate> delegate;
@property (nonatomic, strong) NSArray *dataArray;

@end

@protocol IndexDetailsTenViewDelegate <NSObject>

- (void)indexDetailsTenView:(IndexDetailsTenView *)indexDetailsTenView didSelectedIndex:(NSInteger)index;

@end
