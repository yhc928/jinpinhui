//
//  SigninViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/19.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "SigninViewController.h"
#import "PWSCalendarView.h"
#import "LoginUser.h"

@interface SigninViewController ()<PWSCalendarDelegate>
{
    UIView *SigninView;
    UIScrollView *scrollView;
    UILabel *singninTitleLab;
    UILabel *singninInfoLab;
    UIButton *signinBtn;
    PWSCalendarView* calendarView;
    BOOL IsSignin;

}
@property (nonatomic ,strong) NSMutableArray *dataList;
@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"签到赚金币";
    self.dataList = [NSMutableArray array];
    [self SetInitialValue];
    [self requestSignin];
}
- (void) SetInitialValue
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    calendarView = [[PWSCalendarView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 600) CalendarType:en_calendar_type_month];
//        [view setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:calendarView];
    [calendarView setDelegate:self];
    
    // bottom view
    SigninView = [[UIView alloc] init];
    [SigninView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 80)];
    [SigninView setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:SigninView];
    signinBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    signinBtn.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 38);
    [signinBtn setTitle:@"立即签到" forState:UIControlStateNormal];
    signinBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [signinBtn setBackgroundImage:[UIImage imageNamed:@"loginback"] forState:UIControlStateNormal];
    [signinBtn setBackgroundImage:[UIImage imageNamed:@"loginback_highlighted"] forState:UIControlStateHighlighted];
    [signinBtn addTarget:self action:@selector(signinAction) forControlEvents:UIControlEventTouchUpInside];
    [SigninView addSubview:signinBtn];
    singninTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(SigninView.frame), SCREEN_WIDTH - 10, 30)];
    singninTitleLab.text = @"签到规则：";
    singninTitleLab.font = [UIFont systemFontOfSize:18];
    singninTitleLab.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:singninTitleLab];
    NSData *reply = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"qiandao" ofType:@"txt"]];
    NSString *qiandao =  [[NSString alloc] initWithData:reply encoding:NSUTF8StringEncoding];
    NSLog(@"%zi",[qiandao rangeOfString:@"+10"].length);
     NSLog(@"%zi",[qiandao rangeOfString:@"+10"].location);
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:qiandao];
    [AttributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(223, 77, 13) range:[qiandao rangeOfString:@"+10"]];
     [AttributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(223, 77, 13) range:[qiandao rangeOfString:@"+20"]];
     [AttributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(223, 77, 13) range:[qiandao rangeOfString:@"+30"]];
     [AttributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(223, 77, 13) range:[qiandao rangeOfString:@"+50"]];
     [AttributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(223, 77, 13) range:[qiandao rangeOfString:@"+100"]];
    
    singninInfoLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(singninTitleLab.frame), SCREEN_WIDTH, 150)];
    singninInfoLab.font = [UIFont systemFontOfSize:14];
    singninInfoLab.lineBreakMode = NSLineBreakByWordWrapping |NSLineBreakByCharWrapping ;
    singninInfoLab.numberOfLines = 0;
    singninInfoLab.backgroundColor = [UIColor whiteColor];
    singninInfoLab.attributedText = AttributedString;
    [scrollView addSubview:singninInfoLab];
}

