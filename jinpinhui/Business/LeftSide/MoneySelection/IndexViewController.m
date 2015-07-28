//
//  IndexViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/6.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexViewController.h"
#import "MyDrawerViewController.h"
#import "FirstCollectionCell.h"
#import "SecondCollectionCell.h"

@interface IndexViewController ()

@property (nonatomic, strong) TitleCollectionView *titleCollectionView;
@property (nonatomic, strong) UICollectionView    *collectionView;//表格
@property (nonatomic, strong) UITableView         *tableView;

@property (nonatomic, strong) NSArray             *dataArray;

@end

@implementation IndexViewController

//单例
+ (instancetype)sharedClient {
    static IndexViewController *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[IndexViewController alloc] init];
    });
    
    return _sharedClient;
}

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
    
    //layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 33, SCREEN_WIDTH, SCREEN_HEIGHT-64-33)
                                             collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    //注册cell
    [self.collectionView registerClass:[FirstCollectionCell class]
            forCellWithReuseIdentifier:NSStringFromClass([FirstCollectionCell class])];
    [self.collectionView registerClass:[SecondCollectionCell class]
            forCellWithReuseIdentifier:NSStringFromClass([SecondCollectionCell class])];
    
//**************************************************数据***********************************************
    self.titleCollectionView.dataArray = @[@"精选推荐",@"阳光私募",@"信托产品",@"资管计划",@"精选推荐",@"阳光私募",@"信托产品",@"资管计划",@"精选推荐",@"阳光私募",@"信托产品",@"资管计划"];
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    NSLog(@"resultDic = %@",resultDic);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleCollectionView.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FirstCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FirstCollectionCell class])
                                                                              forIndexPath:indexPath];
        cell.dataArray = @[@"1"];
        return cell;
    } else {
        SecondCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SecondCollectionCell class])
                                                                               forIndexPath:indexPath];
        cell.dataArray = @[@"1"];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionView.bounds.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
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
    [self.collectionView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:YES];
    myAppDelegate.drawerController.view.userInteractionEnabled = NO;
}

//下拉刷新回调方法
- (void)loadNewData
{
    NSInteger currentMultiple = self.titleCollectionView.currentMultiple;
    
    FirstCollectionCell *cell = (FirstCollectionCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:currentMultiple inSection:0]];
    self.tableView = cell.tableView;
    
    [self.tableView.legendHeader endRefreshing];
    
    [self.collectionView reloadData];
   
}

//立即进入刷新
- (void)beginRefreshing
{
    NSInteger currentMultiple = self.titleCollectionView.currentMultiple;
    
    FirstCollectionCell *cell = (FirstCollectionCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:currentMultiple inSection:0]];
    self.tableView = cell.tableView;
    
     [self.tableView.legendHeader beginRefreshing];
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
