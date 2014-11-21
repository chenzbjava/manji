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
#define BASE_URL @"http://image.baidu.com"
//分类图片下载接口(分页和分类名称)
#define PAGE_COUNT 20
#define CATEGORY_IMAGELIST(category,sort,pn) [NSString stringWithFormat:@"/data/imgs?col=美女&tag=%@&sort=%@&tag3=&pn=%@&rn=%d&p=channel&from=1",category,sort, pn,PAGE_COUNT]
#define CATEGORY_HOT(category,category1) [NSString stringWithFormat:@"/detail/info?fr=channel&tag1=美女&tag2=%@&column=美女&tag=%@&ie=utf-8&oe=utf-8&word=1&t=1415973266526",category,category1]

#endif