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

- (CZRequestModel *)getBin_cmdWithParameters:(NSDictionary *)parameters;

/**
 *  上传图片
 *
 *  @param parameters  参数
 *  @param uploadImage 图片
 *
 *  @return CZRequestModel
 */
- (CZRequestModel *)publishActionParameters:(NSDictionary *)parameters
                                uploadImage:(UIImage *)uploadImage URL:(NSString *)url;

@end
