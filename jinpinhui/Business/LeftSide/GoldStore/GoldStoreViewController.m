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
#import "LoginUser.h"

@interface GoldStoreViewController ()

@property (nonatomic, strong) UILabel *goldLabel; //我的金币
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
    
    //标题背景
    UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 28)];
    titleBgView.backgroundColor = UIColorFromRGB(193, 214, 226);
    [self.view addSubview:titleBgView];
    
    //我的金币固定文字
    UILabel *myGoldLabel = [[UILabel alloc] init];
    myGoldLabel.text = @"我的金币";
    myGoldLabel.font = FONT_28PX;
    myGoldLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [titleBgView addSubview:myGoldLabel];
    
    //我的金币
    self.goldLabel = [[UILabel alloc] init];
    self.goldLabel.text = [[LoginUser sharedLoginUser] ugold];
    self.goldLabel.textColor = UIColorFromRGB(252, 101, 77);
    self.goldLabel.font = FONT_30PX;
    self.goldLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [titleBgView addSubview:self.goldLabel];
    
    //金币图标
    UIImageView *goldImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gold_store_coins"]];
    goldImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [titleBgView addSubview:goldImageView];
    
    //设置autoLayout
    NSDictionary *viewsDictionary = @{@"myGoldLabel":myGoldLabel,
                                      @"goldLabel":self.goldLabel,
                                      @"goldImageView":goldImageView};
    
    //约束1 横向 Horizontal
    [titleBgView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[myGoldLabel]-10-[goldLabel]-10-[goldImageView(18)]"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    
    //约束2 纵向 Vertical
    [titleBgView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[myGoldLabel]-5-|"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    
    [titleBgView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[goldLabel]-5-|"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    
    [titleBgView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[goldImageView(19)]-5-|"
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    
    //collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView constrainSubviewToMatchSuperviewWithEdgeInsets:UIEdgeInsetsMake(28, 0, 0, 0)]; //设置autoLayout
    
    //注册cell
    [self.collectionView registerClass:[GoldStoreCell class] forCellWithReuseIdentifier:NSStringFromClass([GoldStoreCell class])];
    
    //添加下拉刷新
    [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionView.legendHeader beginRefreshing];
    
    //可兑换商品
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-89-10, 13, 89, 20)];
    [titleButton setBackgroundImage:[UIImage imageNamed:@"gold_button_bg"] forState:UIControlStateNormal];
    [titleButton setTitle:@"可兑换商品" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = FONT_28PX;
    [self.view addSubview:titleButton];
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    [self.collectionView.legendHeader endRefreshing];
    
//    NSLog(@"resultDic = %@",resultDic);
    
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
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:gimg] placeholderImage:[UIImage imageNamed:@"gold_placeholder"]];
    
    //剩余时间
    NSString *fday = [tsub objectForKey:@"fday"];
    cell.dateLabel.text = [NSString stringWithFormat:@"还剩%@天",fday];
    
    //标题
    cell.titleLabel.text = [tsub objectForKey:@"Gname"];
    
    //价格
    cell.priceLabel.text = [tsub objectForKey:@"gmoney"];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(GOLD_IMAGE_WIDTH+10, 5+GOLD_IMAGE_HEIGHT+50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 10, 10, 10);
}

#pragma mark --UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tsub = self.dataArray[indexPath.row];
    
    GoldDetailsViewController *goldDetailsVC = [[GoldDetailsViewController alloc] init];
    goldDetailsVC.goodsId = [tsub objectForKey:@"ID"];
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
