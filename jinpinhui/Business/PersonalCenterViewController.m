//
//  PersonalCenterViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/14.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalCenterTableViewCell.h"
#import "LoginViewController.h"

@interface PersonalCenterViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)UIButton *headBtn;
@property(nonatomic ,strong)UIButton *nicknameBtn;
@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (IS_IOS_7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 50);
    }
    self.tableView.tableHeaderView = [self HeadView];
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [self FooterView];
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperview]; //设置autoLayout

}
- (UIView *)HeadView{
    UIImageView *head_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 321/2)];
    head_bg.userInteractionEnabled = YES;
    head_bg.image = [UIImage imageNamed:@"Personalcenter_bg"];
    //头像背景
    UIImageView *headbtn_bg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 76) / 2, 20, 76, 70)];
    headbtn_bg.userInteractionEnabled = YES;
    headbtn_bg.image = [UIImage imageNamed:@"head_bg"];
    headbtn_bg.layer.cornerRadius = 76 / 2;
    headbtn_bg.layer.masksToBounds = YES;
    [head_bg addSubview:headbtn_bg];
    //头像按钮
    _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headBtn.frame = CGRectMake(3, 3, 70, 70);
    [_headBtn setImage:[UIImage imageNamed:@"testhead"] forState:UIControlStateNormal];
    [_headBtn addTarget:self action:@selector(headAction) forControlEvents:UIControlEventTouchUpInside];
    _headBtn.layer.cornerRadius = 35;
    _headBtn.layer.masksToBounds = YES;
    [headbtn_bg addSubview:_headBtn];
    //昵称
    _nicknameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nicknameBtn.frame = CGRectMake((SCREEN_WIDTH - 70) / 2, CGRectGetMaxY(headbtn_bg.frame) + 10, 70, 70);
    _nicknameBtn.adjustsImageWhenHighlighted = NO;
    _nicknameBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_nicknameBtn setTitle:@"输入昵称" forState:UIControlStateNormal];
    [_nicknameBtn setTitleColor:UIColorFromRGB(65, 65, 61) forState:UIControlStateNormal];
    [_nicknameBtn addTarget:self action:@selector(updateNickAction) forControlEvents:UIControlEventTouchUpInside];
    [head_bg addSubview:_nicknameBtn];
    return head_bg;
}
- (UIView *)FooterView{
    UIView *exitView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 60)];
    exitView.backgroundColor = [UIColor clearColor];
    UIButton *exitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 38);
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"exit_bg"] forState:UIControlStateNormal];
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"exit_bg_h"] forState:UIControlStateHighlighted];
    [exitBtn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    [exitView addSubview:exitBtn];
    return exitView;
}
#pragma UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) return 4;
    else return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[PersonalCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
    

    return cell;

}
- (void)headAction{

}
- (void)updateNickAction{
    
}
- (void)exitAction{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:USERNAME];
    [user removeObjectForKey:PASSWORD];
    [user setObject:@"1" forKey:LOGINSTATUS];
    [user synchronize];
    myAppDelegate.window.rootViewController =  [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
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
