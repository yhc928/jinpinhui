//
//  CZRequestModel.m
//  Shequ001
//
//  Created by 陈震 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "CZRequestModel.h"

@implementation CZRequestModel

- (instancetype)initWithUrlStr:(NSString *)urlStr jsonStr:(NSString *)jsonStr uploadImage:(UIImage *)uploadImage
{
    self = [super init];
    if (self) {
        _urlStr = urlStr;
        _jsonStr = jsonStr;
        _uploadImage = uploadImage;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"url:%@,json:%@,image:%@", _urlStr,_jsonStr,_uploadImage];
}

@end
