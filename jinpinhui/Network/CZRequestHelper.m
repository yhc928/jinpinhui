//
//  CZRequestHelper.m
//  Shequ001
//
//  Created by xiao7 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "CZRequestHelper.h"

#import "CZRequestOperationManager.h"
#import "CZRequestModel.h"

@implementation CZRequestHelper

- (void)czGETWithRequest:(CZRequestModel *)request delegate:(id<CZRequestHelperDelegate>)delegate code:(NSInteger)code object:(id)obj
{
    NSLog(@"urlStr = %@",request.urlStr);
    
    CZRequestOperationManager *manager = [CZRequestOperationManager sharedClient];
    
    //设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //网络请求
    [manager GET:request.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //调用系统方法解析json字符串
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:NSJSONReadingAllowFragments
                                                                    error:nil];
        
        //请求成功设置代理
        if ([delegate respondsToSelector:@selector(czRequestForResultDic:code:object:)]) {
            [delegate czRequestForResultDic:resultDic code:code object:obj];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"requestError = %@",error);
        
        //请求失败设置代理
        if ([delegate respondsToSelector:@selector(czRequestForResultDic:code:object:)]) {
            [delegate czRequestForResultDic:nil code:code object:obj];
        }
    }];
}


- (void)czPOSTWithRequest:(CZRequestModel *)request delegate:(id<CZRequestHelperDelegate>)delegate code:(NSInteger)code object:(id)obj
{
    NSLog(@"urlStr = %@",request.urlStr);
    
    CZRequestOperationManager *manager = [CZRequestOperationManager sharedClient];
    
    //设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //网络请求
    [manager POST:request.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //调用系统方法解析json字符串
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:NSJSONReadingAllowFragments
                                                                    error:nil];
        
        //请求成功设置代理
        if ([delegate respondsToSelector:@selector(czRequestForResultDic:code:object:)]) {
            [delegate czRequestForResultDic:resultDic code:code object:obj];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败设置代理
        if ([delegate respondsToSelector:@selector(czRequestForResultDic:code:object:)]) {
            [delegate czRequestForResultDic:nil code:code object:obj];
        }
    }];
}

@end
