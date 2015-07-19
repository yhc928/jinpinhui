//
//  IndexViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/6.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "MyDrawerViewController.h"

@interface IndexViewController ()

@property (nonatomic, strong) UIScrollView     *bgScrollView; //背景scrollView
@property (nonatomic, strong) TitleCollectionView *titleCollectionView;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"金品汇";
    
    //左侧按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = ITEM_FRAME;
    [leftButton setImage:[UIImage imageNamed:@"navi_left_normal"] forState:UIControlStateNormal];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftButton addTarget:self action:@selector(didOpenLeftSide) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    //右侧按钮
    UIButton *righButton = [UIButton buttonWithType:UIButtonTypeCustom];
    righButton.frame = ITEM_FRAME;
    [righButton setImage:[UIImage imageNamed:@"navi_right_user_normal"] forState:UIControlStateNormal];
    righButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [righButton addTarget:self action:@selector(didOpenRightSide) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:righButton];
    
    //搜索按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = ITEM_FRAME;
    [searchButton setImage:[UIImage imageNamed:@"navi_right_search_normal"] forState:UIControlStateNormal];
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [searchButton addTarget:self action:@selector(didSearch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    //设置右侧按钮数组
    self.navigationItem.rightBarButtonItems = @[rightButtonItem,searchButtonItem];
    
    //视图切换标题
    self.titleCollectionView = [[TitleCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 33)];
    self.titleCollectionView.myDelegate = self;
    [self.view addSubview:self.titleCollectionView];
    
    //数据
    self.titleCollectionView.dataArray = @[@"精选推荐",@"阳光私募",@"信托产品",@"资管计划",@"精选推荐",@"阳光私募",@"信托产品",@"资管计划",@"精选推荐",@"阳光私募",@"信托产品",@"资管计划",@"精选推荐",@"阳光私募",@"信托产品",@"精选推荐",@"阳光私募",@"信托产品"];
    
    [self.titleCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                      animated:YES
                                scrollPosition:UICollectionViewScrollPositionNone];
    
    //背景
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 33, SCREEN_WIDTH, SCREEN_HEIGHT-64-33)];
    self.bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.titleCollectionView.dataArray.count, 0);
    self.bgScrollView.pagingEnabled = YES;
    self.bgScrollView.delegate = self;
//    self.bgScrollView.bounces = NO;
    [self.view addSubview:self.bgScrollView];
    
    CGRect frame = self.bgScrollView.bounds;
    for (int i = 0; i < self.titleCollectionView.dataArray.count; i++) {
        frame.origin.x = i*SCREEN_WIDTH;
        if (i == 0) {
            FirstViewController *firstVC = [[FirstViewController alloc] init];
            [self addChildViewController:firstVC];
            firstVC.view.frame = frame;
            [self.bgScrollView addSubview:firstVC.view];
        } else {
            SecondViewController *secondVC = [[SecondViewController alloc] init];
            [self addChildViewController:secondVC];
            secondVC.view.frame = frame;
            [self.bgScrollView addSubview:secondVC.view];
            
            if (i % 2 == 0) {
                secondVC.view.backgroundColor = [UIColor redColor];
            } else {
                secondVC.view.backgroundColor = [UIColor greenColor];
            }
        }
    }
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    NSLog(@"resultDic = %@",resultDic);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.titleCollectionView bgScrollViewDidScroll:scrollView.contentOffset.x];
    
    //滑动到边界
    if (scrollView.contentOffset.x < 0) {
        [self didOpenLeftSide];
    } else if (scrollView.contentOffset.x > scrollView.contentSize.width-SCREEN_WIDTH) {
        [self didOpenRightSide];
    }
}

//开始滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //当手滑动scrollView的时候设置isScroll为YES
    self.titleCollectionView.isScroll = YES;
}

//完全停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //当手滑动scrollView结束时候设置isScroll为NO
    self.titleCollectionView.isScroll = NO;
}

//点击标题按钮结束动画时会走这个方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    myAppDelegate.drawerController.view.userInteractionEnabled = YES;
}

#pragma mark - TitleCollectionViewDelegate
- (void)titleCollectionView:(TitleCollectionView *)titleCollectionView didSelectedIndex:(NSInteger)index
{
    [self.bgScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:YES];
    myAppDelegate.drawerController.view.userInteractionEnabled = NO;
}

/**
 *  打开左侧边栏
 */
- (void)didOpenLeftSide
{
    [myAppDelegate.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}

/**
 *  打开右侧边栏
 */
- (void)didOpenRightSide
{
    [myAppDelegate.drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
    }];
}

/**
 *  点击搜索
 */
- (void)didSearch
{
    
}

/**
 *  request
 */
- (void)requestBin_cmd
{
    NSDictionary *parameters = @{@"username":@"123",
                                 @"password":@"a234",
                                 @"cmd":@"reg",
                                 @"date":@"2015-06-28 16:36:20",
                                 @"md5":@"deda6cfcf3c03080"};
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:parameters];
    [self jsonWithRequest:request delegate:self code:111 object:nil];
}

- (void)requestUserAction
{
    NSDictionary *parameters = @{@"connector":@"homeRedPort",
                                 @"account":@"13141215988"};
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getUserActionWithParameters:parameters];
    [self jsonWithRequest:request delegate:self code:112 object:nil];
}

@end
