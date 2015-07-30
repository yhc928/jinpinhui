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
        [self.tableView addLegendHeaderWithRefreshingTarget:[IndexViewController sharedClient]
                                           refreshingAction:@selector(loadNewData)];
        
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
    }
    return self;
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
    
    cell.titleLabel.text = [tsub objectForKey:@"Iname"]; //标题
    cell.statusLabel.text = [tsub objectForKey:@"Istate"]; //状态
    cell.statusLabel.backgroundColor = UIColorFromRGB(251, 132, 50);
    
    cell.originLabel.text = [tsub objectForKey:@"Iup"];   //投资起点
    cell.deadlineLabel.text = [tsub objectForKey:@"Imon"]; //投资期限
    cell.expectedLabel.text = [tsub objectForKey:@"Iear"]; //预期收益
    cell.rebateLabel.text = [tsub objectForKey:@"Tmax"]; //最高返佣

    
    
    
    cell.raiseLabel.text = [tsub objectForKey:@"Ipro"]; //已募集
    
    
    cell.progressView.frame = CGRectMake(0, 0, 0, 6);
    [UIView animateWithDuration:0.5 animations:^{
        cell.progressView.frame = CGRectMake(0, 0, (SCREEN_WIDTH-85)*0.2, 6); //进度条
    }];
    
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

//- (void)setDataArray:(NSArray *)dataArray
//{
//    [self.tableView reloadData];
//}

@end
