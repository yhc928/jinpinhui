//
//  AuthenticationViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/16.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "JPHpickView.h"
#import "MyDrawerViewController.h"
#import "LoginUser.h"
#import "UIButton+WebCache.h"

@interface AuthenticationViewController ()<UITableViewDelegate,UITableViewDataSource ,UIImagePickerControllerDelegate , UINavigationControllerDelegate,JPHpickViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UILabel *industryLab;
@property (nonatomic ,strong)UIButton *CardBtn;
//@property (nonatomic ,strong)UITextField *InvitecodeText;
@property (nonatomic ,strong)JPHpickView *pickview;
@property (nonatomic ,strong)NSString *hangye;
@end

@implementation AuthenticationViewController

//table
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"身份认证";
    [self.rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.rightButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.rightButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    UIView *topView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    topView.backgroundColor = UIColorFromRGB(115, 197, 212);
    [self.view addSubview:topView];
    
    [self.view addSubview:self.tableView];
    [self.tableView constrainSubviewToMatchSuperviewWithEdgeInsets:UIEdgeInsetsMake(CGRectGetMaxY(topView.frame), 0, 0, 0)]; //设置autoLayout
    //使用NSNotificationCenter 鍵盤出現時
//    [[NSNotificationCenter defaultCenter] addObserver:self
//     
//                                             selector:@selector(keyboardWasShown:)
//     
//                                                 name:UIKeyboardWillShowNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
//    [[NSNotificationCenter defaultCenter] addObserver:self
//     
//                                             selector:@selector(keyboardWillBeHidden:)
//     
//                                                 name:UIKeyboardWillHideNotification object:nil];
    if ([[[LoginUser sharedLoginUser] usertrade] isEqualToString:@""]) {
         self.hangye = @"请选择";
    }else self.hangye = [[LoginUser sharedLoginUser] usertrade];
   
}
//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
//- (void)keyboardWasShown:(NSNotification*)aNotification
//{
//    CGRect keyboardBounds = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    _tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, keyboardBounds.size.height, 0);
//}
//- (void)keyboardWillBeHidden:(NSNotification*)aNotification
//{
//
//    _tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, 0, 0);
//
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"所在行业";
             cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.textColor = UIColorFromRGB(71, 72, 73);
            _industryLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 140, 12, 100, 20)];
            _industryLab.textAlignment = NSTextAlignmentRight;
            _industryLab.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:_industryLab];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 1){
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            _CardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _CardBtn.frame = CGRectMake(10, 20, SCREEN_WIDTH - 20, 144);
           
            [_CardBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[[LoginUser sharedLoginUser] uservcard]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"shenfen_bg"]];
            [_CardBtn addTarget:self action:@selector(CardAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:_CardBtn];
        }
//        else if (indexPath.row == 2){
//            cell.textLabel.text = @"邀请码:";
//            cell.textLabel.font = [UIFont systemFontOfSize:15];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            _InvitecodeText = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80, 44)];
//            _InvitecodeText.placeholder = @"填写邀请码有奖 （选填）";
//            [cell.contentView addSubview:_InvitecodeText];
//        }
        else if (indexPath.row == 2){
             cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone; 
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 150)];
            backView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:backView];
            
            UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH, 20)];
            NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:@"状  态： 未认证"];
            [AttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, AttributedString.length - 3)];
            [AttributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(31, 125, 225) range:NSMakeRange(AttributedString.length - 3, 3)];
            [AttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, AttributedString.length - 3)];
            [AttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(AttributedString.length - 3, 3)];
            lable1.attributedText = AttributedString;
            [backView addSubview:lable1];
            NSData *reply = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"yaoqing" ofType:@"txt"]];
            NSString *yaoqing =  [[NSString alloc] initWithData:reply encoding:NSUTF8StringEncoding];
            UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(lable1.frame), SCREEN_WIDTH - 25, 110)];
            lable2.font = [UIFont systemFontOfSize:16];
            lable2.text = yaoqing;
            lable2.numberOfLines = 0;
            lable2.lineBreakMode = NSLineBreakByWordWrapping;
            [backView addSubview:lable2];
        }
        
    }
     _industryLab.text = self.hangye;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_pickview remove];
    if (indexPath.row == 0) {
        _pickview=[[JPHpickView alloc] initPickviewWithPlistName:@"hangye" isHaveNavControler:NO];
        _pickview.delegate=self;
        
        [_pickview show];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 184;
    }else if (indexPath.row == 3){
        return 170;
    }else
        return 44;
}
#pragma mark JPHpickVIewDelegate

