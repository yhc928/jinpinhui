//
//  SecondCollectionCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/26.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "SecondCollectionCell.h"
#import "IndexViewController.h"
#import "SecondIndexCell.h"
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
        [self.tableView addLegendHeaderWithRefreshingTarget:[IndexViewController sharedClient]
                                           refreshingAction:@selector(loadNewData)];
        
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

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataArray.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondIndexCell"];
    if (!cell) {
        cell = [[SecondIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondIndexCell"];
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

//- (void)setDataArray:(NSArray *)dataArray
//{
//    [self.tableView reloadData];
//}

@end
