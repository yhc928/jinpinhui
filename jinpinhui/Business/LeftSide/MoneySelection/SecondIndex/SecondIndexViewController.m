//
//  SecondIndexViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/20.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "SecondIndexViewController.h"
#import "SecondIndexCell.h"

@interface SecondIndexViewController ()

@property (nonatomic, strong) UITableView     *tableView;       //表格
@property (nonatomic, strong) NSArray         *dataArray;       //数据

@end

@implementation SecondIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //表格
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperview]; //设置autoLayout
    
//*************************************************************************************************************
    
    //添加下拉刷新
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(didRefresh)];
    
    // 马上进入刷新状态
//    [self.tableView.legendHeader beginRefreshing];
    
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
    //    return self.dataArray.count;
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[SecondIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    
    cell.titleLabel.text = @"中泰信托-金泰3号淮安安置"; //标题
    cell.statusLabel.text = @"在售"; //状态
    cell.statusLabel.backgroundColor = UIColorFromRGB(251, 132, 50);
    
    cell.originLabel.text = @"100万";   //投资起点
    cell.deadlineLabel.text = @"24个月"; //投资期限
    cell.expectedLabel.text = @"10.00%"; //预期收益
    cell.rebateLabel.text = @"认证可见"; //最高返佣
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}

//解决iOS8中tableView分割线设置[cell setSeparatorInset:UIEdgeInsetsZero]无效问题
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didRefresh
{
    [self.tableView.legendHeader endRefreshing];
}

//解决iOS8中tableView分割线设置[cell setSeparatorInset:UIEdgeInsetsZero]无效问题
- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
