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
#import "JSONKit.h"
#import "HBCategoryInfo.h"

@implementation HBTools

+(NSArray *)getCategoryArray
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"category" ofType:@"json"]];
    NSDictionary *requestDic = [data objectFromJSONData];
    NSArray *array = [HBCategoryInfo createModelArrayByDic:requestDic];
    return array;
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

+ (void)showRootController:(BOOL)animated dataType:(dataType) _dataType andCategory:(HBCategoryInfo *)_category
{
    [[self getCenterVC] reloadDataType:_dataType AndCategory:_category];
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

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 - 8 characters
    if ([cString length] < 6) return nil;
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6) return nil;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
