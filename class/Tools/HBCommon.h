//
//  HBCommon.h
//  imageHandbook
//
//  Created by chenzb on 14-8-11.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#ifndef imageHandbook_HBCommon_h
#define imageHandbook_HBCommon_h

//版本判断
#define VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//宽高
#define NAVIGATION_BOTTOM (VERSION>=7?64.0:44.0)
#define NAV_VIEWHEIGHT [UIScreen mainScreen].bounds.size.height-NAVIGATION_BOTTOM
#define VIEW_WIDTH [UIScreen mainScreen].bounds.size.width
#define VIEW_HEIGHT [UIScreen mainScreen].bounds.size.height

//全局变量
#define DATA_LIST       @"DATA_LIST"
#define CATEGORY_NAME   @"CATEGORY_NAME"
#define CATEGORY_INDEX  @"CATEGORY_INDEX"

#define COLLECTION_LIST @"COLLECTION_LIST"
//font
#define K_FONT_8                   [UIFont systemFontOfSize:8]
#define K_FONT_10                  [UIFont systemFontOfSize:10]
#define K_FONT_11                  [UIFont systemFontOfSize:11]
#define K_FONT_12                  [UIFont systemFontOfSize:12]
#define K_FONT_13                  [UIFont systemFontOfSize:13]
#define K_FONT_14                  [UIFont systemFontOfSize:14]
#define K_FONT_15                  [UIFont systemFontOfSize:15]
#define K_FONT_16                  [UIFont systemFontOfSize:16]
#define K_FONT_18                  [UIFont systemFontOfSize:18]
#define K_FONT_21                  [UIFont systemFontOfSize:21]
#define K_FONT_BALL                [UIFont systemFontOfSize:16]
//http
#define USED_NEW_INTERFACE @"YES"


#define BASE_URL @"http://image.baidu.com"
//分类图片下载接口(分页和分类名称)
#define PAGE_COUNT 30
#define CHANNEL @"动漫"
#define CATEGORY_IMAGELIST @"/data/imgs"
#endif