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
#import "FirstTableViewCell.h"

@import GoogleMobileAds;

@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    GADBannerView * _bannerView;
      
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.title = @"计时器";
    
    
    [self laytouADVView];
}

#pragma UITableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"FirstTableViewCell";
    
    FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if( !cell )
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil]lastObject];
    }
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
 
    if( section == 0)
    {
        lab.text = @"成功故事";
    }
    else if( section == 1 )
    {
        lab.text = @"减肥食物";
    }
    else if( section == 2 )
    {
        lab.text = @"减肥策略";
    }
    else
    {
        return nil;
    }
    
    return lab;
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
    
    return;
    
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
