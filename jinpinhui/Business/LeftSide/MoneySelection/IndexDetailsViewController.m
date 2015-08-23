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

@property (nonatomic, assign) NSInteger expandIndex; //展开的位置

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
    
    [self requestProductDetails];
    [self showProgressHUD];
    self.expandIndex = -1;
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    [self hideProgressHUD];
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
    NSDictionary *info = self.dataArray[section];
    NSInteger type = [[info objectForKey:@"type"] integerValue];
    
    //表格
    if (type == 4) {
        NSArray *content1s = [info objectForKey:@"content1"];
        return content1s.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    NSDictionary *info = self.dataArray[indexPath.section];
    //取出数据类型
    NSInteger type = [[info objectForKey:@"type"] integerValue];
    
    if (type == 1) {
        IndexDetailsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
        if (!cell) {
            cell = [[IndexDetailsOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];
        }
        
        cell.titleLabel.text = [info objectForKey:@"title"];
        
        NSString *content = [info objectForKey:@"content"];
        cell.contentLabel.text = content;
        
        //设置frame
        CGRect frame = cell.contentLabel.frame;
        frame.size.height = [self heightWithText:content font:FONT_28PX width:SCREEN_WIDTH-95]+22;
        cell.contentLabel.frame = frame;
        
        return cell;
        
    } else if (type == 2) {
        IndexDetailsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2"];
        if (!cell) {
            cell = [[IndexDetailsTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
            UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapExpand:)];
            [cell.titleLabel addGestureRecognizer:titleTap];
        }
        
        cell.titleLabel.text = [info objectForKey:@"subtitle"];
        cell.titleLabel.tag = indexPath.section;
        
        NSString *content = [info objectForKey:@"content"];
        content = [content stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
        cell.contentLabel.text = content;
        
        //设置frame
        CGRect frame = cell.contentLabel.frame;
        CGFloat contentHeight = [self heightWithText:content font:FONT_28PX width:SCREEN_WIDTH-30];
        frame.size.height = contentHeight+22;
        cell.contentLabel.frame = frame;
        
        return cell;
        
    } else if (type == 3) {
        IndexDetailsThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell3"];
        if (!cell) {
            cell = [[IndexDetailsThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell3"];
        }
        
        NSString *content = [info objectForKey:@"content"];
        content = [content stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
        cell.contentLabel.text = content;
        
        //设置frame
        CGRect frame = cell.contentLabel.frame;
        CGFloat contentHeight = [self heightWithText:content font:FONT_28PX width:SCREEN_WIDTH-30];
        frame.size.height = contentHeight+22;
        cell.contentLabel.frame = frame;
        
        return cell;
        
    }
    
    //表格
    else if (type == 4) {
        IndexDetailsFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell4"];
        if (!cell) {
            cell = [[IndexDetailsFourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell4"];
        }
        
        NSArray *content1s = [info objectForKey:@"content1"];
        NSDictionary *content1 = content1s[indexPath.row];
        cell.rowStr = [content1 objectForKey:@"row"];
        
        return cell;
        
    } else if (type == 5) {
        IndexDetailsFiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell5"];
        if (!cell) {
            cell = [[IndexDetailsFiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell5"];
        }
        
        cell.titleLabel.text = [info objectForKey:@"title"];
        
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = self.dataArray[indexPath.section];
    
    NSInteger type = [[info objectForKey:@"type"] integerValue];
    
    switch (type) {
        case 0: {
            return 0;
            break;
        }
        case 1: {
            NSString *content = [info objectForKey:@"content"];
            
            CGFloat height = [self heightWithText:content font:FONT_28PX width:SCREEN_WIDTH-95];
            return height+22;
            break;
        }
        case 2: {
            if (self.expandIndex == indexPath.section) {
                NSString *content = [info objectForKey:@"content"];
                content = [content stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
                
                CGFloat height = [self heightWithText:content font:FONT_28PX width:SCREEN_WIDTH-30];
                return 40.5+height+22;
            } else {
                return 40;
            }
            break;
        }
        case 3: {
            NSString *content = [info objectForKey:@"content"];
            content = [content stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
            
            CGFloat height = [self heightWithText:content font:FONT_28PX width:SCREEN_WIDTH-30];
            return height+22;
            break;
        }
            
            //表格
        case 4: {
            return 40;
            break;
        }
        case 5: {
            return 40;
            break;
        }
            
        default: {
            return 40;
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
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 40)];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.text = title;
        headerLabel.font = FONT_28PX;
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

- (void)tapExpand:(UITapGestureRecognizer *)tap
{
    NSArray *indexPaths = nil;
    NSInteger currentIndex = tap.view.tag;
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:currentIndex];
    
    if (self.expandIndex == -1) {
        indexPaths = @[currentIndexPath];
        self.expandIndex = currentIndex;
    } else if (self.expandIndex == tap.view.tag){
        indexPaths = @[currentIndexPath];
        self.expandIndex = -1;
    } else {
        indexPaths = @[[NSIndexPath indexPathForRow:0 inSection:self.expandIndex],
                       currentIndexPath];
    }
    
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

//根据文字取出高度
- (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width
{
    if (IS_IOS_7) {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]
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
 *  获取产品详情
 */
- (void)requestProductDetails
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
