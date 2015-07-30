//
//  LoginUser.m
//  jinpinhui
//
//  Created by 于海超 on 15/7/19.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "LoginUser.h"
#import "NSString+Helper.h"


@implementation LoginUser

single_implementation(LoginUser)

#pragma mark - 私有方法
- (NSString *)loadStringFromDefaultsWithKey:(NSString *)key
{
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    return (str) ? str : @"";
}

- (NSArray *)loadArrayFromDefaultsWithKey:(NSString *)key
{
    NSArray *mainPagePics = [[NSUserDefaults standardUserDefaults] arrayForKey:key];
    return (mainPagePics.count) ? mainPagePics : @[];
}

#pragma mark - getter & setter
//用户图片
- (NSString *)userimage
{
    return [self loadStringFromDefaultsWithKey:UserImageKey];
}

- (void)setuserimage:(NSString *)userimage
{
    [userimage saveToNSDefaultsWithKey:UserImageKey];
}
//昵称
- (NSString *)realName
{
    return [self loadStringFromDefaultsWithKey:RealNameKey];
}

-(void)setRealName:(NSString *)realName
{
    [realName saveToNSDefaultsWithKey:RealNameKey];
}
//账号
- (NSString *)userName
{
    return [self loadStringFromDefaultsWithKey:UserNameKey];
}

- (void)setUserName:(NSString *)userName
{
    [userName saveToNSDefaultsWithKey:UserNameKey];
}
//密码
- (NSString *)password
{
    return [self loadStringFromDefaultsWithKey:PasswordKey];
}

- (void)setPassword:(NSString *)password
{
    [password saveToNSDefaultsWithKey:PasswordKey];
}
- (NSString *)loginStatus
{
    return [self loadStringFromDefaultsWithKey:LOGINSTATUS];
}

- (void)setLoginStatus:(NSString *)loginStatus
{
    [loginStatus saveToNSDefaultsWithKey:LOGINSTATUS];
}



@end
