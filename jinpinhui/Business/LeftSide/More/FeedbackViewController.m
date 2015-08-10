//
//  FeedbackViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UITextView   *textView;         //输入框
@property (nonatomic, strong) UILabel      *placeholderLabel; //占位符

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    
    //背景
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT)];
    [self.view addSubview:self.bgScrollView];
    
    //输入框背景
    UIView *textBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 200)];
    textBgView.backgroundColor = [UIColor whiteColor];
    [self.bgScrollView addSubview:textBgView];
    
    //输入框
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, 190)];
    self.textView.font = FONT_30PX;
    self.textView.delegate = self;
    [textBgView addSubview:self.textView];
    
    //输入框占位符
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, SCREEN_WIDTH-20, 0)];
    self.placeholderLabel.textColor = [UIColor grayColor];
    self.placeholderLabel.text = @"说说您的想法和建议，我们将为您不断改进~";
    self.placeholderLabel.font = FONT_30PX;
    [textBgView addSubview:self.placeholderLabel];
    [self.placeholderLabel sizeToFit];
    
    //提交按钮
    UIImage *submitImage = [UIImage imageNamed:@"loginback"];
    submitImage = [submitImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 10, 0)
                                              resizingMode:UIImageResizingModeStretch];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(15, 250, SCREEN_WIDTH-30, 38);
    [submitButton setBackgroundImage:submitImage forState:UIControlStateNormal];
    [submitButton setTitle:@"吐槽一下" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(didSubmitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollView addSubview:submitButton];
    
    //打开键盘
    [self.textView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    [self hideProgressHUD];
    
//    NSLog(@"%@",resultDic);
    
    NSString *info = [resultDic objectForKey:@"info"];
    if (!NULL_STR(info)) {
        [self showCustomProgressHUDWithText:[resultDic objectForKey:@"info"]];
    }
    
    if ([[resultDic objectForKey:@"resp_code"] integerValue] == 200) {
        [self performSelector:@selector(didBack) withObject:nil afterDelay:1];
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
//    if (textView.text.length > 140) {
//        textView.text = [textView.text substringToIndex:140];
//    }
    
    if (textView.text.length > 0) {
        self.placeholderLabel.hidden = YES;
    } else {
        self.placeholderLabel.hidden = NO;
    }
}

//键盘将要出现的通知回调方法
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardBounds = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bgScrollView.contentSize = CGSizeMake(0, 300+CGRectGetHeight(keyboardBounds));
}

//键盘将要消失的通知回调方法
- (void)keyboardWillHide:(NSNotification *)notification
{
    self.bgScrollView.contentSize = CGSizeMake(0, 300);
}

/**
 *  点击提交按钮
 */
- (void)didSubmitButton
{
    if (self.textView.text.length > 0) {
        [self requestFeedback];
    } else {
        [self showCustomProgressHUDWithText:@"意见反馈不能为空哦"];
    }
}

/**
 *  提交意见反馈
 */
- (void)requestFeedback
{
    [self.Parameters setValue:@"SETA" forKey:@"cmd"];
    [self.Parameters setValue:self.textView.text forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:111 object:nil];
    
    [self showProgressHUD];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
