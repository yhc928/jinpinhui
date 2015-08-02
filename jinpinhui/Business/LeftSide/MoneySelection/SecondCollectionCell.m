//
//  SecondCollectionCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/26.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "SecondCollectionCell.h"
#import "IndexViewController.h"
#import "FirstIndexCell.h"
#import "SecondIndexCell.h"
#import "ThirdIndexCell.h"
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
    
    NSLog(@"%@",resultDic);
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.ttp isEqualToString:@"0"]) {
        FirstIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstIndexCell"];
        if (!cell) {
            cell = [[FirstIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirstIndexCell"];
        }
        
        NSDictionary *tsub = self.dataArray[indexPath.row];
        
        //项目名称
        cell.titleLabel.text = [tsub objectForKey:@"Iname"];
        
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
        
        //状态
        [self statusLabelColorWithIstate:[tsub objectForKey:@"Istate"] statusLabel:cell.statusLabel];
        
        return cell;
        
    } else if ([self.ttp isEqualToString:@"1"]) {
        SecondIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondIndexCell"];
        if (!cell) {
            cell = [[SecondIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondIndexCell"];
        }
        
        NSDictionary *tsub = self.dataArray[indexPath.row];
        
        //项目名称
        cell.titleLabel.text = [tsub objectForKey:@"Iname"];
        
        //投资起点
        cell.originLabel.text = [tsub objectForKey:@"Iup"];
        
        //累计净值
        cell.deadlineLabel.text = [tsub objectForKey:@"ICn"];
        
        //累计收益
        NSString *iCg = [tsub objectForKey:@"ICg"];
        cell.expectedLabel.text = [NSString stringWithFormat:@"%.2f%%",[iCg floatValue]];
        
        //最高返佣
        cell.rebateLabel.text = [tsub objectForKey:@"Tmax"];
        
        //状态
        [self statusLabelColorWithIstate:[tsub objectForKey:@"Istate"] statusLabel:cell.statusLabel];
        
        return cell;
        
    } else {
        ThirdIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdIndexCell"];
        if (!cell) {
            cell = [[ThirdIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdIndexCell"];
        }
        NSDictionary *tsub = self.dataArray[indexPath.row];
        
        //项目名称
        cell.titleLabel.text = [tsub objectForKey:@"Iname"];
        
        //投资起点
        cell.originLabel.text = [tsub objectForKey:@"Iup"];
        
        //投资期限
        cell.deadlineLabel.text = [tsub objectForKey:@"Imon"];
        
        //募集状态
        cell.expectedLabel.text = [tsub objectForKey:@"IST"];
        
        //最高返佣
        cell.rebateLabel.text = [tsub objectForKey:@"Tmax"];
        
        //状态
        [self statusLabelColorWithIstate:[tsub objectForKey:@"Istate"] statusLabel:cell.statusLabel];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.ttp isEqualToString:@"0"]) {
        return 121;
    } else {
        return 96;
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

- (void)statusLabelColorWithIstate:(NSString *)istate statusLabel:(UILabel *)statusLabel
{
    if ([istate isEqualToString:@"0"]) {
        statusLabel.text = @"在售";
        statusLabel.backgroundColor = UIColorFromRGB(253, 131, 50);
    } else if ([istate isEqualToString:@"1"]) {
        statusLabel.text = @"新品";
        statusLabel.backgroundColor = UIColorFromRGB(82, 208, 112);
    } else if ([istate isEqualToString:@"2"]) {
        statusLabel.text = @"售馨";
        statusLabel.backgroundColor = UIColorFromRGB(82, 208, 112);
    } else if ([istate isEqualToString:@"3"]) {
        statusLabel.text = @"爆款";
        statusLabel.backgroundColor = UIColorFromRGB(82, 208, 112);
    }
}

//下拉刷新回调方法
- (void)loadNewData
{
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
    [indexVC.Parameters setValue:@"" forKey:@"para"];
    [indexVC.Parameters setValue:[indexVC getCurrentTime] forKey:@"date"];
    [indexVC.Parameters setValue:[indexVC encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:indexVC.Parameters];
    [indexVC jsonWithRequest:request delegate:self code:11 object:nil];
}

@end
