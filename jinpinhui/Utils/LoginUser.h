//
//  LoginUser.h
//  jinpinhui
//
//  Created by 于海超 on 15/7/19.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface LoginUser : NSObject
single_interface(LoginUser)
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *realName;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *checks;
@property (strong, nonatomic) NSString *ugold;
@property (strong, nonatomic) NSString *userimage;
@property (strong, nonatomic) NSString *usertrade;
@property (strong, nonatomic) NSString *uservcard;
@property (strong, nonatomic) NSString *loginStatus;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *consignee;
@property (strong, nonatomic) NSString *tel;
@end
