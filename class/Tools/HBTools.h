//
//  HBTools.h
//  imageHandbook
//
//  Created by chenzb on 14/11/8.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    categoty_list,
    hot_list,
    collection_list
} dataType;

@interface HBTools : NSObject

//颜色转译
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+(NSArray *)getCategoryArray:(int) _index;
+(NSString *)getCateENameFromArrayByName:(NSString *) _cName;
+(NSDictionary *)getAllCategoryValue;

+ (void)showRootController:(BOOL)animated dataType:(dataType) _dataType andTitle:(NSString *)_title;
+ (void)showRightController:(BOOL)animated;
+ (void)showLeftController:(BOOL)animated;
+ (void)setEnableGesture:(BOOL)isEnable;

+ (void)ShowRightMenuVc:(UIViewController *) _controller;
@end
