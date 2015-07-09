//
//  CZRequestMaker.h
//  Shequ001
//
//  Created by xiao7 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 * 网络请求的接口方法
 */
#import <Foundation/Foundation.h>

@class CZRequestModel;

//#import "ReqBannerModel.h"

@interface CZRequestMaker : NSObject

+ (instancetype)sharedClient;

//3.2.6 轮播图列表
//- (CZRequestModel *)getBannerListWithModel:(ReqBannerModel *)model;
//
////3.2.7 ⾸⻚页超市商品信息
//- (CZRequestModel *)getHomeMarketGoodsWithModel:(ReqBannerModel *)model;

//3.2.8 推荐商户
//- (CZRequestModel *)getRecomdBusinessList;
//
////3.2.11 特价商品
//- (CZRequestModel *)getBargainGoods;

@end
