//
//  CZRequestModel.h
//  Shequ001
//
//  Created by xiao7 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 * 网络请求model
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CZRequestModel : NSObject

@property (nonatomic, readonly) NSString *urlStr;      //url地址
@property (nonatomic, readonly) NSString *jsonStr;     //post的字符串
@property (nonatomic, readonly) UIImage  *uploadImage; //post的图片

/**
 *  创建请求的数据model
 *
 *  @param urlStr      url地址
 *  @param jsonStr     post的字符串
 *  @param uploadImage post的图片
 *
 *  @return self
 */
- (instancetype)initWithUrlStr:(NSString *)urlStr jsonStr:(NSString *)jsonStr uploadImage:(UIImage *)uploadImage;
@end
