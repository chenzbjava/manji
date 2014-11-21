//
//  HBTools.m
//  imageHandbook
//
//  Created by chenzb on 14/11/8.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBTools.h"
#import "HBCenterViewController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "HBCollectionViewController.h"
#import "HBLeftViewController.h"

@implementation HBTools

+(NSArray *)getCategoryArray
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"category_array" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return [data objectForKey:@"category"];
}

+(NSString *)getCateENameFromArrayByName:(NSString *) _cName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"category_dic" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSDictionary *dic = [data objectForKey:@"category"];
    return [dic objectForKey:_cName];
}

+(HBCenterViewController*)getCenterVC
{
    return ((AppDelegate*)[[UIApplication sharedApplication] delegate]).centerVC;
}
+(DDMenuController*)getDDMenuVC
{
    return ((AppDelegate*)[[UIApplication sharedApplication] delegate]).mainVC;
}


+ (void)changeRootController:(BOOL)animated
{
    [[self getDDMenuVC] showRootController:animated];
}

+ (void)showRootController:(BOOL)animated dataType:(dataType) _dataType andTitle:(NSString *)_title
{
    [[self getCenterVC] reloadDataType:_dataType AndTitle:_title];
    [[self getDDMenuVC] showRootController:animated];
}



+ (void)showRightController:(BOOL)animated
{
    [[self getDDMenuVC] showRightController:animated];
}
+ (void)showLeftController:(BOOL)animated
{
    [[self getDDMenuVC] showLeftController:animated];
}
+ (void)setEnableGesture:(BOOL)isEnable
{
    [self getDDMenuVC].isAllowLeftAndRight = isEnable;
}


+(void)ShowRightMenuVc:(UIViewController *) _controller;
{
    [[self getDDMenuVC] presentModalViewController:_controller animated:YES];
}

@end
