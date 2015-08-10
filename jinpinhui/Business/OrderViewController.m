//
//  OrderViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "OrderViewController.h"
#import "orderTableViewCell.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong) UITableView *tableView;
@property(nonatomic ,strong) NSMutableArray *DataList;
@property(nonatomic ,assign) NSInteger page;
@end

@implementation OrderViewController
-(NSMutableArray *)DataList{
    if (!_DataList) {
        _DataList = [NSMutableArray array];
    }
    return _DataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"全部订单";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperviewWithEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)]; //设置autoLayout
    //添加下拉刷新
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //马上进入刷新状态
    [self.tableView.legendHeader beginRefreshing];
}
- (void)loadNewData
{
    _page = 1;
    [self requestOrder];
}
- (void)loadMoreData
{
    //网络请求
    [self requestOrder];
}
- (void)requestOrder
{
    [self.Parameters setValue:@"GETD" forKey:@"cmd"];
    [self.Parameters setValue:@"" forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:567 object:nil];
}
#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    [self.tableView.legendHeader endRefreshing];
    [self.tableView.legendFooter endRefreshing];
    
    NSLog(@"resultDic = %@",resultDic);
    NSLog(@"error = %@",[resultDic objectForKey:@"error"]);
    
    NSArray *tsubs = [resultDic objectForKey:@"Tsub"];
    if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
        if (tsubs.count > 0) {
            //下拉刷新清空数组
            if (_page == 1) {
                [self.DataList removeAllObjects];
            }
            
            //下一页+1
            _page++;
            
            //产品数据
            [self.DataList addObjectsFromArray:tsubs];
            
            //刷新UI
            [self.tableView reloadData];
        } else {
            //一条数据没有 不添加上拉加载
            if (self.DataList.count > 0) {
                [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
                //提示没有更多的数据
                [self.tableView.legendFooter noticeNoMoreData];
            }
        }
       
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"orderCell";
    orderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[orderTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.dataDic = [self.DataList objectAtIndex:indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
