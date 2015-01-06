//
//  HBCategoryInfo.h
//  imageHandbook
//
//  Created by chenzb on 15/1/5.
//  Copyright (c) 2015年 chenzb. All rights reserved.
//

#import "HBBaseModel.h"

@interface HBCategoryInfo : HBBaseModel <NSCoding>

@property(nonatomic,strong) NSString* cName;

@property(nonatomic,strong) NSString* eName;

@property(nonatomic,assign) int       type;

@property(nonatomic,strong) NSString* sourceUrl;

@end
