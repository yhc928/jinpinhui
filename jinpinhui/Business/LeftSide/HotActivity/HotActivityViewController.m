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
#import "UIImageView+WebCache.h"

@interface HotActivityViewController ()

@property (nonatomic, strong) NSArray *dataArray; //数据

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
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperview]; //设置autoLayout
    
    //添加下拉刷新
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //马上进入刷新状态
    [self.tableView.legendHeader beginRefreshing];
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    [self.tableView.legendHeader endRefreshing];
    
    NSLog(@"resultDic = %@",resultDic);
    NSLog(@"error = %@",[resultDic objectForKey:@"error"]);
    
    NSArray *tsubs = [resultDic objectForKey:@"Tsub"];
    if (tsubs.count > 0) {
        self.dataArray = tsubs;
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[HotActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSDictionary *tsub = self.dataArray[indexPath.row];
    
    //图片
    NSString *simg = [tsub objectForKey:@"simg"];
    [cell.hotImageView sd_setImageWithURL:[NSURL URLWithString:simg] placeholderImage:nil];
    
    //标题
    cell.titleLabel.text = [tsub objectForKey:@"title"];
    
    //结束时间
    NSString *ddate = [tsub objectForKey:@"ddate"];
    cell.dateLabel.text = [NSString stringWithFormat:@"结束时间%@",ddate];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30+(SCREEN_WIDTH-30)*4/8+50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/**
 *  下拉刷新
 */
- (void)loadNewData
{
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
 *  获取产品
 */
- (void)requestProduct
{
    [self.Parameters setValue:@"GETB" forKey:@"cmd"];
    [self.Parameters setValue:@"" forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:112 object:nil];
}

@end
