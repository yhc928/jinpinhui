//
//  CZRequestHelper.h
//  Shequ001
//
//  Created by 陈震 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  网络请求助手类
 */
#import <Foundation/Foundation.h>

@class CZRequestModel;

@protocol CZRequestHelperDelegate;

@interface CZRequestHelper : NSObject

/**
 *  网络请求GET方法
 *
 *  @param request  请求model
 *  @param delegate 代理
 *  @param code     网络请求状态码
 *  @param obj      object
 */
- (void)czGETWithRequest:(CZRequestModel *)request
                delegate:(id<CZRequestHelperDelegate>)delegate
                    code:(NSInteger)code
                  object:(id)obj;

/**
 *  网络请求POST方法
 *
 *  @param request  请求model
 *  @param delegate 代理
 *  @param code     网络请求状态码
 *  @param obj      object
 */
- (void)czPOSTWithRequest:(CZRequestModel *)request
                 delegate:(id<CZRequestHelperDelegate>)delegate
                     code:(NSInteger)code
                   object:(id)obj;

@end

@protocol CZRequestHelperDelegate <NSObject>

/**
 *  网络请求回调的代理方法
 *
 *  @param resultDict 请求返回的数据
 *  @param code       网络请求状态码
 *  @param obj        object
 */
- (void)czRequestForResultDic:(NSDictionary *)resultDic
                         code:(NSInteger)code
                       object:(id)obj;

@end
