//
//  HotActivityViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/20.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "HotActivityViewController.h"
#import "MyDrawerViewController.h"
#import "HotActivityCell.h"

@interface HotActivityViewController ()

@property (nonatomic, strong) NSArray     *dataArray; //数据

@end

@implementation HotActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"热门活动";
    
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
    
    //表格
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperview]; //设置autoLayout
    //添加下拉刷新
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //马上进入刷新状态
    [self.tableView.legendHeader beginRefreshing];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[HotActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.titleLabel.text = @"礼包天天送活动"; //标题
    cell.dateLabel.text = @"结束时间9月23日"; //结束时间
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30+(SCREEN_WIDTH-30)*3/8+50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/**
 *  下拉刷新
 */
- (void)loadNewData
{
    [self.tableView.legendHeader endRefreshing];
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

@end
