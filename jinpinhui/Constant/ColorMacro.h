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
#define UIColorFromRGB(r,g,b) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0       alpha:1])

//layer层的边框颜色
#define LAYER_COLOR           ([UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0])

//视图背景色
#define BACKGROUND_COLOR      ([UIColor colorWithRed:231/255.0 green:232/255.0 blue:234/255.0 alpha:1.0])
