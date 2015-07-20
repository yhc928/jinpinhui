//
//  FirstIndexViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/20.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "FirstIndexViewController.h"
#import "MJRefresh.h"
#import "FirstIndexCell.h"
#import "FirstIndexMoreCell.h"

@interface FirstIndexViewController ()

@property (nonatomic, strong) UITableView     *tableView;       //表格
@property (nonatomic, strong) CycleScrollView *cycleScrollView; //轮播图
@property (nonatomic, strong) NSArray         *dataArray;       //数据

@end

@implementation FirstIndexViewController

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
    
    //轮播图
    self.cycleScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*174/320)];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.imageArray = @[@"1",@"2",@"3"];
    self.tableView.tableHeaderView = self.cycleScrollView;
    
    //添加下拉刷新
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(didRefresh)];
    
    // 马上进入刷新状态
    [self.tableView.legendHeader beginRefreshing];
    
//*************************************************************************************************************
    
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    if (section == 0) {
        return 10;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            FirstIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstIndexCell"];
            if (!cell) {
                cell = [[FirstIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirstIndexCell"];
            }
            
            cell.titleLabel.text = @"中泰信托-金泰3号淮安安置"; //标题
            cell.statusLabel.text = @"在售"; //状态
            cell.statusLabel.backgroundColor = UIColorFromRGB(251, 132, 50);
            
            cell.originLabel.text = @"100万";   //投资起点
            cell.deadlineLabel.text = @"24个月"; //投资期限
            cell.expectedLabel.text = @"10.00%"; //预期收益
            cell.rebateLabel.text = @"认证可见"; //最高返佣
            cell.progressView.frame = CGRectMake(0, 0, (SCREEN_WIDTH-85)*0.6, 6); //进度条
            cell.raiseLabel.text = @"已募集60%"; //已募集
            
            switch (indexPath.row % 8) {
                case 0: {
                    cell.titleLabel.text = @"中泰信托-金泰3号淮安安置"; //标题
                    cell.statusLabel.text = @"在售"; //状态
                    cell.statusLabel.backgroundColor = UIColorFromRGB(251, 132, 50);
                    
                    cell.originLabel.text = @"100万";   //投资起点
                    cell.deadlineLabel.text = @"24个月"; //投资期限
                    cell.expectedLabel.text = @"10.00%"; //预期收益
                    cell.rebateLabel.text = @"认证可见"; //最高返佣
                    cell.progressView.frame = CGRectMake(0, 0, (SCREEN_WIDTH-85)*0.6, 6); //进度条
                    cell.raiseLabel.text = @"已募集60%"; //已募集
                    
                    cell.progressView.frame = CGRectMake(0, 0, 0, 6);
                    [UIView animateWithDuration:0.5 animations:^{
                        cell.progressView.frame = CGRectMake(0, 0, (SCREEN_WIDTH-85)*0.2, 6); //进度条
                    }];
                    
                    cell.raiseLabel.text = @"已募集20%"; //已募集
                    
                    break;
                }
                case 1: {
                    
                    cell.titleLabel.text = @"中泰信托景泰9号毕节市虎"; //标题
                    cell.statusLabel.text = @"新品"; //状态
                    cell.statusLabel.backgroundColor = UIColorFromRGB(81, 208, 113);
                    
                    cell.originLabel.text = @"100万";   //投资起点
                    cell.deadlineLabel.text = @"24个月"; //投资期限
                    cell.expectedLabel.text = @"10.00%"; //预期收益
                    cell.rebateLabel.text = @"认证可见"; //最高返佣
                    
                    cell.progressView.frame = CGRectMake(0, 0, 0, 6);
                    [UIView animateWithDuration:0.5 animations:^{
                        cell.progressView.frame = CGRectMake(0, 0, (SCREEN_WIDTH-85)*0.6, 6); //进度条
                    }];
                    
                    cell.raiseLabel.text = @"已募集60%"; //已募集
                    
                    break;
                }
                case 2: {
                    cell.progressView.frame = CGRectMake(0, 0, 0, 6);
                    [UIView animateWithDuration:0.5 animations:^{
                        cell.progressView.frame = CGRectMake(0, 0, (SCREEN_WIDTH-85)*0.4, 6); //进度条
                    }];
                    
                    cell.raiseLabel.text = @"已募集40%"; //已募集
                    
                    break;
                }
                case 3: {
                    cell.progressView.frame = CGRectMake(0, 0, 0, 6);
                    [UIView animateWithDuration:0.5 animations:^{
                        cell.progressView.frame = CGRectMake(0, 0, (SCREEN_WIDTH-85)*0.8, 6); //进度条
                    }];
                    
                    cell.raiseLabel.text = @"已募集80%"; //已募集
                    
                    break;
                }
                case 4: {
                    cell.progressView.frame = CGRectMake(0, 0, 0, 6);
                    [UIView animateWithDuration:0.5 animations:^{
                        cell.progressView.frame = CGRectMake(0, 0, (SCREEN_WIDTH-85)*1, 6); //进度条
                    }];
                    
                    cell.raiseLabel.text = @"已募集100%"; //已募集
                    
                    break;
                }
            }
            return cell;
            
            break;
        }
            
        default: {
            FirstIndexMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstIndexMoreCell"];
            if (!cell) {
                cell = [[FirstIndexMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirstIndexMoreCell"];
            }
            return cell;
            
            break;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            return 121;
            break;
        }
        default: {
            return 75;
            break;
        }
    }
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

#pragma mark - CycleScrollViewDelegate
- (void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectImageView:(NSInteger)index
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