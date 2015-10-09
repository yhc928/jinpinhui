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
#import "LoginUser.h"
#import "NickNameViewController.h"
#import "MyCurrencyViewController.h"
#import "RedEnvelopeViewController.h"
#import "AddressViewController.h"
#import "ModifyPasswordViewController.h"
#import "AuthenticationViewController.h"
#import "UIButton+WebCache.h"

@interface PersonalCenterViewController ()<UITableViewDelegate ,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)UIButton *headBtn;
@property(nonatomic ,strong)UIButton *nicknameBtn;
@property(nonatomic ,strong)NSArray *DataList;
@end

@implementation PersonalCenterViewController
-(void)SetDataAry{
    NSString *address;
    if ([[[LoginUser sharedLoginUser] address] isEqualToString:@""]) {
        address = @"未填写";
    }else{
        address = @"已填写";
    }
    NSString *checks;
    if ( [[[LoginUser sharedLoginUser] checks] isEqualToString:@"0"]) {
        checks = @"未认证";
    }else if ([[[LoginUser sharedLoginUser] checks] isEqualToString:@"1"]){
        checks = @"已认证";
    }else if ([[[LoginUser sharedLoginUser] checks] isEqualToString:@"2"]){
        checks = @"认证申请中";
    }
    NSString *redpackets;
    if ([[[LoginUser sharedLoginUser] redpackets] isEqualToString:@"0"]) {
        redpackets = @"未领取";
    }else redpackets = @"已领取";
    self.DataList = @[@[@{@"title":@"身份认证",@"info":checks}],@[@{@"title":@"我的等级",@"info":@"LV0"},@{@"title":@"我的金币",@"info":[[LoginUser sharedLoginUser] ugold]},@{@"title":@"新人红包",@"info":redpackets},@{@"title":@"收货地址",@"info":address}],@[@{@"title":@"修改登录密码",@"info":@""}]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人中心";
    [self SetDataAry];
//    NSLog(@"%@",self.DataList);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    if (IS_IOS_7) {
//        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 50);
//    }
    self.tableView.tableHeaderView = [self HeadView];
//    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [self FooterView];
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperview]; //设置autoLayout
    //监听昵称修改及时更新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NickNameNotification:) name:@"UpdateNickName" object:nil];
    //监听金币增加或减少通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CurrencyAddNotification:) name:@"CurrencyAddNotification" object:nil];

}
- (UIView *)HeadView{
    UIImageView *head_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 321/2)];
    head_bg.userInteractionEnabled = YES;
    head_bg.image = [UIImage imageNamed:@"Personalcenter_bg"];
    //头像背景
    UIImageView *headbtn_bg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 76) / 2, 20, 76, 76)];
    headbtn_bg.userInteractionEnabled = YES;
    headbtn_bg.image = [UIImage imageNamed:@"head_bg"];
    headbtn_bg.layer.cornerRadius = 76 / 2;
    headbtn_bg.layer.masksToBounds = YES;
    [head_bg addSubview:headbtn_bg];
    //头像按钮
    _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headBtn.frame = CGRectMake(3, 3, 70, 70);
//    [_headBtn setImage:[UIImage imageNamed:@"testhead"] forState:UIControlStateNormal];
    
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[[LoginUser sharedLoginUser] userimage]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"testhead"]];
    [_headBtn addTarget:self action:@selector(headAction) forControlEvents:UIControlEventTouchUpInside];
    _headBtn.layer.cornerRadius = 35;
    _headBtn.layer.masksToBounds = YES;
    [headbtn_bg addSubview:_headBtn];
    //昵称
    _nicknameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nicknameBtn.frame = CGRectMake((SCREEN_WIDTH - 130) / 2, CGRectGetMaxY(headbtn_bg.frame) + 10, 130, 70);
    _nicknameBtn.adjustsImageWhenHighlighted = NO;
    _nicknameBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    if ([[[LoginUser sharedLoginUser] realName] isEqualToString:@""]) {
         [_nicknameBtn setTitle:@"请输入您的昵称：" forState:UIControlStateNormal];
    }else  [_nicknameBtn setTitle:[[LoginUser sharedLoginUser] realName] forState:UIControlStateNormal];
