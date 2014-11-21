//
//  AppDelegate.m
//  imageHandbook
//
//  Created by chenzb on 14-8-4.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"

#import "DDMenuController.h"
#import "HBLeftViewController.h"
#import "HBCenterViewController.h"
#import "HBRightViewController.h"

#import "AFHTTPRequestOperationLogger.h"
#import "UMFeedback.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self createPrincipalVC];
    
    
    [self.window makeKeyAndVisible];
    
    //AFNetWork日志
    [[AFHTTPRequestOperationLogger sharedLogger] startLogging];
    [[AFHTTPRequestOperationLogger sharedLogger] setLevel:AFLoggerLevelDebug];
    //友盟意见反馈
    [UMFeedback setAppkey:@"5468676ffd98c51c6c0030e0"];
    return YES;
}
/**
 *  创建主要的视图控制器
 */
-(void)createPrincipalVC
{
    _mainVC = [[DDMenuController alloc] init];
    
    _leftVC = [[HBLeftViewController alloc]init];
    _centerVC = [[HBCenterViewController alloc]init];
    _rightVC = [[HBRightViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:_centerVC];
    nav.navigationBar.hidden = YES;
    _mainVC.leftViewController = _leftVC;
    _mainVC.rootViewController = nav;
    _mainVC.rightViewController = _rightVC;
    self.window.rootViewController = _mainVC;}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
