//
//  IndexDetailsViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/11.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsViewController.h"
#import "IndexDetailsZeroCell.h"
#import "IndexDetailsOneCell.h"
#import "IndexDetailsTwoCell.h"
#import "IndexDetailsThreeCell.h"
#import "IndexDetailsFourCell.h"
#import "IndexDetailsFiveCell.h"
#import "IndexDetailsSixCell.h"
#import "IndexDetailsSevenCell.h"
#import "IndexDetailsEightCell.h"

@interface IndexDetailsViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation IndexDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.iname;
    
    //城市表格
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperview]; //设置autoLayout
    
    [self requestProduct];
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
//    NSLog(@"resultDic = %@",resultDic);
    
    if ([[resultDic objectForKey:@"resp_code"] integerValue] == 200) {
        self.dataArray = [resultDic objectForKey:@"info"];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSDictionary *info = self.dataArray[section];
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    NSDictionary *info = self.dataArray[indexPath.section];
    
    //取出数据类型
    NSInteger type = [[info objectForKey:@"type"] integerValue];
    
    switch (type) {
        case 0: {
            IndexDetailsZeroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexDetailsZeroCell"];
            if (!cell) {
                cell = [[IndexDetailsZeroCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndexDetailsZeroCell"];
            }
            
            return cell;
            
            break;
        }
        case 1: {
            IndexDetailsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexDetailsOneCell"];
            if (!cell) {
                cell = [[IndexDetailsOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndexDetailsOneCell"];
            }
            cell.titleLabel.text = [info objectForKey:@"title"];
            cell.contentLabel.text = [info objectForKey:@"content"];
            [cell.contentLabel sizeToFit];
            
            return cell;
            
            break;
        }
        case 2: {
            IndexDetailsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexDetailsTwoCell"];
            if (!cell) {
                cell = [[IndexDetailsTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndexDetailsTwoCell"];
            }
            cell.subtitleLabel.text = [info objectForKey:@"subtitle"];
            cell.contentLabel.text = [info objectForKey:@"content"];
            [cell.contentLabel sizeToFit];
            
            return cell;
            
            break;
        }
        case 3: {
            IndexDetailsThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexDetailsThreeCell"];
            if (!cell) {
                cell = [[IndexDetailsThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndexDetailsThreeCell"];
            }
            cell.contentLabel.text = [info objectForKey:@"content"];
            [cell.contentLabel sizeToFit];
            
            return cell;
            
            break;
        }
        case 4: {
            IndexDetailsFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexDetailsFourCell"];
            if (!cell) {
                cell = [[IndexDetailsFourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndexDetailsFourCell"];
            }
            
            return cell;
            
            break;
        }
        case 5: {
            IndexDetailsFiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexDetailsFiveCell"];
            if (!cell) {
                cell = [[IndexDetailsFiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndexDetailsFiveCell"];
            }
            
            return cell;
            
            break;
        }
        case 6: {
            IndexDetailsSixCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexDetailsSixCell"];
            if (!cell) {
                cell = [[IndexDetailsSixCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndexDetailsSixCell"];
            }
            
            return cell;
            
            break;
        }
        case 7: {
            IndexDetailsSevenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexDetailsSevenCell"];
            if (!cell) {
                cell = [[IndexDetailsSevenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndexDetailsSevenCell"];
            }
            
            return cell;
            
            break;
        }
        case 8: {
            IndexDetailsEightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexDetailsEightCell"];
            if (!cell) {
                cell = [[IndexDetailsEightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndexDetailsEightCell"];
            }
            
            return cell;
            
            break;
        }
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            }
            return cell;
            
            break;
        }
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = self.dataArray[indexPath.section];
    
    NSInteger type = [[info objectForKey:@"type"] integerValue];
    
    switch (type) {
//        case 0: {
//
//
//            break;
//        }
        case 1: {
            NSString *content = [info objectForKey:@"content"];
            CGFloat height = [self heightWithText:content font:FONT_30PX width:SCREEN_WIDTH-90];
            return height+22;
            break;
        }
        case 2: {
            NSString *content = [info objectForKey:@"content"];
            CGFloat height = [self heightWithText:content font:FONT_30PX width:SCREEN_WIDTH-120];
            return height+22;
            
            break;
        }
            
        case 3: {
            NSString *content = [info objectForKey:@"content"];
            CGFloat height = [self heightWithText:content font:FONT_30PX width:SCREEN_WIDTH-20];
            return height+22;

            break;
        }
//        case 4: {
//
//            break;
//        }
//        case 5: {
//
//            break;
//        }
//        case 6: {
//
//            break;
//        }
//        case 7: {
//
//            break;
//        }
//        case 8: {
//
//            break;
//        }
//        case 9: {
//
//            break;
//        }
            
        default: {
            
            return 0;
            
            break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *info = self.dataArray[section];
    NSInteger type = [[info objectForKey:@"type"] integerValue];
    
    if (type == 1) {
        return 0;
    } else {
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *info = self.dataArray[section];
    NSInteger type = [[info objectForKey:@"type"] integerValue];
    
    if (type == 1) {
        return nil;
    } else {
        NSString *title = [info objectForKey:@"title"];
        
        //标题背景
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = UIColorFromRGB(235, 235, 235);
        
        //标题
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 44)];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.text = title;
        headerLabel.font = FONT_30PX;
        [headerView addSubview:headerLabel];
        
        return headerView;
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
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//根据文字取出高度
- (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width
{
    if (IS_IOS_7) {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:[NSDictionary dictionaryWithObject:font
                                                                             forKey:NSFontAttributeName]
                                         context:nil];
        return rect.size.height;
    } else {
        CGSize size = [text sizeWithFont:font
                       constrainedToSize:CGSizeMake(width, MAXFLOAT)
                           lineBreakMode:NSLineBreakByWordWrapping];
        return size.height;
    }
}

/**
 *  获取产品
 */
- (void)requestProduct
{
    [self.Parameters setValue:@"GETAL" forKey:@"cmd"];
    [self.Parameters setValue:self.iD forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:112 object:nil];
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
