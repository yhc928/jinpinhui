//
//  FirstCollectionCell.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/26.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "FirstCollectionCell.h"
#import "CycleScrollView.h"
#import "FirstIndexCell.h"

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
    //    return self.dataArray.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
