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

@import GoogleMobileAds;


@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray * dataArray;
    
    AppDelegate * appDel;
    
    GADBannerView * _bannerView;
}
@property (weak, nonatomic) IBOutlet UITableView *tabView;

@end

@implementation FirstViewController

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
        GifViewController * vc =  [[GifViewController alloc]initWithNibName:nil bundle:nil];
        vc.strUrl = info.src;
        [self.navigationController pushViewController:vc animated:YES];
    }
   //
    
    
    
}





@end
