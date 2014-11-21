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


+(NSArray *)getCategoryArray;
+(NSString *)getCateENameFromArrayByName:(NSString *) _cName;

+ (void)showRootController:(BOOL)animated;
+ (void)showRootController:(BOOL)animated dataType:(dataType) _dataType andTitle:(NSString *)_title;
+ (void)showRightController:(BOOL)animated;
+ (void)showLeftController:(BOOL)animated;
+ (void)setEnableGesture:(BOOL)isEnable;

+ (void)ShowRightMenuVc:(UIViewController *) _controller;
@end
