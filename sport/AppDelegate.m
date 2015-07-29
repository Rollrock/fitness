//
//  AppDelegate.m
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "StructInfo.h"
#import "SVProgressHUD.h"

#import "RFRateMe.h"
#import "MobClick.h"
#import "WelcomeViewController.h"


@interface AppDelegate ()<WelcomeDelegate>
{
    MainViewController * mainVC;
}
@end

@implementation AppDelegate


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"didReceiveLocalNotification");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    
    //
    WelcomeViewController * vc = [[WelcomeViewController alloc]initWithNibName:nil bundle:nil];
    
    if( vc.bShowed )
    {
        [self doInitThings:launchOptions];
    }
    else
    {
        vc.welcomeDelegate = self;
        
        self.window.rootViewController = vc;
    }
    
    
    return YES;
}

//
-(void)dismissWelcome
{
    [self doInitThings:nil];
}

//
-(void)doInitThings:(NSDictionary*)launchOptions
{
    mainVC = [[MainViewController alloc]init];
    
    self.window.rootViewController = mainVC;
 
    //    
    [MobClick startWithAppkey:@"55b06037e0f55a4422004da7" reportPolicy:BATCH   channelId:@""];
    
    //
    
    [RFRateMe showRateAlertAfterTimesOpened:5];

    //
    {
       // self.window.rootViewController = [[NumViewController alloc]initWithNibName:@"NumViewController" bundle:nil];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(BOOL)showAdv
{    
    return NO;
}
@end