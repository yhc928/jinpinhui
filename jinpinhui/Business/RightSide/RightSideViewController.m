//
//  RightSideViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/12.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "RightSideViewController.h"
#import "PersonalCenterViewController.h"
#import "MyDrawerViewController.h"
#import "CommissionViewController.h"
#import "SigninViewController.h"
#import "InvitationViewController.h"
#import "LoginUser.h"
#import "UIImageView+WebCache.h"
#import "ConventionViewController.h"
#import "OrderViewController.h"
#import "DaKuanViewController.h"
#import "HeTongViewController.h"
#import "FanYongViewController.h"

@interface RightSideViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic ,strong) UIImageView *headimageView;
@property(nonatomic ,strong) UILabel *nicknameLab;
@property(nonatomic ,strong) UILabel *currencyLab;
@property(nonatomic ,strong) UILabel *levelLab;
@property(nonatomic ,strong) UITableView *tableView;
@property(nonatomic ,strong) NSArray *dataList;
@end

@implementation RightSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //登录成功 请求个人信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginStatusSuccessfulDone:) name:@"LoginStatusSuccessful" object:nil];
    //背景图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_side_bg"]];
    [self.view addSubview:bgImageView];
    [bgImageView constrainSubviewToMatchSuperview];
    [self requestUserInfo];
    [self ControllerView];
    //监听昵称修改及时更新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NickNameNotification:) name:@"UpdateNickName" object:nil];
    //监听金币增加或减少通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CurrencyAddNotification:) name:@"CurrencyAddNotification" object:nil];
    //头像更新通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateHeadImageNotification:) name:@"UpdateHeadImage" object:nil];
    
}
- (void)ControllerView{
    //头像
    _headimageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 50 - 70) / 2 , 34, 70, 70)];
//    _headimageView.image = [UIImage imageNamed:@"testhead"];
    NSLog(@"%@",[[LoginUser sharedLoginUser] userimage]);
    [_headimageView sd_setImageWithURL:[NSURL URLWithString:[[LoginUser sharedLoginUser] userimage]] placeholderImage:[UIImage imageNamed:@"testhead"]];
    _headimageView.layer.cornerRadius = 35;
    _headimageView.layer.masksToBounds = YES;
    [self.view addSubview:_headimageView];
    //昵称
    _nicknameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headimageView.frame) + 10, (SCREEN_WIDTH - 50) / 2 , 20)];
    _nicknameLab.textColor = [UIColor whiteColor];
    _nicknameLab.font = [UIFont systemFontOfSize:15];
    _nicknameLab.textAlignment = NSTextAlignmentRight;
    if ([[[LoginUser sharedLoginUser] realName] isEqualToString:@""]) {
         _nicknameLab.text = [[LoginUser sharedLoginUser] userName];
    }else  _nicknameLab.text = [[LoginUser sharedLoginUser] realName];
   
    [self.view addSubview:_nicknameLab];
    //分割线
    UIView *nc_line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nicknameLab.frame) + 10, CGRectGetMaxY(_headimageView.frame) + 12, 1, 16)];
    nc_line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nc_line];
    _currencyLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nc_line.frame) + 10, CGRectGetMaxY(_headimageView.frame) + 10, (SCREEN_WIDTH - 50) / 2, 20)];
    _currencyLab.textColor = [UIColor whiteColor];
    _currencyLab.font = [UIFont systemFontOfSize:15];
    _currencyLab.textAlignment = NSTextAlignmentLeft;
    _currencyLab.text = @"1000金币";
    [self.view addSubview:_currencyLab];
    //等级
    _levelLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nicknameLab.frame) + 10, SCREEN_WIDTH - 50, 20)];
    _levelLab.textColor = [UIColor whiteColor];
    _levelLab.font = [UIFont systemFontOfSize:16];
    _levelLab.textAlignment = NSTextAlignmentCenter;
    _levelLab.text = @"LV0  击败了全国0%的用户";
    [self.view addSubview:_levelLab];
    //上部横向线
    UIView *top_h_line = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_levelLab.frame) + 20, SCREEN_WIDTH - 50 - 20 - 15, 0.5)];
    top_h_line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:top_h_line];
    NSArray *normalAry = @[@"right_navi_btn_order_normal",@"right_navi_btn_paid_normal",@"right_navi_btn_contract_normal",@"right_navi_btn_rake back_normal"];
//    NSArray *pressAry = @[@"right_navi_btn_order_press",@"right_navi_btn_paid_press",@"right_navi_btn_contract_press",@"right_navi_btn_rake back_press"];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i == 0 ? 20 :i * ( CGRectGetWidth(top_h_line.frame) / 4) + 20, CGRectGetMaxY(top_h_line.frame) + 10, CGRectGetWidth(top_h_line.frame) / 4, 45);
        [button setImage:[UIImage imageNamed:[normalAry objectAtIndex:i]] forState:UIControlStateNormal];
          [button setImage:[UIImage imageNamed:[normalAry objectAtIndex:i]] forState:UIControlStateHighlighted];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    UIView *bottom_h_line = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(top_h_line.frame) + 10 + 45 + 10, SCREEN_WIDTH - 50 - 20 - 15, 0.5)];
    bottom_h_line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottom_h_line];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (IS_IOS_7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 50);
    }
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperviewWithEdgeInsets:UIEdgeInsetsMake(CGRectGetMaxY(bottom_h_line.frame) + 10, 0, 0, 0)]; //设置autoLayout
    NSString *leftSidePath = [[NSBundle mainBundle] pathForResource:@"rigthSide" ofType:@"plist"];
    self.dataList = [NSArray arrayWithContentsOfFile:leftSidePath];
}
- (void)LoginStatusSuccessfulDone:(NSNotification *)notifi{
    NSDictionary *dic = [notifi userInfo];
   
    [self.Parameters setValue:[dic objectForKey:@"username"] forKey:@"username"];
    [self.Parameters setValue:[dic objectForKey:@"password"] forKey:@"password"];
    [self requestUserInfo];
}
/**
 *  获取用户信息
 *
 *  @param NSInteger
 *
 *  @return
 */
