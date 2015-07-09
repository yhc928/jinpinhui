//
//  RegExp.m
//  Shequ001
//
//  Created by 陈震 on 14-7-9.
//  Copyright (c) 2014年 chenzhen. All rights reserved.
//

#import "RegExp.h"

@implementation RegExp

//账号验证
+ (BOOL)isAccountVerify:(NSString *)account
{
    NSString * patternString = @"^([a-zA-Z0-9_.\u4e00-\u9fa5]{6,20})+$";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", patternString];
    BOOL ret = [regextest evaluateWithObject:account];
    return ret;
}

//密码验证
+ (BOOL)isPasswordVerify:(NSString*)password
{
    NSString * patternString = @"^([a-zA-Z0-9_-`~!@#$%^&*()+\\|\\\\=,./?><\\{\\}\\[\\]]{6,20})+$";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", patternString];
    BOOL ret = [regextest evaluateWithObject:password];
    return ret;
}

//手机和电话验证
+ (BOOL)isPhoneAndTelVerify:(NSString*)phone
{
    NSString * patternString = @"^(1\\d{10})|([1-9]\\d{6,7})$";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", patternString];
    BOOL ret = [regextest evaluateWithObject:phone];
    return ret;
}

//手机验证
+ (BOOL)isPhoneVerify:(NSString*)phone
{
    NSString * patternString = @"^1\\d{10}$";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", patternString];
    BOOL ret = [regextest evaluateWithObject:phone];
    return ret;
}

//邮箱验证
+ (BOOL)isEmailVerify:(NSString *)email
{
    NSString *patternString = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", patternString];
    BOOL ret = [regextest evaluateWithObject:email];
    return ret;
}

//空白字符验证
+ (BOOL)isBlankVerify:(NSString *)blank
{
    NSString *patternString = @"^\\s*$";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", patternString];
    BOOL ret = [regextest evaluateWithObject:blank];
    return ret;
}

@end
