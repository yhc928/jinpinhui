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
    
    if (indexPath.row == _currentMultiple) {
        cell.titleLabel.textColor = UIColorFromRGB(252, 102, 34);
    } else {
        cell.titleLabel.textColor = [UIColor blackColor];
    }
    
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
    //设置当前页为点击页
    _currentMultiple = indexPath.row;
    
    if (_currentMultiple != _lastMultiple) {
        //代理
        if ([_myDelegate respondsToSelector:@selector(titleCollectionView:didSelectedIndex:)]) {
            [_myDelegate titleCollectionView:self didSelectedIndex:indexPath.row];
        }
    }
}

- (void)bgScrollViewDidScroll:(CGFloat)content_x
{
    //设置底部选中条的frame
    CGRect frame = _selectedView.frame;
    frame.origin.x = margin + content_x*total_width/SCREEN_WIDTH;
    _selectedView.frame = frame;
    
    /**
     *  取出当前页面的页数
     *  如果是点击则不获取当前页，在点击的回调方法里设置
     *  原因是点击之后，在这个方法里当前页会获取多次
     */
    if (self.isScroll == YES) {
        _currentMultiple = (content_x+(SCREEN_WIDTH/2))/SCREEN_WIDTH;
    }
    
    //如果当前页和上一页不相同，则设置CollectionView的偏移量和选中当前页
    if (_lastMultiple != _currentMultiple) {
        //取出CollectionView的偏移量
        CGFloat content_x = margin + total_width*(_currentMultiple-2);
        
        //开头和末尾需要处理
        if (content_x < 0) {
            content_x = 0;
        } else if (content_x > self.contentSize.width-SCREEN_WIDTH) {
            content_x = self.contentSize.width-SCREEN_WIDTH;
        }
        
        //设置偏移量
        [self setContentOffset:CGPointMake(content_x, 0) animated:YES];
        
        //取出上次选中cell
        TitleCollectionCell *lastCell = (TitleCollectionCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_lastMultiple inSection:0]];
        lastCell.titleLabel.textColor = [UIColor blackColor];
        
        //取出当前选中cell
        TitleCollectionCell *currentCell = (TitleCollectionCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentMultiple inSection:0]];
        currentCell.titleLabel.textColor = UIColorFromRGB(252, 102, 34);
        
        //设置上一页等于当前页
        _lastMultiple = _currentMultiple;
    }
}

@end
