//
//  CZRequestHelper.m
//  Shequ001
//
//  Created by 陈震 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "CZRequestHelper.h"
#import "CZRequestOperationManager.h"
#import "CZRequestModel.h"

@implementation CZRequestHelper

//get请求
/*
- (void)czGETWithRequest:(CZRequestModel *)request
                delegate:(id<CZRequestHelperDelegate>)delegate
                    code:(NSInteger)code object:(id)obj
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
} */

//post请求
- (void)czPOSTWithRequest:(CZRequestModel *)request
                 delegate:(id<CZRequestHelperDelegate>)delegate
                     code:(NSInteger)code object:(id)obj
{
    NSLog(@"urlStr = %@",request.urlStr);
    
    CZRequestOperationManager *manager = [CZRequestOperationManager sharedClient];
    
    //设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval=30;
    
    //网络请求
    [manager POST:request.urlStr parameters:request.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"responseObject = %@",operation.responseString);
        //调用系统方法解析json字符串
//        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]
//                                                                  options:NSJSONReadingAllowFragments
//                                                                    error:nil];
        
        //请求成功设置代理
        if ([delegate respondsToSelector:@selector(czRequestForResultDic:code:object:)]) {
            [delegate czRequestForResultDic:responseObject code:code object:obj];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
        
        //请求失败设置代理
        if ([delegate respondsToSelector:@selector(czRequestForResultDic:code:object:)]) {
            [delegate czRequestForResultDic:nil code:code object:obj];
        }
    }];
}

- (void)czMultipartPOSTWithRequest:(CZRequestModel *)request
                          delegate:(id<CZRequestHelperDelegate>)delegate
                              code:(NSInteger)code object:(id)obj
{
    NSLog(@"urlStr = %@",request.urlStr);
    
    CZRequestOperationManager *manager = [CZRequestOperationManager sharedClient];
    
    //设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 30;
    
    //网络请求
    [manager POST:request.urlStr parameters:request.parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(request.uploadImage, 1);
        [formData appendPartWithFileData:imageData name:@"picture1" fileName:@"test.jpg" mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        //请求成功设置代理
        if ([delegate respondsToSelector:@selector(czRequestForResultDic:code:object:)]) {
            [delegate czRequestForResultDic:responseObject code:code object:obj];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
        
        //请求失败设置代理
        if ([delegate respondsToSelector:@selector(czRequestForResultDic:code:object:)]) {
            [delegate czRequestForResultDic:nil code:code object:obj];
        }
    }];
}


@end