//    [_nicknameBtn setTitle:@"设置昵称" forState:UIControlStateNormal];
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
     static NSString * identifier = @"Cell";
    PersonalCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PersonalCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        }
    if (indexPath.section == 0) {
        [cell.infoLab setTextColor:UIColorFromRGB(62, 121, 221)];
    }else {
        [cell.infoLab setTextColor:[UIColor blackColor]];
    }
    cell.titleLab.text = [[[self.DataList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    cell.infoLab.text = [[[self.DataList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"info"];

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else  return 20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 1) {
        MyCurrencyViewController *myCurrency  = [[MyCurrencyViewController alloc]init];
        [self.navigationController pushViewController:myCurrency animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 2){
        RedEnvelopeViewController *redEnvelope = [[RedEnvelopeViewController alloc]init];
        [self.navigationController pushViewController:redEnvelope animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 3){
        AddressViewController *address = [[AddressViewController alloc]init];
        [self.navigationController pushViewController:address animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 0){
        ModifyPasswordViewController *modifypassword = [[ModifyPasswordViewController alloc]init];
        [self.navigationController pushViewController:modifypassword animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 0){
        AuthenticationViewController *authentication = [[AuthenticationViewController alloc]init];
        authentication.IsRegistered = NO;
        [self.navigationController pushViewController:authentication animated:YES];

    }
}
- (void)headAction{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照",@"从手机相册中选择", nil];
    
    [actionSheet showInView:self.view];

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        // 从相册中取照片/相机
                UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
                ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                ipc.delegate = self;
                ipc.allowsEditing = YES;
                [self presentViewController:ipc animated:YES completion:nil];
      
    }
    if (buttonIndex == 0) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        ipc.allowsEditing = YES;
    }
}
// 当我们选择了一个图片  会调用的方法
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 刚刚选择的图片
    UIImage *Touimage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
         [_headBtn setImage:Touimage forState:UIControlStateNormal];
        [self.Parameters setValue:@"SETB" forKey:@"cmd"];
        [self.Parameters setValue:@"" forKey:@"para"];
        [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
        [self.Parameters setValue:[self encryption] forKey:@"md5"];
        
        CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
        [self jsonWithRequest:request delegate:self code:666 object:nil];
    }];
}
-(void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj{
    NSLog(@"%@",resultDic);
    if (code == 666) {
        if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
            
            NSString *imgurl = [NSString stringWithFormat:@"http://yupala.com/bin_cmd/uptest2.asp?id=%@",[resultDic objectForKey:@"info"]];
            CZRequestModel *request = [[CZRequestMaker sharedClient] publishActionParameters:nil uploadImage:[_headBtn currentImage] URL:imgurl];
            [self jsonWithRequest:request delegate:self code:777 object:nil];
        }
    }else if (code == 777){
        //图片上传成功
        if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
            NSLog(@"头像上传成功");
            [[LoginUser sharedLoginUser] setUserimage:[resultDic objectForKey:@"info"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateHeadImage" object:nil];
        }
    }
}
- (void)updateNickAction{
    NickNameViewController *nickName = [[NickNameViewController alloc]init];
    if ([[_nicknameBtn currentTitle] isEqualToString:@"请输入您的昵称："]) {
         nickName.nickName = @"";
    }else{
        nickName.nickName = [_nicknameBtn currentTitle];
    }
   
    [self.navigationController pushViewController:nickName animated:YES];
    
}
- (void)exitAction{
    [[LoginUser sharedLoginUser] setUserName:@""];
    [[LoginUser sharedLoginUser] setLoginStatus:@"1"];
    [[LoginUser sharedLoginUser] setPassword:@""];
    [[LoginUser sharedLoginUser] setRealName:@""];
    [[LoginUser sharedLoginUser] setUserimage:@""];
    [[LoginUser sharedLoginUser] setUsertrade:@""];
    [[LoginUser sharedLoginUser] setUservcard:@""];
    myAppDelegate.window.rootViewController =  [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
}

-(void)NickNameNotification:(NSNotification *)notifi{
     [_nicknameBtn setTitle:[[LoginUser sharedLoginUser] realName] forState:UIControlStateNormal];
}
-(void)CurrencyAddNotification:(NSNotification *)notifi{
    [self SetDataAry];
    [_tableView reloadData];
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
