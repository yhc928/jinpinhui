//
//  ColorMacro.h
//  Shequ001
//
//  Created by xiao7 on 15/6/10.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

/**
 *  颜色宏定义
 */
#import <Foundation/Foundation.h>

//自定义颜色
#define UIColorFromRGB(r,g,b) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1])

//自定义颜色
#define UIColorFromRGBA(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])

//商品详情半透黑颜色
#define BLACK_TRAN_COLOR   ([UIColor colorWithWhite:0 alpha:0.6])

//导航栏按钮标题高亮颜色
#define NAV_BTN_HIGH_COLOR ([UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0])

//导航栏通用背景颜色
#define NAV_COLOR          ([UIColor colorWithRed:218/255.0 green:33/255.0  blue:47/255.0  alpha:1.0])

//导航栏精品超市背景颜色
#define NAV_BOU_COLOR      ([UIColor colorWithRed:73/255.0  green:36/255.0  blue:122/255.0 alpha:1.0])

//导航栏品牌街背景颜色
#define NAV_BRA_COLOR      ([UIColor colorWithRed:0/255.0   green:0/255.0   blue:0/255.0   alpha:1.0])

//导航栏麦德龙背景颜色
#define NAV_METRO_COLOR    ([UIColor colorWithRed:4/255.0   green:56/255.0  blue:148/255.0 alpha:1.0])

//layer层的边框颜色
#define LAYER_COLOR        ([UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0])

//视图背景色
#define BACKGROUND_COLOR   ([UIColor colorWithRed:231/255.0 green:232/255.0 blue:234/255.0 alpha:1.0])

//section的背景色
#define SECTION_COLOR      ([UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0])
