//
//  IndexDetailsViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/11.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexDetailsViewController.h"
#import "IndexDetailsOneCell.h"
#import "IndexDetailsTwoCell.h"
#import "IndexDetailsThreeCell.h"
#import "IndexDetailsFourCell.h"
#import "IndexDetailsEightCell.h"

#import "ContentDetailsViewController.h"
#import "IndexWebViewController.h"
#import "ConventionViewController.h" //预约

@interface IndexDetailsViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UILabel *orderNumberLabel;

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
    [self.tableView constrainSubviewToMatchSuperviewWithEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 0)]; //设置autoLayout
    
    //立即预约
    UIView *orderBgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40-NAV_HEIGHT, SCREEN_WIDTH, 40)];
    orderBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:orderBgView];
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = LAYER_COLOR;
    [orderBgView addSubview:lineView];
    
    //0人预约
    self.orderNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 40)];
    self.orderNumberLabel.text = @"0人预约";
    self.orderNumberLabel.font = FONT_30PX;
    [orderBgView addSubview:self.orderNumberLabel];
    
    //立即预约
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.frame = CGRectMake(SCREEN_WIDTH-85, 5, 70, 30);
    orderButton.layer.cornerRadius = 5;
    orderButton.layer.borderWidth = 1;
    orderButton.layer.borderColor = UIColorFromRGB(212, 106, 20).CGColor;
    [orderButton setTitle:@"立即预约" forState:UIControlStateNormal];
    [orderButton setTitleColor:UIColorFromRGB(212, 106, 20) forState:UIControlStateNormal];
    orderButton.titleLabel.font = FONT_30PX;
    [orderButton addTarget:self action:@selector(didOrder) forControlEvents:UIControlEventTouchUpInside];
    [orderBgView addSubview:orderButton];

    //数据
    [self requestProductDetails];
    self.expandIndex = -1;
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    if (code == 1) {
        [self hideProgressHUD];
        //    NSLog(@"resultDic = %@",resultDic);
        
        if ([[resultDic objectForKey:@"resp_code"] integerValue] == 200) {
            NSString *pidsum = [resultDic objectForKey:@"pidsum"];
            self.orderNumberLabel.text = [NSString stringWithFormat:@"%@人预约",pidsum];
            
            self.dataArray = [resultDic objectForKey:@"info"];
            [self.tableView reloadData];
        }
    } else if (code == 2) {
        [self hideProgressHUD];
        [self showCustomProgressHUDWithText:[resultDic objectForKey:@"error"]];
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
    
    //只有标题
    if (type == 0 || type == 5 || type == 7) {
        return 0;
    }
    
    //表格
    else if (type == 4) {
        NSArray *content1s = [info objectForKey:@"content1"];
        return content1s.count;
    } else if (type == 8) {
        NSArray *content4s = [info objectForKey:@"content4"];
        return content4s.count;
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
        
        NSString *title = [info objectForKey:@"title"];
        cell.titleLabel.text = title;
        CGFloat width = [self widthWithText:title font:FONT_28PX];
        cell.titleLabel.frame = CGRectMake(15, 0, width, 40);
        
        NSString *content = [info objectForKey:@"content"];
        cell.contentLabel.text = content;
        CGFloat height = [self heightWithText:content font:FONT_28PX width:SCREEN_WIDTH-width-35];
        cell.contentLabel.frame = CGRectMake(15+width+5, 0, SCREEN_WIDTH-width-35, height+22);
        
        return cell;
    }
    
    //折叠
    else if (type == 2 || type == 6 || type == 9) {
        IndexDetailsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2"];
        if (!cell) {
            cell = [[IndexDetailsTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
            UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapExpand:)];
            [cell.titleLabel addGestureRecognizer:titleTap];
        }
        
        //箭头的指向
        if (self.expandIndex == indexPath.section) {
            cell.arrowImageView.image = [UIImage imageNamed:@"index_arrow_up"];
        } else {
            cell.arrowImageView.image = [UIImage imageNamed:@"index_arrow_down"];
        }
        
        //标题
        if (type == 2) {
            cell.titleLabel.text = [info objectForKey:@"subtitle"];
        } else {
            cell.titleLabel.text = [info objectForKey:@"title"];
        }
        
        cell.titleLabel.tag = indexPath.section;
        
        //正文
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
    
    //长文本
    else if (type == 3) {
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
        
    } else if (type == 8) {
        IndexDetailsEightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell8"];
        if (!cell) {
            cell = [[IndexDetailsEightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell8"];
        }
        
        NSArray *content4s = [info objectForKey:@"content4"];
        NSDictionary *content4 = content4s[indexPath.row];
        NSString *title = [content4 objectForKey:@"title"];
        cell.titleLabel.text = title;
        
        NSArray *blocks = [content4 objectForKey:@"block"];
        
        NSDictionary *block1 = [blocks firstObject];
        NSString *subtitle1 = [block1 objectForKey:@"title"];
        NSString *content1 = [block1 objectForKey:@"content"];
        content1 = [content1 stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
        cell.subtitleLabel1.text = subtitle1;
        cell.detailsLabel1.text = content1;
        
        NSDictionary *block2 = [blocks lastObject];
        NSString *subtitle2 = [block2 objectForKey:@"title"];
        NSString *content2 = [block2 objectForKey:@"content"];
        content2 = [content2 stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
        cell.subtitleLabel2.text = subtitle2;
        cell.detailsLabel2.text = content2;
        
        CGFloat titleWidth = [self widthWithText:title font:FONT_28PX]+10;
        CGFloat subtitleWidth = [self widthWithText:subtitle1 font:FONT_28PX]+10;
        
        CGFloat details1Height = [self heightWithText:content1 font:FONT_28PX width:SCREEN_WIDTH-10-titleWidth-subtitleWidth-1]+15;
        CGFloat details2Height = [self heightWithText:content2 font:FONT_28PX width:SCREEN_WIDTH-10-titleWidth-subtitleWidth-1]+15;
        
        CGFloat height = details1Height+details2Height+0.5;
        
        cell.titleLabel.frame = CGRectMake(0, 0, titleWidth, height);
        
        cell.subtitleLabel1.frame = CGRectMake(titleWidth+0.5, 0, subtitleWidth, details1Height);
        cell.subtitleLabel2.frame = CGRectMake(titleWidth+0.5, details1Height+0.5, subtitleWidth, details2Height);
        
        cell.detailsLabel1.frame = CGRectMake(titleWidth+subtitleWidth+1+5, 0, SCREEN_WIDTH-10-titleWidth-subtitleWidth-1, details1Height);
        cell.detailsLabel2.frame = CGRectMake(titleWidth+subtitleWidth+1+5, details1Height+0.5, SCREEN_WIDTH-10-titleWidth-subtitleWidth-1, details2Height);
        
        cell.lineView1.frame = CGRectMake(titleWidth, 0, 0.5, height);
        cell.lineView2.frame = CGRectMake(titleWidth+subtitleWidth+0.5, 0, 0.5, height);
        cell.lineView3.frame = CGRectMake(titleWidth, details1Height, SCREEN_WIDTH-titleWidth, 0.5);
        
        return cell;
        
    } else {
        NSLog(@"info = %@",info);
        
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
    
    if (type == 1) {
        NSString *title = [info objectForKey:@"title"];
        NSString *content = [info objectForKey:@"content"];
        
        CGFloat width = [self widthWithText:title font:FONT_28PX];
        CGFloat height = [self heightWithText:content font:FONT_28PX width:SCREEN_WIDTH-width-35];
        
        return height+22;
    }
    
    //折叠
    else if (type == 2 || type == 6 || type == 9) {
        if (self.expandIndex == indexPath.section) {
            NSString *content = [info objectForKey:@"content"];
            content = [content stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
            
            CGFloat height = [self heightWithText:content font:FONT_28PX width:SCREEN_WIDTH-30];
            
            return 40.5+height+22;
        } else {
            return 40;
        }
    }
    
    //长文本
    else if (type == 3) {
        NSString *content = [info objectForKey:@"content"];
        content = [content stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
        
        CGFloat height = [self heightWithText:content font:FONT_28PX width:SCREEN_WIDTH-30];
        
        return height+22;
        
    } else if (type == 8) {
        NSArray *content4s = [info objectForKey:@"content4"];
        
        NSDictionary *content4 = content4s[indexPath.row];
        NSString *title = [content4 objectForKey:@"title"];
        
        NSArray *blocks = [content4 objectForKey:@"block"];
        
        NSDictionary *block1 = [blocks firstObject];
        NSString *subtitle1 = [block1 objectForKey:@"title"];
        NSString *content1 = [block1 objectForKey:@"content"];
        content1 = [content1 stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
        
        NSDictionary *block2 = [blocks lastObject];
        NSString *content2 = [block2 objectForKey:@"content"];
        content2 = [content2 stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
        
        CGFloat titleWidth = [self widthWithText:title font:FONT_28PX]+10;
        CGFloat subtitleWidth = [self widthWithText:subtitle1 font:FONT_28PX]+10;
        
        CGFloat details1Height = [self heightWithText:content1 font:FONT_28PX width:SCREEN_WIDTH-10-titleWidth-subtitleWidth-1]+15;
        CGFloat details2Height = [self heightWithText:content2 font:FONT_28PX width:SCREEN_WIDTH-10-titleWidth-subtitleWidth-1]+15;
        
        CGFloat height = details1Height+details2Height+0.5;
        
        return height;
    }
    
    else {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *info = self.dataArray[section];
    NSInteger type = [[info objectForKey:@"type"] integerValue];
    
    if (type == 1 || type == 6 || type == 9) {
        return 0;
    } else {
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *info = self.dataArray[section];
    NSInteger type = [[info objectForKey:@"type"] integerValue];
    
    if (type == 1 || type == 6 || type == 9) {
        return nil;
    } else {
        NSString *title = [info objectForKey:@"title"];
        
        //标题背景
        UIView *headerView = [[UIView alloc] init];
        headerView.tag = section;
        headerView.backgroundColor = UIColorFromRGB(235, 235, 235);
        
        //标题
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-115, 40)];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.text = title;
        headerLabel.font = FONT_30PX;
        [headerView addSubview:headerLabel];
        
        if (type == 5 || type == 7) {
            //详细信息
            UILabel *detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 0, 70, 40)];
            detailsLabel.backgroundColor = [UIColor clearColor];
            detailsLabel.text = @"详细信息";
            detailsLabel.textColor = UIColorFromRGB(205, 104, 28);
            detailsLabel.textAlignment = NSTextAlignmentRight;
            detailsLabel.font = FONT_30PX;
            [headerView addSubview:detailsLabel];
            
            if (type == 7) {
                detailsLabel.text = @"查看";
            }
            
            //箭头
            UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"index_arrow_right"]];
            arrowImageView.frame = CGRectMake(SCREEN_WIDTH-30, 8, 24, 24);
            [headerView addSubview:arrowImageView];
            
            //手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSection:)];
            [headerView addGestureRecognizer:tap];
        }
        
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

/**
 *  tap type 5推出详细
 *
 *  @param tap tap手势
 */
- (void)tapSection:(UITapGestureRecognizer *)tap
{
    NSDictionary *info = self.dataArray[tap.view.tag];
    
    NSInteger type = [[info objectForKey:@"type"] integerValue];
    
    if (type == 5) {
        //推出 5 详情
        ContentDetailsViewController *contentDetailsVC = [[ContentDetailsViewController alloc] init];
        contentDetailsVC.info = info;
        [self.navigationController pushViewController:contentDetailsVC animated:YES];
    } else if (type == 7) {
        //网页
        IndexWebViewController *indexWebVC = [[IndexWebViewController alloc] init];
        indexWebVC.info = info;
        [self.navigationController pushViewController:indexWebVC animated:YES];
    }
}

/**
 *  tap展开
 *
 *  @param tap tap手势
 */
- (void)tapExpand:(UITapGestureRecognizer *)tap
{
    NSArray *indexPaths = nil;
    NSInteger currentIndex = tap.view.tag;
    
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:currentIndex];
    IndexDetailsTwoCell *currentCell = (IndexDetailsTwoCell *)[self.tableView cellForRowAtIndexPath:currentIndexPath];
    
    if (self.expandIndex == -1) {
        indexPaths = @[currentIndexPath];
        self.expandIndex = currentIndex;
        currentCell.arrowImageView.image = [UIImage imageNamed:@"index_arrow_up"];
    } else if (self.expandIndex == currentIndex){
        indexPaths = @[currentIndexPath];
        self.expandIndex = -1;
        currentCell.arrowImageView.image = [UIImage imageNamed:@"index_arrow_down"];
    } else {
        indexPaths = @[[NSIndexPath indexPathForRow:0 inSection:self.expandIndex],
                       currentIndexPath];
        self.expandIndex = currentIndex;
    }
    
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

//根据文字取出高度
- (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width
{
    if (IS_IOS_7) {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
        return rect.size.height;
    } else {
        CGSize size = [text sizeWithFont:font
                       constrainedToSize:CGSizeMake(width, MAXFLOAT)
                           lineBreakMode:NSLineBreakByWordWrapping];
        return size.height;
    }
}

- (CGFloat)widthWithText:(NSString *)text font:(UIFont *)font
{
    CGSize size;
    if (IS_IOS_7) {
        size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    } else {
        size = [text sizeWithFont:font];
    }
    
    return size.width;
}

/**
 *  立即预约
 */
- (void)didOrder
{
    ConventionViewController *conventionVC = [[ConventionViewController alloc] init];
    [self.navigationController pushViewController:conventionVC animated:YES];
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
    [self jsonWithRequest:request delegate:self code:1 object:nil];
    
    [self showProgressHUD];
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