-(void)toobarDonBtnHaveClick:(JPHpickView *)pickView resultString:(NSString *)resultString{
    
    self.hangye = resultString;
    [_tableView reloadData];
}
//身份证上传
-(void)CardAction{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", @"拍照", nil];
    [sheet showInView:self.view];

}
#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            ipc.delegate = self;
            ipc.allowsEditing = YES;
            [self presentViewController:ipc animated:YES completion:nil];
        }
            break;
            
        case 1:
        {
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            ipc.delegate = self;
            ipc.allowsEditing = YES;
            [self presentViewController:ipc animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 刚刚选择的图片
    UIImage *Cardimage = [info objectForKey:UIImagePickerControllerEditedImage];
    [_CardBtn setImage:Cardimage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj{
    NSLog(@"%@",resultDic);
    if (code == 333) {
        if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
            
            NSString *imgurl = [NSString stringWithFormat:@"http://yupala.com/bin_cmd/uptest2.asp?id=%@",[resultDic objectForKey:@"info"]];
            CZRequestModel *request = [[CZRequestMaker sharedClient] publishActionParameters:nil uploadImage:[_CardBtn currentImage] URL:imgurl];
            [self jsonWithRequest:request delegate:self code:444 object:nil];
        }
    }else if (code == 444){
        //图片上传成功
        if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
             if (self.IsRegistered) {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStatusSuccessful" object:nil userInfo:@{@"username":[[LoginUser sharedLoginUser] userName],@"password":[[LoginUser sharedLoginUser] password]}];  //发送登录成功状态请求个人信息
                 myAppDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:myAppDelegate.drawerController];
             }else{
                 [self showCustomProgressHUDWithText:@"您的信息已提交,请等待审核！"];
             }
        }
    }
}
//提交
-(void)submitAction:(id)sender{
    if (self.IsRegistered) {
        
        if ([self.hangye isEqualToString:@"请选择"]||[[_CardBtn currentImage] isEqual:[UIImage imageNamed:@"shenfen_bg"]]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"你确定要跳过？"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定", nil];
            alertView.tag = 120;
            [alertView show];

        }else{
            
                [self.Parameters setValue:@"SETC" forKey:@"cmd"];
                [self.Parameters setValue:self.hangye forKey:@"para"];
                [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
                [self.Parameters setValue:[self encryption] forKey:@"md5"];
                NSLog(@"%@",self.Parameters);

            
            CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
                [self jsonWithRequest:request delegate:self code:333 object:nil];
        }
    }else{
        if ([self.hangye isEqualToString:@"请选择"]) {
            [self showCustomProgressHUDWithText:@"请选择行业！"];
        }else if ([[_CardBtn currentImage] isEqual:[UIImage imageNamed:@"shenfen_bg"]]){
            [self showCustomProgressHUDWithText:@"请选择名片"];
        }else{
            [self.Parameters setValue:@"SETC" forKey:@"cmd"];
            [self.Parameters setValue:self.hangye forKey:@"para"];
            [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
            [self.Parameters setValue:[self encryption] forKey:@"md5"];
            NSLog(@"%@",self.Parameters);
            
            
            CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
            [self jsonWithRequest:request delegate:self code:333 object:nil];
        }
       
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 120) {
        if (buttonIndex) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginStatusSuccessful" object:nil];  //发送登录成功状态请求个人信息
            myAppDelegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:myAppDelegate.drawerController];
            
        }
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
