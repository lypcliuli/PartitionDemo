//
//  AppDelegate.m
//  PartitionDemo
//
//  Created by LiuLi on 2018/11/29.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "AppDelegate.h"
#import "PartitionTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [[PartitionTabBarController alloc] init];
    // 保持打开app后不自动锁屏
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
    NSLog(@"userActivity : %@",userActivity.webpageURL.description);
    return YES;
}

/**
 *ios 9之后被其他app调用走这个
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    NSLog(@"scheme:%@",[url scheme]); //scheme名字
    NSLog(@"query:%@",[url query]);//传递的参数
    NSLog(@"%@",options[UIApplicationOpenURLOptionsSourceApplicationKey]);//调用方app的bundle id
    return YES; // 如果由于某种原因应用程序无法打开，则返回NO
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
