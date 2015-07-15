//
//  CZRequestModel.m
//  Shequ001
//
//  Created by 陈震 on 15/6/5.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "CZRequestModel.h"

@implementation CZRequestModel

- (instancetype)initWithUrlStr:(NSString *)urlStr
                    parameters:(NSDictionary *)parameters
                   uploadImage:(UIImage *)uploadImage
{
    self = [super init];
    if (self) {
        _urlStr = urlStr;
        _parameters = parameters;
        _uploadImage = uploadImage;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"urlStr:%@,parameters:%@,uploadImage:%@",_urlStr,_parameters,_uploadImage];
}

@end
