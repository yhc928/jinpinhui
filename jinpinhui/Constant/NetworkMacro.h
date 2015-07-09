//
//  NetworkMacro.h
//  Shequ001
//
//  Created by xiao7 on 15/6/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  网络请求code码
 */
#import <Foundation/Foundation.h>

#define CITY_CODE                          1001 //城市
#define CIRCLE_CODE                        1002 //商圈

#define CIRCLE_INFO_CODE                   1101 //生活超市首页
#define CATEGORY_CATLIST_CODE              1113 //首页分类
#define CATEGORY_CODE                      1102 //一级菜单
#define CATEGORY_SECOND_CODE               1103 //二级菜单
#define CATEGORY_THIRD_CODE                1104 //三级菜单
#define GALLERY_CODE                       1105 //商品列表、商品搜索
#define GALLERY_NEXT_CODE                  1106 //下一页商品列表
#define PRODUCT_CODE                       1107 //商品详情
#define COMMENT_CODE                       1108 //商品详情评价
#define CART_ADDTOCART_CODE                1109 //加入购物车
#define MEMBER_ADD_FAVORITE_CODE           1110 //加入收藏、删除收藏
#define COMMON_HISTORY_ORDERS_CODE         1111 //历史订单列表
#define ADD_CART_BY_ORDERS_CODE            1112 //整单购买

#define SELLER_CODE                        1201 //精品超市首页
#define BRANDSTREET_CODE                   1301 //品牌街首页
#define SELLER_INFO_CODE                   1302 //麦德龙首页

#define CART_CODE                          1401 //购物车首页
#define CART_UPDATE_CODE                   1402 //更新购物车商品
#define CART_NOCHECK_CODE                  1403 //选中购物车商品
#define CART_REMOVE_CODE                   1404 //删除购物车商品
#define CART_CHECKOUT_CODE                 1405 //购物车结算
#define CART_CHOOSE_ADDDR_CODE             1406 //选择收货地址
#define CART_CHOOSE_SHIPPING_CODE          1407 //选择配送方式
#define COMMON_USE_COUPON_CODE             1408 //使用优惠券
#define COMMON_CREATE_ORDER_CODE           1409 //生成订单
#define ALIPAY_SIGN_CODE                   1410 //支付宝快捷支付签名

#define MEMBER_CODE                        1501 //个人中心首页
#define PASSPORT_POST_LOGIN_CODE           1502 //登录
#define PASSPORT_LOGOUT_CODE               1503 //退出登录
#define PASSPORT_CREATE_CODE               1504 //注册
#define PASSPORT_USERNAME_EXISTS_CODE      1505 //验证用户名
#define MEMBER_ORDERS_CODE                 1506 //我的订单
#define MEMBER_ORDERDETAIL_CODE            1507 //订单详情
#define MEMBER_FAVORITE_CODE               1508 //收藏列表
#define COMMON_RECEIVER_CODE               1509 //收货地址列表
#define COMMON_SAVE_RECEIVER_CODE          1510 //保存收货地址
#define COMMON_DEL_RECEIVER_CODE           1511 //删除收货地址
#define COMMON_REGION_INDEX_CODE           1512 //收货地区商圈
#define COMMON_REGION_CHILDREN_CODE        1513 //收货地区商圈小区名

#define MEMBER_MOBILE_PAGE_CODE            1514 //手机绑定获取手机号
#define MEMBER_MOBILE_CODE_CODE            1515 //手机绑定获取验证码
#define MEMBER_SAVE_MOBILE_BIND_CODE       1516 //手机绑定提交验证码

#define COMMON_FORGET_PWD_CODE             1517 //忘记密码提交用户名
#define COMMON_FORGET_PWD_CODE_CODE        1518 //忘记密码获取验证码
#define COMMON_FORGET_PWD_CODE_VERIFY_CODE 1519 //忘记密码提交验证码
#define COMMON_FORGET_PWD_RESET_CODE       1520 //忘记密码重置密码

#define MEMBER_SAVE_PWD_CODE               1521 //修改密码
#define MEMBER_SAVE_AVATAR_CODE            1522 //头像上传

//JSON
#define V2_INDEX_CITY_CODE                 2001 //城市
#define V2_INDEX_CIRCLE_CODE               2002 //商圈
#define CIRCLE_COORDINATE_INFO_CODE        2003 //经纬度