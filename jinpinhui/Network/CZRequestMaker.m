//
//  CZRequestMaker.m
//  Shequ001
//
//  Created by 陈震 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "CZRequestMaker.h"
#import "CZRequestModel.h"

@implementation CZRequestMaker

//接口方法的单例
+ (instancetype)sharedClient
{
    static CZRequestMaker *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CZRequestMaker alloc] init];
    });
    
    return _sharedClient;
}

- (CZRequestModel *)getBin_cmdWithParameters:(NSDictionary *)parameters
{
    NSString *urlStr = [NSString stringWithFormat:@"http://yupala.com/bin_cmd/index.asp"];
    CZRequestModel *request = [[CZRequestModel alloc] initWithUrlStr:urlStr parameters:parameters uploadImage:nil];
    
    return request;
}

- (CZRequestModel *)getUserActionWithParameters:(NSDictionary *)parameters
{
    NSString *urlStr = [NSString stringWithFormat:@"http://114.112.96.70:80/hxhServer/userAction"];
    CZRequestModel *request = [[CZRequestModel alloc] initWithUrlStr:urlStr parameters:parameters uploadImage:nil];
    
    return request;
}


/*
//获取城市列表
- (CZRequestModel *)getCityList
{
    NSString *urlStr = [NSString stringWithFormat:@"%@getCityList?reqtype=02",DOMAIN_NAME];
    CZRequestModel *request = [[CZRequestModel alloc] initWithUrlStr:urlStr jsonStr:nil uploadImage:nil];
    
    return request;
}

//获取城市社区商圈列表
- (CZRequestModel *)getBusinessCircleList
{
    NSString *urlStr = [NSString stringWithFormat:@"%@getBusinessCircleList?reqtype=02&city_code=%@&page=1&limit=999",DOMAIN_NAME,CITY_CODE_STR];
    CZRequestModel *request = [[CZRequestModel alloc] initWithUrlStr:urlStr jsonStr:nil uploadImage:nil];
    
    return request;
}

//轮播图列表
- (CZRequestModel *)getBannerListWithMarket_type:(NSString *)market_type
{
    NSString *urlStr = [NSString stringWithFormat:@"%@getBannerList?reqtype=02&city_code=%@&bid=%@&market_type=%@",DOMAIN_NAME,CITY_CODE_STR,BID_STR,market_type];
    CZRequestModel *request = [[CZRequestModel alloc] initWithUrlStr:urlStr jsonStr:nil uploadImage:nil];
    
    return request;
}

//⾸首⻚页超市商品信息
- (CZRequestModel *)getHomeMarketGoods
{
    NSString *urlStr = [NSString stringWithFormat:@"%@getHomeMarketGoods?reqtype=02&city_code=%@&bid=%@",DOMAIN_NAME,CITY_CODE_STR,BID_STR];
    CZRequestModel *request = [[CZRequestModel alloc] initWithUrlStr:urlStr jsonStr:nil uploadImage:nil];
    
    return request;
}

//推荐商户
- (CZRequestModel *)getRecomdBusinessList
{
    NSString *urlStr = [NSString stringWithFormat:@"%@getRecomdBusinessList?reqtype=02&city_code=%@&bid=%@&page=1&limit=999",DOMAIN_NAME,CITY_CODE_STR,BID_STR];
    CZRequestModel *request = [[CZRequestModel alloc] initWithUrlStr:urlStr jsonStr:nil uploadImage:nil];
    
    return request;
}

//特价商品
- (CZRequestModel *)getBargainGoodsWithMarket_type:(NSString *)market_type
{
    NSString *urlStr = [NSString stringWithFormat:@"%@getBargainGoods?reqtype=02&city_code=%@&bid=%@&market_type=%@&page=1&limit=999",DOMAIN_NAME,CITY_CODE_STR,BID_STR,market_type];
    CZRequestModel *request = [[CZRequestModel alloc] initWithUrlStr:urlStr jsonStr:nil uploadImage:nil];
    
    return request;
}
 */

@end
