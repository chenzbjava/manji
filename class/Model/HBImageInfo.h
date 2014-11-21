//
//  HBImageInfo.h
//  imageHandbook
//
//  Created by chenzb on 14-8-11.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBBaseModel.h"
@interface HBImageInfo : HBBaseModel<NSCoding>

//图片地址
@property(nonatomic,strong)NSString *image_url;
//图片描述
@property(nonatomic,strong)NSString *image_desc;
//宽度
@property(nonatomic,strong)NSString *image_width;
//高度
@property(nonatomic,strong)NSString *image_height;
//是否收藏
@property(nonatomic,assign)BOOL     isCollection;
//收藏时间
@property(nonatomic,strong)NSString *collectionTime;

@property(nonatomic,strong)NSString *image_title;

@property(nonatomic,strong)NSString *image_category;

@property(nonatomic,strong)NSString *image_date;

@end
