//
//  CZRequestOperationManager.m
//  Shequ001
//
//  Created by xiao7 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "CZRequestOperationManager.h"

@implementation CZRequestOperationManager

//网络操作对象单例
+ (instancetype)sharedClient {
    static CZRequestOperationManager *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [CZRequestOperationManager manager];
    });
    
    return _sharedClient;
}

@end
