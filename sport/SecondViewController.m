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
#import "JSONKit.h"
#import "WebViewController.h"

@import GoogleMobileAds;

@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    GADBannerView * _bannerView;
    
    NSMutableArray * gushiArray;
    NSMutableArray * shiwuArray;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController



-(void)initData
{
    {
        gushiArray = [NSMutableArray new];
        
        NSString * txtPath = [[NSBundle mainBundle] pathForResource:@"gushi" ofType:@"txt"];
        NSString * strBody = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
        
        NSArray * array = [strBody objectFromJSONString];
        
        for( NSDictionary * dict in array )
        {
            if( [dict isKindOfClass:[NSDictionary class]] )
            {
                NSInfo * info = [NSInfo new];
                
                [info fromDict:dict];
                
                [gushiArray addObject:info];
            }
        }
    }
    
    {
        shiwuArray = [NSMutableArray new];
        
        NSString * txtPath = [[NSBundle mainBundle] pathForResource:@"shiwu" ofType:@"txt"];
        NSString * strBody = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
        
        NSArray * array = [strBody objectFromJSONString];
        
        for( NSDictionary * dict in array )
        {
            if( [dict isKindOfClass:[NSDictionary class]] )
            {
                NSInfo * info = [NSInfo new];
                
                [info fromDict:dict];
                
                [shiwuArray addObject:info];
            }
        }
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"减肥事项";
    
    [self initData];
    
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
    
    if( indexPath.section == 0 )
    {
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell freshCell:[gushiArray objectAtIndex:indexPath.row]];
        
    }
    else if(indexPath.section == 1 )
    {
        [cell freshCell:[shiwuArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(  section == 0 )
    {
        return [gushiArray count];
    }
    else if( section == 1 )
    {
        return [shiwuArray count];
    }
    
    return 0;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WebViewController * vc = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    
    switch (indexPath.section) {
        case 0:
        {
            vc.strUrl =((NSInfo*) [gushiArray objectAtIndex:indexPath.row]).src;
        }
            break;
            
            case 1:
        {
            vc.strUrl =((NSInfo*) [shiwuArray objectAtIndex:indexPath.row]).src;
        }
            break;
            
        case 2:
        {
            vc.strUrl =((NSInfo*) [gushiArray objectAtIndex:indexPath.row]).src;
        }
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
