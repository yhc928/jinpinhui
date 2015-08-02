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

- (CZRequestModel *)publishActionParameters:(NSDictionary *)parameters
                                uploadImage:(UIImage *)uploadImage
{
    NSString *urlStr = [NSString stringWithFormat:@"http://yupala.com/bin_cmd/uptest2.asp?id=123123"];
    CZRequestModel *request = [[CZRequestModel alloc] initWithUrlStr:urlStr parameters:parameters uploadImage:uploadImage];
    
    return request;
}

@end
