//
//  CZRequestModel.h
//  Shequ001
//
//  Created by 陈震 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 * 网络请求model
 */
#import <Foundation/Foundation.h>

@interface CZRequestModel : NSObject

@property (nonatomic, strong, readonly) NSString     *urlStr;      //url地址
@property (nonatomic, strong, readonly) NSDictionary *parameters;  //post的参数
@property (nonatomic, strong, readonly) UIImage      *uploadImage; //post的图片

/**
 *  创建请求的数据model
 *
 *  @param urlStr      url地址
 *  @param parameters  post的参数
 *  @param uploadImage post的图片
 *
 *  @return CZRequestModel
 */
- (instancetype)initWithUrlStr:(NSString *)urlStr
                    parameters:(NSDictionary *)parameters
                   uploadImage:(UIImage *)uploadImage;

@end
