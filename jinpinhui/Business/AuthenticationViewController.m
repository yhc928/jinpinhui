//
//  AuthenticationViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/16.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "AuthenticationViewController.h"

@interface AuthenticationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UILabel *industryLab;
@property (nonatomic ,strong)UIButton *CardBtn;
@property (nonatomic ,strong)UITextField *InvitecodeText;
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
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
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
            _industryLab.text = @"请选择";
            [cell.contentView addSubview:_industryLab];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 1){
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            _CardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _CardBtn.frame = CGRectMake(10, 20, SCREEN_WIDTH - 20, 144);
            [_CardBtn setBackgroundImage:[UIImage imageNamed:@"shenfen_bg"] forState:UIControlStateNormal];
            [_CardBtn setBackgroundImage:[UIImage imageNamed:@"shenfen_bg"] forState:UIControlStateHighlighted];
            [_CardBtn addTarget:self action:@selector(CardAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:_CardBtn];
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"邀请码:";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            _InvitecodeText = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80, 44)];
            _InvitecodeText.placeholder = @"填写邀请码有奖 （选填）";
            [cell.contentView addSubview:_InvitecodeText];
        }else if (indexPath.row == 3){
             cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone; 
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 250)];
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
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 184;
    }else if (indexPath.row == 3){
        return 270;
    }else
        return 44;
}
//身份证上传
-(void)CardAction{
    
}
//提交
-(void)submitAction:(id)sender{
    
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
