//
//  CZRequestMaker.h
//  Shequ001
//
//  Created by 陈震 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 * 网络请求的接口方法
 */
#import <Foundation/Foundation.h>
@class CZRequestModel;

@interface CZRequestMaker : NSObject

/**
 *  单例
 *
 *  @return CZRequestMaker
 */
+ (instancetype)sharedClient;

/**
 *  获取城市列表
 *
 *  @return CZRequestModel
 */
- (CZRequestModel *)getCityList;

/**
 *  获取城市社区商圈列表
 *
 *  @return CZRequestModel
 */
- (CZRequestModel *)getBusinessCircleList;

/**
 *  轮播图列表
 *
 *  @param market_type 超市类型 -1 表示首页
 *
 *  @return CZRequestModel
 */
- (CZRequestModel *)getBannerListWithMarket_type:(NSString *)market_type;

/**
 *  ⾸⻚页超市商品信息
 *
 *  @return CZRequestModel
 */
- (CZRequestModel *)getHomeMarketGoods;

/**
 *  推荐商户
 *
 *  @return CZRequestModel
 */
- (CZRequestModel *)getRecomdBusinessList;

/**
 *  特价商品
 *
 *  @param market_type 超市类型 -1 表示首页
 *
 *  @return CZRequestModel
 */
- (CZRequestModel *)getBargainGoodsWithMarket_type:(NSString *)market_type;

@end
