//
//  AppDelegate.h
//  imageHandbook
//
//  Created by chenzb on 14-8-4.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  DDMenuController;
@class  HBCenterViewController;
@class  HBRightViewController;
@class  HBLeftViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DDMenuController *mainVC;
@property (strong, nonatomic) HBCenterViewController *centerVC;
@property (strong, nonatomic) HBRightViewController *rightVC;
@property (strong, nonatomic) HBLeftViewController *leftVC;

@end
