//
//  SigninViewController.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/19.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "SigninViewController.h"
#import "PWSCalendarView.h"

@interface SigninViewController ()<PWSCalendarDelegate>
{
    UIView *SigninView;
    UIScrollView *scrollView;
    UILabel *singninTitleLab;
    UILabel *singninInfoLab;
}
@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"签到赚金币";
    [self SetInitialValue];
}
- (void) SetInitialValue
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    PWSCalendarView* view = [[PWSCalendarView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 600) CalendarType:en_calendar_type_month];
//        [view setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:view];
    [view setDelegate:self];
    
    // bottom view
    SigninView = [[UIView alloc] init];
    [SigninView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 80)];
    [SigninView setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:SigninView];
    UIButton *signinBtn =[UIButton buttonWithType:UIButtonTypeCustom];
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
- (void)signinAction{

}
// delegate
- (void) PWSCalendar:(PWSCalendarView*)_calendar didSelecteDate:(NSDate*)_date
{
    NSLog(@"select = %@", _date);
}

- (void) PWSCalendar:(PWSCalendarView*)_calendar didChangeViewHeight:(CGFloat)_height
{
    [SigninView setFrame:CGRectMake(0, _height + 20, kSCREEN_WIDTH, 80)];
    singninTitleLab.frame = CGRectMake(10, CGRectGetMaxY(SigninView.frame), SCREEN_WIDTH - 10, 30);
    singninInfoLab.frame = CGRectMake(0,  CGRectGetMaxY(singninTitleLab.frame), SCREEN_WIDTH , 220);
    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(singninInfoLab.frame) + 64 + 10)];
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
