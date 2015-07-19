//
//  FirstViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/17.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "FirstViewController.h"
#import "CycleScrollView.h"
#import "IndexCell.h"

@interface FirstViewController ()

@property (nonatomic, strong) UITableView *tableView;   //城市列表
@property (nonatomic, strong) CycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSArray     *dataArray;   //数据

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //城市表格
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperview]; //设置autoLayout
    
    self.cycleScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*3/8)];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.imageArray = @[@"1",@"2",@"3"];
    self.tableView.tableHeaderView = self.cycleScrollView;
    
//*************************************************************************************************************
    NSString *leftSidePath = [[NSBundle mainBundle] pathForResource:@"leftSide" ofType:@"plist"];
    self.dataArray = [NSArray arrayWithContentsOfFile:leftSidePath];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_side_selected"]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = FONT_30PX;
    }
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    NSString *iconNameStr = [dict objectForKey:@"icon"];
    cell.imageView.image = [UIImage imageNamed:iconNameStr];
    cell.textLabel.text = [dict objectForKey:@"title"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中效果
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - CycleScrollViewDelegate
- (void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectImageView:(NSInteger)index
{
    
}

@end
