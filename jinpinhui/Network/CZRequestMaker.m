//
//  CZRequestMaker.m
//  Shequ001
//
//  Created by xiao7 on 15/6/5.
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

//3.2.6 轮播图列表
//- (CZRequestModel *)getBannerListWithModel:(ReqBannerModel *)model
//{
//    NSString *urlStr = [NSString stringWithFormat:@"%@getBannerList?reqtype=02&city_code=%@&bid=%@&market_type=%@",DOMAIN_NAME,model.city_code,model.bid,model.market_type];
//    CZRequestModel *request = [[CZRequestModel alloc] initWithUrlStr:urlStr jsonStr:nil uploadImage:nil];
//    
//    return request;
//}
//
////3.2.7 ⾸首⻚页超市商品信息
//- (CZRequestModel *)getHomeMarketGoodsWithModel:(ReqBannerModel *)model
//{
//    NSString *urlStr = [NSString stringWithFormat:@"%@getHomeMarketGoods?reqtype=02&city_code=%@&bid=%@",DOMAIN_NAME,model.city_code,model.bid];
//    CZRequestModel *request = [[CZRequestModel alloc] initWithUrlStr:urlStr jsonStr:nil uploadImage:nil];
//    
//    return request;
//}

@end
