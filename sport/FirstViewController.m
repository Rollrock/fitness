//
//  FirstViewController.m
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//
#import "SVProgressHUD.h"
#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "StructInfo.h"
#import "AppDelegate.h"
#import "RFRateMe.h"
#import "JSONKit.h"
#import "WebViewController.h"
#import "GifViewController.h"
#import "PayMent.h"

@import GoogleMobileAds;


#define BUY_STORE   @"buy_store"

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,PayMentDelegate,UIAlertViewDelegate>
{
    NSMutableArray * dataArray;
    
    AppDelegate * appDel;
    
    GADBannerView * _bannerView;
    
    PayMent * payMent;
}
@property (weak, nonatomic) IBOutlet UITableView *tabView;

@end

@implementation FirstViewController


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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appDel = [[UIApplication sharedApplication] delegate];
    
    //
    [self laytouADVView];
    //
    self.title = @"肌肉训练";
    
    //
    [self initData];
    
    //
    payMent = [PayMent new];
    payMent.PayDelegate = self;

}


-(void)initData
{
    
    dataArray = [NSMutableArray new];
    
    NSString * txtPath = [[NSBundle mainBundle] pathForResource:@"newslist" ofType:@"txt"];
    NSString * strBody = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
    
    NSArray * array = [strBody objectFromJSONString];
    
    for( NSDictionary * dict in array )
    {
        if( [dict isKindOfClass:[NSDictionary class]] )
        {
            NSInfo * info = [NSInfo new];
            
            [info fromDict:dict];
            
            [dataArray addObject:info];
        }
    }
    
    
    [self.tabView reloadData];
    
}

//底部广告
-(void)laytouADVView
{
    //
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    CGPoint pt ;
    
    pt = CGPointMake(0, rect.origin.y+rect.size.height-kGADAdSizeSmartBannerPortrait.size.height-5-TAB_HEIGHT - [self.navigationController navigationBar].frame.size.height);
    _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:pt];
    
    _bannerView.adUnitID = @"ca-app-pub-3058205099381432/7586204749";//调用你的id
    _bannerView.rootViewController = self;
    [_bannerView loadRequest:[GADRequest request]];
    
    [self.view addSubview:_bannerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"FirstTableViewCell";
    
    FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if( !cell )
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell freshCell:[dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInfo* info = [dataArray objectAtIndex:indexPath.row];
    
    if( info.type == NS_TYPE_WEB)
    {
        WebViewController * vc = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
        vc.strUrl = info.src;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if( info.type == NS_TYPE_GIF )
    {
        if( [self buyed] )
        {
            GifViewController * vc =  [[GifViewController alloc]initWithNibName:nil bundle:nil];
            vc.strUrl = info.src;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            if( indexPath.row >= 1 )
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"需要购买才能观看更多健身动画(18元)" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:@"不了", nil];
                
                [alert show];
            }
            else
            {
                GifViewController * vc =  [[GifViewController alloc]initWithNibName:nil bundle:nil];
                vc.strUrl = info.src;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }
    }
   //
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex == 0 )
    {
        [self buyClicked];
    }
}


@end
