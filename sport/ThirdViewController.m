//
//  ThirdViewController.m
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "ThirdViewController.h"
#import "RFRateMe.h"
#import "CommData.h"
#import "AppDelegate.h"
#import "PayMent.h"

#define BUY_STORE   @"buy_store"

@import GoogleMobileAds;

@interface ThirdViewController ()<GADBannerViewDelegate,PayMentDelegate>
{
    AppDelegate * appDel;
    PayMent * payMent;
    
    GADBannerView * _bannerView;

}
- (IBAction)buyClicked;
- (IBAction)restoreBuy;

@property (weak, nonatomic) IBOutlet UIView *bgView1;
@property (weak, nonatomic) IBOutlet UIView *bgView2;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *restoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *app1Btn;
@property (weak, nonatomic) IBOutlet UIButton *app2Btn;
@property (weak, nonatomic) IBOutlet UIButton *app3Btn;
@property (weak, nonatomic) IBOutlet UIButton *app4Btn;
@property (weak, nonatomic) IBOutlet UIButton *app5Btn;


- (IBAction)app1Clicked;
- (IBAction)app2Clicked;
- (IBAction)shareClicked;
- (IBAction)app3Clicked;
- (IBAction)app4Clicked;
- (IBAction)app5Clicked;


@end

@implementation ThirdViewController

-(BOOL)showMe
{
    NSDateComponents * data = [[NSDateComponents alloc]init];
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    [data setCalendar:cal];
    [data setYear:2015];
    [data setMonth:8];
    [data setDay:30];
    
    NSDate * farDate = [cal dateFromComponents:data];
    
    NSDate *now = [NSDate date];
    
    NSTimeInterval farSec = [farDate timeIntervalSince1970];
    NSTimeInterval nowSec = [now timeIntervalSince1970];
    
    
    if( nowSec - farSec >= 0 )
    {
        return YES;
    }
    
    return NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    appDel = [[UIApplication sharedApplication] delegate];
 
    //
    self.title = @"设置";
    
    //
    _bgView1.layer.cornerRadius = 4;
    _bgView1.layer.masksToBounds = YES;
    
    _buyBtn.layer.cornerRadius = 3;
    _buyBtn.layer.masksToBounds = YES;
    
    _restoreBtn.layer.cornerRadius = 3;
    _restoreBtn.layer.masksToBounds = YES;
    
    _shareBtn.layer.cornerRadius = 3;
    _shareBtn.layer.masksToBounds = YES;
    
    //
    _bgView2.layer.cornerRadius = 4;
    _bgView2.layer.masksToBounds = YES;
    
    _app1Btn.layer.cornerRadius = 3;
    _app1Btn.layer.masksToBounds = YES;
    
    _app2Btn.layer.cornerRadius = 3;
    _app2Btn.layer.masksToBounds = YES;
    
    _app3Btn.layer.cornerRadius = 3;
    _app3Btn.layer.masksToBounds = YES;
    
    _app4Btn.layer.cornerRadius = 3;
    _app4Btn.layer.masksToBounds = YES;
    
    _app5Btn.layer.cornerRadius = 3;
    _app5Btn.layer.masksToBounds = YES;
    
    //
    
    if( ![self showMe] )
    {
        _bgView2.hidden = YES;
    }
    
    //
    [self laytouADVView];
    
    //
    payMent = [PayMent new];
    payMent.PayDelegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)app1Clicked
{
}

- (IBAction)app2Clicked
{
}

- (IBAction)shareClicked
{
    [appDel shareWithTextUrl];
}

- (IBAction)app3Clicked {
   
}

- (IBAction)app4Clicked
{
}

- (IBAction)app5Clicked
{
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


///

//底部广告
-(void)laytouADVView
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    CGPoint pt ;
    
    pt = CGPointMake(0, rect.origin.y+rect.size.height-kGADAdSizeSmartBannerPortrait.size.height-6-TAB_HEIGHT-[self.navigationController navigationBar].frame.size.height);
    _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:pt];
    
    
    _bannerView.adUnitID = @"ca-app-pub-3058205099381432/5200566381";//调用你的id
    _bannerView.rootViewController = self;
    _bannerView.delegate = self;
    [_bannerView loadRequest:[GADRequest request]];
    
    [self.view addSubview:_bannerView];
}


#pragma PayMentDelegate
-(NSString*)getProdId
{
    return @"more_video";
}

-(void)buySuccess:(NSDate*)date
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setBool:YES forKey:BUY_STORE];
    [def synchronize];
}

-(BOOL)buyed
{
    BOOL bFlag = NO;
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    bFlag = [def boolForKey:BUY_STORE];
    
    return bFlag;
}

-(void)buyFailed
{
    
}

////////////////////////////////////////////////
- (void)buyClicked
{
    [payMent startBuy];
}

- (void)restoreBuy
{
    [payMent restoreBuy];
}

@end


