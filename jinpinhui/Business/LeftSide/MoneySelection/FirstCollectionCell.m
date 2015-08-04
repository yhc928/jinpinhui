//
//  FirstCollectionCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/26.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "FirstCollectionCell.h"
#import "IndexViewController.h"
#import "FirstIndexCell.h"
#import "MJRefresh.h"

@implementation FirstCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //表格
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc] init];
        [self.contentView addSubview:self.tableView];
        
        //添加下拉刷新
        [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        //解决iOS8中tableView分割线设置[cell setSeparatorInset:UIEdgeInsetsZero]无效问题
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
        //轮播图
        self.cycleScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*174/320)];
        self.cycleScrollView.imageArray = @[@"1",@"2",@"3"];
        self.tableView.tableHeaderView = self.cycleScrollView;
        
        //创建数组
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    [self.tableView.legendHeader endRefreshing];
    [self.tableView.legendFooter endRefreshing];
    
    NSLog(@"resultDic = %@",resultDic);
    NSLog(@"error = %@",[resultDic objectForKey:@"error"]);
    
    NSArray *tsubs = [resultDic objectForKey:@"Tsub"];
    
    if (tsubs.count > 0) {
        //下拉刷新清空数组
        if (_nextPage == 1) {
            [self.dataArray removeAllObjects];
        }
        
        //下一页+1
        _nextPage++;
        
        //产品数据
        [self.dataArray addObjectsFromArray:tsubs];
        
        //刷新UI
        [self.tableView reloadData];
    } else {
        //提示没有更多的数据
        [self.tableView.legendFooter noticeNoMoreData];
    }
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstIndexCell"];
    if (!cell) {
        cell = [[FirstIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirstIndexCell"];
    }
    
    NSDictionary *tsub = self.dataArray[indexPath.row];
    
    //项目名称
    cell.titleLabel.text = [tsub objectForKey:@"Iname"];
    
    //状态
    cell.statusLabel.text = [tsub objectForKey:@"Istate"];
    
    //投资起点
    cell.originLabel.text = [tsub objectForKey:@"Iup"];
    
    //投资期限
    cell.deadlineLabel.text = [tsub objectForKey:@"Imon"];
    
    //预期收益
    NSString *iear = [tsub objectForKey:@"Iear"];
    cell.expectedLabel.text = [NSString stringWithFormat:@"%.2f%%",[iear floatValue]];
    
    //最高返佣
    cell.rebateLabel.text = [tsub objectForKey:@"Tmax"];
    
    //已募集
    NSString *ipro = [tsub objectForKey:@"Ipro"];
    cell.raiseLabel.text = [NSString stringWithFormat:@"已募集%@%%",ipro];
    
    //进度条
    cell.progressView.frame = CGRectMake(0, 0, 0, 6);
    [UIView animateWithDuration:0.5 animations:^{
        cell.progressView.frame = CGRectMake(0, 0, (SCREEN_WIDTH-85)*[ipro floatValue]*0.01, 6);
    }];
    
    //状态背景颜色
    cell.statusLabel.backgroundColor = UIColorFromRGB(251, 132, 50);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 121;
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

//下拉刷新回调方法
- (void)loadNewData
{
    _nextPage = 1; //当前页为1
    //网络请求
    [self requestProduct];
}

- (void)loadMoreData
{
    //网络请求
    [self requestProduct];
}

/**
 *  获取产品
 */
- (void)requestProduct
{
    IndexViewController *indexVC = [IndexViewController sharedClient];
    
    [indexVC.Parameters setValue:@"GETA" forKey:@"cmd"];
    [indexVC.Parameters setValue:[NSString stringWithFormat:@"%@|%ld",self.tpID,(long)_nextPage] forKey:@"para"];
    [indexVC.Parameters setValue:[indexVC getCurrentTime] forKey:@"date"];
    [indexVC.Parameters setValue:[indexVC encryption] forKey:@"md5"];
    
//    NSLog(@"Parameters = %@",indexVC.Parameters);
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:indexVC.Parameters];
    [indexVC jsonWithRequest:request delegate:self code:11 object:nil];
}

@end
