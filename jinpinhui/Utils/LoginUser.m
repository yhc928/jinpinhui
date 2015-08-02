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
//状态
- (NSString *)loginStatus
{
    return [self loadStringFromDefaultsWithKey:LOGINSTATUS];
}

- (void)setLoginStatus:(NSString *)loginStatus
{
    [loginStatus saveToNSDefaultsWithKey:LOGINSTATUS];
}
//地址
-(NSString *)address{
    
  return  [self loadStringFromDefaultsWithKey:AddressKey];
}

-(void)setAddress:(NSString *)address{
    
  [address saveToNSDefaultsWithKey:AddressKey];
    
}
//认证
-(NSString *)checks{
     return  [self loadStringFromDefaultsWithKey:ChecksKey];
}

-(void)setChecks:(NSString *)checks{
    
    [checks saveToNSDefaultsWithKey:ChecksKey];
    
}
//金币
-(NSString *)ugold{
    
    return [self loadStringFromDefaultsWithKey:UgoldKey];
}

-(void)setUgold:(NSString *)ugold{
    
    [ugold saveToNSDefaultsWithKey:UgoldKey];
    
}
//行业
-(NSString *)usertrade{
    
    return [self loadStringFromDefaultsWithKey:UsertradeKey];
}

-(void)setUsertrade:(NSString *)usertrade{
    
    [usertrade saveToNSDefaultsWithKey:UsertradeKey];
    
}
//名片
-(NSString *)uservcard{
    
    return [self loadStringFromDefaultsWithKey:UservcardKey];
}

-(void)setUservcard:(NSString *)uservcard{
    
    [uservcard saveToNSDefaultsWithKey:UservcardKey];
    
}
//城市
-(NSString *)city{
    
    return [self loadStringFromDefaultsWithKey:CityKey];
}

-(void)setCity:(NSString *)city{
    
    [city saveToNSDefaultsWithKey:CityKey];
    
}
//收货人
-(NSString *)consignee{
    
    return [self loadStringFromDefaultsWithKey:ConsigneeKey];
}

-(void)setConsignee:(NSString *)consignee{
    
    [consignee saveToNSDefaultsWithKey:ConsigneeKey];
    
}
//收货人电话
-(NSString *)tel{
    
    return [self loadStringFromDefaultsWithKey:TelKey];
}

-(void)setTel:(NSString *)tel{
    
    [tel saveToNSDefaultsWithKey:TelKey];
    
}
@end
