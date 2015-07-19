//
//  CycleScrollView.m
//  UISrollView-循环滚动
//
//  Created by 陈震 on 14-6-29.
//  Copyright (c) 2014年 chenzhen. All rights reserved.
//

#import "CycleScrollView.h"
#import "UIImageView+WebCache.h"

#define c_width  (SCREEN_WIDTH+10)
#define c_height (SCREEN_WIDTH*3/8)

@implementation CycleScrollView
{
    UIPageControl  *_pageControl;   //分页控件
    NSMutableArray *_curImageArray; //当前显示的图片数组
    NSInteger      _curPage;        //当前显示的图片位置
    NSTimer        *_timer;         //定时器
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //滚动视图
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, c_width, c_height)];
        self.scrollView.contentSize = CGSizeMake(c_width*3, 0);
        self.scrollView.contentOffset = CGPointMake(c_width, 0);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        //分页控件
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_pageControl];
        
        //设置autoLayout
        NSDictionary *viewsDictionary = @{@"pageControl":_pageControl};
        
        //约束1 水平居中
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:_pageControl
                                      attribute:NSLayoutAttributeCenterX
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeCenterX
                                     multiplier:1
                                       constant:0]];
        
        //约束2 纵向 Vertical
        [self addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl(20)]|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
        //初始化数据相关
        _curImageArray = [[NSMutableArray alloc] initWithCapacity:0];
        _curPage = 0;
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //如果scrollView当前偏移位置x大于等于两倍scrollView宽度
    if (scrollView.contentOffset.x >= c_width*2) {
        _curPage++;
        
        //如果页数超过数组边界，则设置为0
        if (_curPage == [self.imageArray count]) {
            _curPage = 0;
        }
        
        //刷新图片
        [self reloadData];
        
        //设置scrollView偏移位置
        [scrollView setContentOffset:CGPointMake(c_width, 0)];
    }
    
    //如果scrollView当前偏移位置x小于等于0
    else if (scrollView.contentOffset.x <= 0) {
        _curPage--;
        
        //如果页数小于数组边界，则设置为数组最后一张图片下标
        if (_curPage == -1) {
            _curPage = [self.imageArray count]-1;
        }
        
        //刷新图片
        [self reloadData];
        
        //设置scrollView偏移位置
        [scrollView setContentOffset:CGPointMake(c_width, 0)];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //设置scrollView偏移位置
    [scrollView setContentOffset:CGPointMake(c_width, 0) animated:YES];
}

/**
 *  重写数据源的set方法
 *
 *  @param imageArray 数据源
 */
- (void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = imageArray;
    
    //设置分页控件的总页数
    _pageControl.numberOfPages = imageArray.count;
    
    //刷新图片
    [self reloadData];
    
    //开启定时器
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    //判断图片长度是否大于1
    if ([imageArray count] > 1) {
        _timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerScrollImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:UITrackingRunLoopMode beforeDate:[NSDate date]];
    }
}

/**
 * 刷新图片
 */
- (void)reloadData
{
    //设置页数
    _pageControl.currentPage = _curPage;
    
    //根据当前页取出图片
    [self getDisplayImagesWithCurpage:_curPage];
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [self.scrollView subviews];
    
    if([subViews count] > 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    //创建imageView
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(c_width*i, 0, self.bounds.size.width, c_height)];
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        //设置图片
//        ImageModel *model = _curImageArray[i];
//        NSURL *url = [NSURL URLWithString:model.image_url];
//        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder_320x120.png"]];
        imageView.backgroundColor = [UIColor brownColor];
        
        //tap手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [imageView addGestureRecognizer:tap];
    }
}

/**
 *  获取展示的图片
 *
 *  @param page 页数
 */
- (void)getDisplayImagesWithCurpage:(NSInteger)page
{
    //取出开头和末尾图片在图片数组里的下标
    NSInteger front = page - 1;
    NSInteger last = page + 1;
    
    //如果当前图片下标是0，则开头图片设置为图片数组的最后一个元素
    if (page == 0) {
        front = [self.imageArray count]-1;
    }
    
    //如果当前图片下标是图片数组最后一个元素，则设置末尾图片为图片数组的第一个元素
    if (page == [self.imageArray count]-1) {
        last = 0;
    }
    
    //如果当前图片数组不为空，则移除所有元素
    if ([_curImageArray count] > 0) {
        [_curImageArray removeAllObjects];
    }
    
    //当前图片数组添加图片
    [_curImageArray addObject:self.imageArray[front]];
    [_curImageArray addObject:self.imageArray[page]];
    [_curImageArray addObject:self.imageArray[last]];
}

/**
 * 定时器的方法
 */
- (void)timerScrollImage
{
    //刷新图片
    [self reloadData];
    
    //设置scrollView偏移位置
    [self.scrollView setContentOffset:CGPointMake(c_width*2, 0) animated:YES];
}

/**
 *  tap图片的方法
 *
 *  @param tap tap手势
 */
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    //设置代理
    if ([_delegate respondsToSelector:@selector(cycleScrollView:didSelectImageView:)]) {
        [_delegate cycleScrollView:self didSelectImageView:_curPage];
    }
}

- (void)dealloc
{
    self.scrollView.delegate = nil;
    [_timer invalidate];
}

@end