-(void)setDataList:(NSMutableArray *)dataList{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    for (NSDictionary *dic in  dataList) {
        //如果签到的日期有今天
        if ([[dic objectForKey:@"wdate"] isEqualToString:[dateFormatter stringFromDate:[NSDate date]]]) {
            signinBtn.userInteractionEnabled = NO;
            [signinBtn setBackgroundImage:[UIImage imageNamed:@"notuseBtn_bg"] forState:UIControlStateNormal];
            [signinBtn setTitle:@"已签到" forState:UIControlStateNormal];
            IsSignin = YES;
        }
    }
}
- (void)signinAction{
    [self.Parameters setValue:@"SETY" forKey:@"cmd"];
//    [self.Parameters setValue:_date forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:130 object:nil];
}
// delegate
- (void) PWSCalendar:(PWSCalendarView*)_calendar didSelecteDate:(NSDate*)_date
{
    NSLog(@"select = %@", _date);
    NSInteger status = [self compareOneDay:[NSDate date] withAnotherDay:_date];
    NSLog(@"%zi",status);
    if (status == -1) {
        //还未开始签到  时间还未到
        signinBtn.userInteractionEnabled = NO;
        [signinBtn setBackgroundImage:[UIImage imageNamed:@"notuseBtn_bg"] forState:UIControlStateNormal];
         [signinBtn setTitle:@"未开始" forState:UIControlStateNormal];
    }else if (status == 1){
        //已经过去
        signinBtn.userInteractionEnabled = NO;
        [signinBtn setBackgroundImage:[UIImage imageNamed:@"notuseBtn_bg"] forState:UIControlStateNormal];
        [signinBtn setTitle:@"已结束" forState:UIControlStateNormal];
    }else if (status == 0){
        //就是今天
        
        if (IsSignin) {
            signinBtn.userInteractionEnabled = NO;
            [signinBtn setBackgroundImage:[UIImage imageNamed:@"notuseBtn_bg"] forState:UIControlStateNormal];
            [signinBtn setTitle:@"已签到" forState:UIControlStateNormal];
        }else{
            signinBtn.userInteractionEnabled = YES;
            [signinBtn setBackgroundImage:[UIImage imageNamed:@"loginback"] forState:UIControlStateNormal];
            
            [signinBtn setTitle:@"立即签到" forState:UIControlStateNormal];
        }
       
    }
}
-(void)requestSignin{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *oneDayStr = [NSString stringWithFormat:@"%@-01",[dateFormatter stringFromDate:[NSDate date]]];
   
    [self.Parameters setValue:@"GETY2" forKey:@"cmd"];
    [self.Parameters setValue:oneDayStr forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:120 object:nil];
}
-(void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj{
    NSLog(@"%@",resultDic);
    NSLog(@"%@",[resultDic objectForKey:@"error"]);
    if ([[resultDic objectForKey:@"resp_code"] isEqualToString:@"200"]) {
        if (code == 130) {
            signinBtn.userInteractionEnabled = NO;
            [signinBtn setBackgroundImage:[UIImage imageNamed:@"notuseBtn_bg"] forState:UIControlStateNormal];
            [signinBtn setTitle:@"已签到" forState:UIControlStateNormal];

            
            [[LoginUser sharedLoginUser] setUgold:[resultDic objectForKey:@"gsum"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CurrencyAddNotification" object:nil];
            [self showCustomProgressHUDWithText:@"签到成功!"];
        }else{
            
            if ([[resultDic objectForKey:@"Tsub"] count] > 0) {
                calendarView.DateList = [resultDic objectForKey:@"Tsub"];
                self.dataList = [resultDic objectForKey:@"Tsub"];
            }
           
        }
    }
}
-(void)PWSCalendar:(PWSCalendarView *)_calendar monthDate:(NSString *)_date{
    [self.Parameters setValue:@"GETY2" forKey:@"cmd"];
    [self.Parameters setValue:_date forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:120 object:nil];
}
- (void) PWSCalendar:(PWSCalendarView*)_calendar didChangeViewHeight:(CGFloat)_height
{
    [SigninView setFrame:CGRectMake(0, _height + 20, kSCREEN_WIDTH, 80)];
    singninTitleLab.frame = CGRectMake(10, CGRectGetMaxY(SigninView.frame), SCREEN_WIDTH - 10, 30);
    singninInfoLab.frame = CGRectMake(0,  CGRectGetMaxY(singninTitleLab.frame), SCREEN_WIDTH , 220);
    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(singninInfoLab.frame) + 64 + 10)];
}

-(NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
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
