//
//  MoreViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/20.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "MoreViewController.h"
#import "MyDrawerViewController.h"

@interface MoreViewController ()

@property (nonatomic, strong) UITableView *tableView; //表格
@property (nonatomic, strong) NSArray     *dataArray; //数据

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"更多";
    
    //左侧按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = ITEM_FRAME;
    [leftButton setImage:[UIImage imageNamed:@"navi_left_normal"] forState:UIControlStateNormal];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftButton addTarget:self action:@selector(didOpenLeftSide) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    //右侧按钮
    UIButton *righButton = [UIButton buttonWithType:UIButtonTypeCustom];
    righButton.frame = ITEM_FRAME;
    [righButton setImage:[UIImage imageNamed:@"navi_right_user_normal"] forState:UIControlStateNormal];
    righButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [righButton addTarget:self action:@selector(didOpenRightSide) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:righButton];
    
    //表格
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperview]; //设置autoLayout
    
//*************************************************************************************************************
    NSString *morePath = [[NSBundle mainBundle] pathForResource:@"more" ofType:@"plist"];
    self.dataArray = [NSArray arrayWithContentsOfFile:morePath];
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
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    
}

/**
 *  打开左侧边栏
 */
- (void)didOpenLeftSide
{
    [myAppDelegate.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}

/**
 *  打开右侧边栏
 */
- (void)didOpenRightSide
{
    [myAppDelegate.drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
    }];
}

@end
