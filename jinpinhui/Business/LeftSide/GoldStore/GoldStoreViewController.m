//
//  GoldStoreViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/20.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "GoldStoreViewController.h"
#import "MyDrawerViewController.h"
#import "GoldStoreCell.h"
#import "UIImageView+WebCache.h"
#import "GoldDetailsViewController.h"

#define image_width  ((SCREEN_WIDTH-30-5*4)/2)
#define image_height image_width

@interface GoldStoreViewController ()

@property (nonatomic, strong) NSArray *dataArray; //数据源

@end

@implementation GoldStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"金币商城";
    
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:righButton];
    
    //collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView constrainSubviewToMatchSuperview]; //设置autoLayout
    
    //注册cell
    [self.collectionView registerClass:[GoldStoreCell class] forCellWithReuseIdentifier:NSStringFromClass([GoldStoreCell class])];
    
    //添加下拉刷新
    [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionView.legendHeader beginRefreshing];
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    [self.collectionView.legendHeader endRefreshing];
    
    NSLog(@"resultDic = %@",resultDic);
    
    NSArray *tsubs = [resultDic objectForKey:@"Tsub"];
    if (tsubs.count > 0) {
        self.dataArray = tsubs;
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoldStoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoldStoreCell class])
                                                                    forIndexPath:indexPath];
    
    NSDictionary *tsub = self.dataArray[indexPath.row];
    
    //设置数据
    NSString *gimg = [tsub objectForKey:@"Gimg"];
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:gimg] placeholderImage:nil];
//    cell.dateLabel.text = 
    cell.dateLabel.text = @"还剩4天";
    cell.titleLabel.text = [tsub objectForKey:@"Gname"];
    cell.priceLabel.text = [tsub objectForKey:@"gmoney"];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(image_width+10, 5+image_height+50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark --UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tsub = self.dataArray[indexPath.row];
    
    GoldDetailsViewController *goldDetailsVC = [[GoldDetailsViewController alloc] init];
    [self.navigationController pushViewController:goldDetailsVC animated:YES];
}

/**
 *  下拉刷新
 */
- (void)loadNewData
{
    [self requestGoldStore];
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
 *  金币商城网络请求
 */
- (void)requestGoldStore
{
    [self.Parameters setValue:@"GETC" forKey:@"cmd"];
    [self.Parameters setValue:@"" forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:111 object:nil];
}

@end
