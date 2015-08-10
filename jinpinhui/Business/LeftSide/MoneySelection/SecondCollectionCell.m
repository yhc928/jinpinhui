//
//  SecondCollectionCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/26.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "SecondCollectionCell.h"
#import "IndexViewController.h"
#import "IndexTableViewCell.h"
#import "MJRefresh.h"

@implementation SecondCollectionCell

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
    }
    return self;
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    [self.tableView.legendHeader endRefreshing];
    [self.tableView.legendFooter endRefreshing];
    
//    NSLog(@"resultDic = %@",resultDic);
//    NSLog(@"error = %@",[resultDic objectForKey:@"error"]);
    
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
    IndexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[IndexTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSDictionary *tsub = self.dataArray[indexPath.row];
    
    //项目名称
    cell.titleLabel.text = [tsub objectForKey:@"Iname"];
    
    //状态
    cell.istate = [tsub objectForKey:@"Istate"];
    
    NSArray *subinfos = [tsub objectForKey:@"subinfo"];
    
    for (int i = 0; i < 4 & i < subinfos.count; i++) {
        NSDictionary *subinfo = subinfos[i];
        switch (i) {
            case 0: {
                //投资起点
                cell.originLabel.text = [subinfo objectForKey:@"content"];
                cell.originTitleLabel.text = [subinfo objectForKey:@"title"];
                break;
            }
            case 1: {
                //投资期限
                cell.deadlineLabel.text = [subinfo objectForKey:@"content"];
                cell.deadlineTitleLabel.text = [subinfo objectForKey:@"title"];
                break;
            }
            case 2: {
                //预期收益
                cell.expectedLabel.text = [subinfo objectForKey:@"content"];
                cell.expectedTitleLabel.text = [subinfo objectForKey:@"title"];
                
                break;
            }
            case 3: {
                //最高返佣
                cell.rebateLabel.text = [subinfo objectForKey:@"content"];
                cell.rebateTitleLabel.text = [subinfo objectForKey:@"title"];
                break;
            }
                
            default:
                break;
        }
    }
    
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
