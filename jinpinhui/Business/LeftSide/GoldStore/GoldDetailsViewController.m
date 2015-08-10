//
//  GoldDetailsViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/8/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "GoldDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "LoginUser.h"

@interface GoldDetailsViewController ()

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UIImageView  *goodsImageView;
@property (nonatomic, strong) UILabel      *goodsTitleLabel;
@property (nonatomic, strong) UILabel      *goodsPriceLabel;
@property (nonatomic, strong) UILabel      *detailsLabel;
@property (nonatomic, strong) UIButton     *buyButton;

@end

@implementation GoldDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    
    //背景
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-40)];
    self.bgScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgScrollView];
    
    //商品图片
    self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, GOLD_IMAGE_WIDTH, GOLD_IMAGE_HEIGHT)];
    [self.bgScrollView addSubview:self.goodsImageView];
    
    //商品标题
    self.goodsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+GOLD_IMAGE_WIDTH+20, 10, SCREEN_WIDTH-20-GOLD_IMAGE_WIDTH-20, 0)];
    self.goodsPriceLabel.numberOfLines = 2;
    self.goodsTitleLabel.font = FONT_32PX;
    [self.bgScrollView addSubview:self.goodsTitleLabel];
    
    //商品价格
    self.goodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140, 10+GOLD_IMAGE_HEIGHT-19, 100, 19)];
    self.goodsPriceLabel.textAlignment = NSTextAlignmentRight;
    self.goodsPriceLabel.textColor = UIColorFromRGB(252, 101, 77);
    self.goodsPriceLabel.font = FONT_34PX;
    [self.bgScrollView addSubview:self.goodsPriceLabel];
    
    //商品价格图标
    UIImageView *priceImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gold_store_coins"]];
    priceImageView.frame = CGRectMake(SCREEN_WIDTH-29, 10+GOLD_IMAGE_HEIGHT-19, 18, 19);
    [self.bgScrollView addSubview:priceImageView];
    
    //详细介绍背景
    UIView *greadBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+GOLD_IMAGE_HEIGHT+20, SCREEN_WIDTH, 45)];
    greadBgView.backgroundColor = UIColorFromRGB(236, 237, 238);
    [self.bgScrollView addSubview:greadBgView];
    
    //详细介绍固定文字
    UILabel *greadLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 45)];
    greadLabel.text = @"详细介绍";
    greadLabel.font = FONT_32PX;
    [greadBgView addSubview:greadLabel];
    
    //详细介绍
    self.detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10+GOLD_IMAGE_HEIGHT+20+45+10, SCREEN_WIDTH-20, 0)];
    self.detailsLabel.font = FONT_28PX;
    [self.bgScrollView addSubview:self.detailsLabel];
    
    //底部按钮
    self.buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buyButton.frame = CGRectMake(0, SCREEN_HEIGHT-NAV_HEIGHT-40, SCREEN_WIDTH, 40);
    [self.buyButton setBackgroundImage:[UIImage imageNamed:@"gold_buy_bg"] forState:UIControlStateNormal];
    [self.buyButton setBackgroundImage:[UIImage imageNamed:@"gold_buy_bg_disabled"] forState:UIControlStateDisabled];
    [self.buyButton setTitle:@"立即兑换" forState:UIControlStateNormal];
    [self.buyButton setTitle:@"金币不足" forState:UIControlStateDisabled];
    self.buyButton.titleLabel.font = FONT_32PX;
    [self.view addSubview:self.buyButton];
    
    //网络请求
    [self requestGoldStore];
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    [self hideProgressHUD];
    
//    NSLog(@"resultDic = %@",resultDic);
    
    if (resultDic.count > 0) {
        //图片
        NSString *gimg = [resultDic objectForKey:@"Gimg"];
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:gimg] placeholderImage:[UIImage imageNamed:@"gold_placeholder"]];
        
        //标题
        self.goodsTitleLabel.text = [resultDic objectForKey:@"Gname"];
        [self.goodsTitleLabel sizeToFit];
        
        //价格
        NSString *gmoney = [resultDic objectForKey:@"gmoney"];
        self.goodsPriceLabel.text = gmoney;
        
        //详细介绍
        self.detailsLabel.text = [resultDic objectForKey:@"gread"];
        [self.detailsLabel sizeToFit];
        
        //设置scrollView的contentSize
        CGFloat contentHeight = self.detailsLabel.frame.origin.y + CGRectGetHeight(self.detailsLabel.frame);
        self.bgScrollView.contentSize = CGSizeMake(0, contentHeight);
        
        //设置底部按钮
        NSString *myGold = [[LoginUser sharedLoginUser] ugold];
        if ([myGold integerValue] < [gmoney integerValue]) {
            self.buyButton.enabled = NO;
        }
    }
}

/**
 *  金币商城网络请求
 */
- (void)requestGoldStore
{
    [self.Parameters setValue:@"GETC" forKey:@"cmd"];
    [self.Parameters setValue:self.goodsId forKey:@"para"];
    [self.Parameters setValue:[self getCurrentTime] forKey:@"date"];
    [self.Parameters setValue:[self encryption] forKey:@"md5"];
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:self.Parameters];
    [self jsonWithRequest:request delegate:self code:111 object:nil];
    
    [self showProgressHUD];
}

@end
