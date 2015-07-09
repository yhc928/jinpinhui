//
//  RegExp.h
//  Shequ001
//
//  Created by 陈震 on 14-7-9.
//  Copyright (c) 2014年 chenzhen. All rights reserved.
//

/**
 * 正则验证
 */
#import <Foundation/Foundation.h>

@interface RegExp : NSObject

/**
 * 功能：账号验证
 */
//+ (BOOL)isAccountVerify:(NSString *)account;

/**
 * 功能：密码验证
 */
+ (BOOL)isPasswordVerify:(NSString *)password;

/**
 * 功能：手机和电话验证
 */
+ (BOOL)isPhoneAndTelVerify:(NSString *)phone;

/**
 * 功能：手机验证
 */
+ (BOOL)isPhoneVerify:(NSString *)phone;

/**
 * 功能：邮箱验证
 */
//+ (BOOL)isEmailVerify:(NSString *)email;

/**
 * 功能：空白字符验证
 */
+ (BOOL)isBlankVerify:(NSString *)blank;

@end
