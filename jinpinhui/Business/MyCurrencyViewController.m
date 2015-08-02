//
//  MyCurrencyViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/8/1.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "MyCurrencyViewController.h"
#import "LoginUser.h"
#import "CurrencyTableViewCell.h"

@interface MyCurrencyViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *dataList;
@end

@implementation MyCurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的金币";
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    headView.backgroundColor = UIColorFromRGB(115, 197, 212);
    [self.view addSubview:headView];
    UILabel *currencyTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(headView.frame), 80, 40)];
    currencyTitle.text = @"我的金币";
    currencyTitle.font = [UIFont boldSystemFontOfSize:20];
    currencyTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:currencyTitle];
    UIImage *image = [UIImage imageNamed:@"gold_store_coins"];
    UILabel *currencyLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(currencyTitle.frame),CGRectGetMaxY(headView.frame) , SCREEN_WIDTH - CGRectGetMaxX(currencyTitle.frame) - image.size.width - 40, 40)];
    currencyLab.textAlignment = NSTextAlignmentRight;
    currencyLab.textColor = UIColorFromRGB(166, 46, 48);
    currencyLab.font = [UIFont systemFontOfSize:28];
    currencyLab.backgroundColor = [UIColor clearColor];
    currencyLab.text = [[LoginUser sharedLoginUser] ugold];
    [self.view addSubview:currencyLab];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(currencyLab.frame) + 10,CGRectGetMaxY(headView.frame) + (40 - image.size.width) / 2, image.size.width, image.size.height)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    UIView *ListTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(currencyLab.frame), SCREEN_WIDTH, 40)];
    ListTitleView.backgroundColor = UIColorFromRGB(206, 98, 100);
    [self.view addSubview:ListTitleView];
    NSArray *titleAry = @[@"时间",@"详情",@"金币"];
    for (NSInteger i = 0; i< 3; i++) {
        UILabel *listLab = [[UILabel alloc]initWithFrame:CGRectMake(i * (SCREEN_WIDTH / 3), 0, SCREEN_WIDTH / 3, 40)];
        listLab.text = titleAry[i];
        listLab.textColor = [UIColor whiteColor];
        listLab.font = [UIFont systemFontOfSize:18];
        listLab.textAlignment = NSTextAlignmentCenter;
        [ListTitleView addSubview:listLab];
    }
    [self requestCurrency];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperviewWithEdgeInsets:UIEdgeInsetsMake(CGRectGetMaxY(ListTitleView.frame), 0, 0, 0)]; //设置autoLayout
}
-(void)requestCurrency{
    [self.Parameters setValue:@"GETY" forKey:@"cmd"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:112 object:nil];
}
-(void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj{
    if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
        self.dataList = [[NSMutableArray alloc]init];
        [self.dataList addObjectsFromArray:[resultDic objectForKey:@"Tsub"]];
        [self.tableView reloadData];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"Cell";
    CurrencyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CurrencyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.datetimeLab.text = [[self. dataList objectAtIndex:indexPath.section] objectForKey:@"wdate"];
    cell.infoLab.text = [[self. dataList objectAtIndex:indexPath.section] objectForKey:@"Gread"];
    cell.currencyLab.text = [NSString stringWithFormat:@"+ %@",[[self. dataList objectAtIndex:indexPath.section] objectForKey:@"Ggd"]];
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
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