- (void)requestUserInfo{
    [self.Parameters removeObjectForKey:@"para"];
    [self.Parameters setValue:@"GETZ" forKey:@"cmd"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    NSLog(@"%@",self.Parameters);
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:115 object:nil];

}
-(void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj{
    NSLog(@"%@",resultDic);
    NSLog(@"%@",[resultDic objectForKey:@"error"]);
    if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
        _currencyLab.text = [NSString stringWithFormat:@"%@金币",[resultDic objectForKey:@"ugold"]];
        if ([[[LoginUser sharedLoginUser] realName] isEqualToString:@""]) {
            _nicknameLab.text = [[LoginUser sharedLoginUser] userName];
        }else  _nicknameLab.text = [resultDic objectForKey:@"nick"];
        
        [_headimageView sd_setImageWithURL:[NSURL URLWithString:[resultDic objectForKey:@"userimage"]] placeholderImage:[UIImage imageNamed:@"testhead"]];
        [[LoginUser sharedLoginUser] setAddress:[resultDic objectForKey:@"addr"]];
        [[LoginUser sharedLoginUser] setChecks:[resultDic objectForKey:@"checks"]];
        [[LoginUser sharedLoginUser] setUgold:[resultDic objectForKey:@"ugold"]];
        [[LoginUser sharedLoginUser] setRealName:[resultDic objectForKey:@"nick"]];
        [[LoginUser sharedLoginUser] setUserimage:[resultDic objectForKey:@"userimage"]];
        [[LoginUser sharedLoginUser] setUsertrade:[resultDic objectForKey:@"usertrade"]];
        [[LoginUser sharedLoginUser] setUservcard:[resultDic objectForKey:@"uservcard"]];
        [[LoginUser sharedLoginUser] setCity:[resultDic objectForKey:@"area"]];
        [[LoginUser sharedLoginUser] setConsignee:[resultDic objectForKey:@"uname"]];
        [[LoginUser sharedLoginUser] setTel:[resultDic objectForKey:@"tel"]];
        [[LoginUser sharedLoginUser] setRedpackets:[resultDic objectForKey:@"redpackets"]];
    }
}
#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
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
    
    NSDictionary *dict = self.dataList[indexPath.row];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //centerViewController
    if (indexPath.row == 0) {
        PersonalCenterViewController *personalcenter = [[PersonalCenterViewController alloc]init];
        [myAppDelegate.drawerController.navigationController pushViewController:personalcenter animated:YES];
    }else if (indexPath.row == 1){
        OrderViewController *orderView = [[OrderViewController alloc]init];
        [myAppDelegate.drawerController.navigationController pushViewController:orderView animated:YES];
    }else if (indexPath.row == 2){
        CommissionViewController *commission =  [[CommissionViewController alloc]init];
        [myAppDelegate.drawerController.navigationController pushViewController:commission animated:YES];
    }else if (indexPath.row == 3){
        SigninViewController *signin = [[SigninViewController alloc]init];
        [myAppDelegate.drawerController.navigationController pushViewController:signin animated:YES];
    }else if (indexPath.row == 4){
        InvitationViewController *invitation = [[InvitationViewController alloc]init];
        [myAppDelegate.drawerController.navigationController pushViewController:invitation animated:YES];
    }
}

-(void)NickNameNotification:(NSNotification *)notifi{
    _nicknameLab.text = [[LoginUser sharedLoginUser] realName];
}
-(void)CurrencyAddNotification:(NSNotification *)notifi{
    _currencyLab.text = [NSString stringWithFormat:@"%@金币",[[LoginUser sharedLoginUser] ugold]];
}
-(void)UpdateHeadImageNotification:(NSNotification *)notifi{
    [_headimageView sd_setImageWithURL:[NSURL URLWithString:[[LoginUser sharedLoginUser] userimage]] placeholderImage:[UIImage imageNamed:@"testhead"]];
}
-(void)BtnClick:(UIButton *)sender{
    if (sender.tag == 100) {
        //预约
        ConventionViewController *convention = [[ConventionViewController alloc]init];
        [self.navigationController pushViewController:convention animated:YES];
    }else if (sender.tag == 101) {
        //打款
        DaKuanViewController *dakuan = [[DaKuanViewController alloc]init];
        [self.navigationController pushViewController:dakuan animated:YES];
    }else if (sender.tag == 102) {
        //合同
        HeTongViewController *hetong = [[HeTongViewController alloc]init];
        [self.navigationController pushViewController:hetong animated:YES];
    }else if (sender.tag == 103) {
        //返佣
        FanYongViewController *fanyong = [[FanYongViewController alloc]init];
        [self.navigationController pushViewController:fanyong animated:YES];
    }
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
