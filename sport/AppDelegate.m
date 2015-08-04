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
#import "WXApi.h"

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
    //WelcomeViewController * vc = [[WelcomeViewController alloc]initWithNibName:nil bundle:nil];
    
    //if( vc.bShowed )
    {
        [self doInitThings:launchOptions];
    }
    //else
    {
      //  vc.welcomeDelegate = self;
        
      //  self.window.rootViewController = vc;
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
    [MobClick startWithAppkey:@"55bf297d67e58e0fec000289" reportPolicy:BATCH   channelId:@""];
    
    //
    
    [WXApi registerApp:@"wx56599a0020b5efcd"];
    
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

-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication*)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}


-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        //NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
        
        // NSLog(@"strMsg:%@",strMsg);
        
    }
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        NSLog(@"strMsg:%@",strMsg);
        
        
        if( resp.errCode == 0 )
        {
            //发送成功
            
            NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
            //[def setObject:[NSDate dateWithTimeIntervalSinceNow:(60*60*24*7)] forKey:ADV_BUYED];
            [def synchronize];
            
            
            [SVProgressHUD showSuccessWithStatus:@"分享成功，广告将在下次打开软件的时候消除~~"];
            
        }
        else if( resp.errCode == -2 )
        {
            //主动取消
        }
    }
}

-(BOOL)isWeChatValid
{
    if( [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi] )
    {
        return  YES;
    }
    
    return NO;
}

-(void) shareWithTextUrl
{
    if( ![self isWeChatValid ] )
    {
        UIAlertView * alterView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的手机没有安装微信，无法使用此功能~" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alterView show];
        
        return;
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"21天快速减肥，不节食不吃药，真的瘦下来了~~~";
    [message setThumbImage:[UIImage imageNamed:@"res2.png"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"https://itunes.apple.com/us/app/30tian-jian-fei-bu-fan-dan/id1024533470?l=zh&ls=1&mt=8";
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

- (void)shareWithImage
{
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"weixin_share"]];
    
    WXImageObject *ext = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"weixin_share" ofType:@"png"];
    NSLog(@"filepath :%@",filePath);
    ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
    UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}


-(BOOL)showAdv
{    
    return NO;
}
@end
