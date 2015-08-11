//
//  LeftSideViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/12.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "LeftSideViewController.h"
#import "MyDrawerViewController.h"
#import "IndexViewController.h"
#import "HotActivityViewController.h"
#import "GoldStoreViewController.h"
#import "MoreViewController.h"

@interface LeftSideViewController ()

@property (nonatomic, strong) UITableView *tableView;   //城市列表
@property (nonatomic, strong) NSArray     *dataArray;   //数据

@property (nonatomic, strong) HotActivityViewController *hotActivityVC;  //热销活动
@property (nonatomic, strong) UINavigationController    *hotActivityNav;

@property (nonatomic, strong) GoldStoreViewController   *goldStoreVC;  //金币商城
@property (nonatomic, strong) UINavigationController    *goldStoreNav;

@property (nonatomic, strong) UINavigationController    *moreNav; //更多

@end

@implementation LeftSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_side_bg"]];
    [self.view addSubview:bgImageView];
    [bgImageView constrainSubviewToMatchSuperview];
    
    //城市表格
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (IS_IOS_7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 50);
    }
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperviewWithEdgeInsets:UIEdgeInsetsMake(64, 0, 0, 0)]; //设置autoLayout
    
//*************************************************************************************************************
    NSString *leftSidePath = [[NSBundle mainBundle] pathForResource:@"leftSide" ofType:@"plist"];
    self.dataArray = [NSArray arrayWithContentsOfFile:leftSidePath];
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
//    if (code == CITY_LIST_CODE) {
//        if (resultDic) {
//            //            NSLog(@"resultDic = %@",resultDic);
//            NSArray *result = [resultDic objectForKey:@"result"];
//            if ([[resultDic objectForKey:@"resp_code"] integerValue] == 200 && result.count > 0) {
//                self.dataArray = [CityModel objectArrayWithKeyValuesArray:result];
//                
//                //刷新UI
//                [self.tableView reloadData];
//            }
//        }
//    }
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_side_selected"]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = FONT_30PX;
    }
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    NSString *iconNameStr = [dict objectForKey:@"icon"];
    cell.imageView.image = [UIImage imageNamed:iconNameStr];
    cell.textLabel.text = [dict objectForKey:@"title"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [myAppDelegate.drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
    
    switch (indexPath.row) {
        case 0: {
            myAppDelegate.drawerController.centerViewController = self.indexNav;
            [[IndexViewController sharedClient].currentTableView.legendHeader beginRefreshing];
            [IndexViewController sharedClient].currentTableView.legendHeader.refreshingTarget = [IndexViewController sharedClient];
            break;
        }
            
        case 1: {
            if (self.hotActivityNav == nil) {
                self.hotActivityVC = [[HotActivityViewController alloc] init];
                self.hotActivityNav = [[UINavigationController alloc] initWithRootViewController:self.hotActivityVC];
            }
            myAppDelegate.drawerController.centerViewController = self.hotActivityNav;
            [self.hotActivityVC.tableView.legendHeader beginRefreshing];
            break;
        }
            
        case 2: {
            if (self.goldStoreNav == nil) {
                self.goldStoreVC = [[GoldStoreViewController alloc] init];
                self.goldStoreNav = [[UINavigationController alloc] initWithRootViewController:self.goldStoreVC];
            }
            myAppDelegate.drawerController.centerViewController = self.goldStoreNav;
            [self.goldStoreVC.collectionView.legendHeader beginRefreshing];
            break;
        }
            
        case 3: {
            if (self.moreNav == nil) {
                MoreViewController *moreVC = [[MoreViewController alloc] init];
                self.moreNav = [[UINavigationController alloc] initWithRootViewController:moreVC];
            }
            myAppDelegate.drawerController.centerViewController = self.moreNav;
            break;
        }
    }
}

@end
