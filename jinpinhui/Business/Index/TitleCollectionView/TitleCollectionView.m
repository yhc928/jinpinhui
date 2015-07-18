//
//  TitleCollectionView.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/17.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "TitleCollectionView.h"
#import "TitleCollectionCell.h"

#define total_width 95 //间隔+item的宽度
#define margin      20 //边距

#define item_width  60
#define item_height 33

@implementation TitleCollectionView

//重写init方法
- (instancetype)initWithFrame:(CGRect)frame
{
    //重写layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        //设置CollectionView的属性
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        
        //分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame)-0.5, CGRectGetWidth(frame), 0.5)];
        lineView.backgroundColor = LAYER_COLOR;
        [self.backgroundView addSubview:lineView];
        
        //选中的背景色
        _selectedView = [[UIView alloc] initWithFrame:CGRectMake(margin, item_height-2, item_width, 2)];
        _selectedView.backgroundColor = UIColorFromRGB(252, 102, 34);
        [self addSubview:_selectedView];
        
        //注册cell
        [self registerClass:[TitleCollectionCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    //设置数据
    cell.titleLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(item_width, item_height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return total_width-item_width;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, margin, 0, margin);
}

#pragma mark --UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat content_x = item_width+(indexPath.row-2)*total_width;
    
    if (content_x < 0) {
        content_x = 0;
    } else if (content_x > collectionView.contentSize.width-SCREEN_WIDTH-total_width) {
        content_x = collectionView.contentSize.width-SCREEN_WIDTH;
    }
    
    [self setContentOffset:CGPointMake(content_x, 0) animated:YES];
    
    //设置选中条
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = _selectedView.frame;
        frame.origin.x = margin+indexPath.row*total_width;
        _selectedView.frame = frame;
    }];
}

@end
