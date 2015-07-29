//
//  WelcomeViewController.h
//  test11
//
//  Created by zhuang chaoxiao on 15/7/25.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WelcomeDelegate <NSObject>

-(void)dismissWelcome;

@end

@interface WelcomeViewController : UIViewController

@property(assign) BOOL bShowed;
@property(weak) id<WelcomeDelegate> welcomeDelegate;
@end
