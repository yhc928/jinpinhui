//
//  CZRequestOperationManager.h
//  Shequ001
//
//  Created by xiao7 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 * AFHTTPRequestOperationManager的单例
 */
#import "AFHTTPRequestOperationManager.h"

@interface CZRequestOperationManager : AFHTTPRequestOperationManager

/**
 * 网络操作对象的单例
 * 在AFHTTPRequestOperationManager的基础上创建一个全局唯一的单例用来调用网络请求
 */
+ (instancetype)sharedClient;
@end
