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

@property (nonatomic, strong) NSMutableArray      *dataArray; //数据
@property (nonatomic, strong) NSArray             *imageArray; //轮播图

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
    //产品网络请求
    [self loadNewData];
    //数据源
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    [self.currentTableView.legendHeader endRefreshing];
    
//    NSLog(@"resultDic = %@",resultDic);
//    NSLog(@"error = %@",[resultDic objectForKey:@"error"]);
    
    NSArray *thots = [resultDic objectForKey:@"Thot"];
    NSArray *ttypes = [resultDic objectForKey:@"Ttype"];
    
    //轮播图数据
    if (thots.count > 0) {
        
        self.imageArray = thots;
    }
    
    //列表数据
    if (ttypes.count > 0) {
        //产品标题
        self.titleCollectionView.dataArray = ttypes;
        [self.titleCollectionView reloadData];
        
        //设置产品标题的选中位置
        self.titleCollectionView.isScroll = YES;
        [self.titleCollectionView bgScrollViewDidScroll:0];
        
        //产品数据
        [self.dataArray removeAllObjects];
        for (NSDictionary *dict in ttypes) {
            NSMutableDictionary *ttype = [NSMutableDictionary dictionaryWithDictionary:dict];
            NSMutableArray *Tsubs = [NSMutableArray arrayWithArray:[ttype objectForKey:@"Tsub"]];
            [ttype setObject:Tsubs forKey:@"Tsub"];
            
            [self.dataArray addObject:ttype];
        }
        
        [self.collectionView reloadData];
        
        //设置collectionView偏移量
        self.collectionView.contentOffset = CGPointMake(0, 0);
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FirstCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FirstCollectionCell class])
                                                                              forIndexPath:indexPath];
        
        //取出每个页面的数据
        NSDictionary *ttype = self.dataArray[indexPath.row];
        
        //取出列表
        NSMutableArray *tsubs = [ttype objectForKey:@"Tsub"];
        cell.tpID = [ttype objectForKey:@"TpID"];
        
        if (![cell.imageArray isEqualToArray:self.imageArray]) {
            cell.imageArray = self.imageArray;
        }
        
        if (![cell.dataArray isEqualToArray:tsubs]) {
             cell.dataArray = tsubs;
            [cell.tableView reloadData];
        }
        
        return cell;
    } else {
        SecondCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SecondCollectionCell class])
                                                                               forIndexPath:indexPath];
        
        //取出每个页面的数据
        NSDictionary *ttype = self.dataArray[indexPath.row];
        
        NSMutableArray *tsubs = [ttype objectForKey:@"Tsub"];
        cell.tpID = [ttype objectForKey:@"TpID"];
        
        if (![cell.dataArray isEqualToArray:tsubs]) {
            cell.dataArray = tsubs;
            [cell.tableView reloadData];
        }
        
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

/**
 *  重写currentTableView的get方法
 */
- (UITableView *)currentTableView
{
    NSInteger currentMultiple = self.titleCollectionView.currentMultiple;
    
    FirstCollectionCell *cell = (FirstCollectionCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:currentMultiple inSection:0]];
    
    return cell.tableView;
}

//下拉刷新回调方法
- (void)loadNewData
{
    //网络请求
    [self requestProduct];
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
 *  获取产品
 */
- (void)requestProduct
{
    [self.Parameters setValue:@"GETA" forKey:@"cmd"];
    [self.Parameters setValue:@"" forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:112 object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置侧滑菜单可点
    myAppDelegate.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //设置侧滑菜单不可点
    myAppDelegate.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
}

@end
