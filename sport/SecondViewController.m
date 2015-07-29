//
//  SecondViewController.m
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "StructInfo.h"
#import "CommData.h"

@import GoogleMobileAds;

@interface SecondViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,AVAudioPlayerDelegate>
{
    
    GADBannerView * _bannerView;
    
    NSMutableArray * hourArray;
    NSMutableArray * minArray;
    NSMutableArray * toneArray;
    
    NSInteger seconds;
    NSTimer * downTimer;
    
    AVAudioPlayer * audPlay;
    
    AVAudioSession * session;
    
}
@property (weak, nonatomic) IBOutlet UIPickerView *hourPicker;

@property (weak, nonatomic) IBOutlet UIPickerView *minPicker;

@property (weak, nonatomic) IBOutlet UILabel *startLab;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"计时器";
    
    
    [self laytouADVView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//底部广告
-(void)laytouADVView
{
    AppDelegate * appDel;
    appDel = [[UIApplication sharedApplication] delegate];
   
    //
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    CGPoint pt ;
    
    pt = CGPointMake(0, rect.origin.y+rect.size.height-kGADAdSizeSmartBannerPortrait.size.height-5-TAB_HEIGHT - [self.navigationController navigationBar].frame.size.height);
    _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:pt];
    
    
    _bannerView.adUnitID = @"ca-app-pub-3058205099381432/7586204749";//调用你的id
    _bannerView.rootViewController = self;
    [_bannerView loadRequest:[GADRequest request]];
    
    //_bannerView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_bannerView];
}

@end
