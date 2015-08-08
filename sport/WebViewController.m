//
//  WebViewController.m
//  sport
//
//  Created by zhuang chaoxiao on 15/7/29.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "WebViewController.h"
#import "BaiduMobAdView.h"


@interface WebViewController ()<BaiduMobAdViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:_strUrl ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    //
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    CGPoint pt = CGPointMake(0, rect.origin.y+rect.size.height-kBaiduAdViewBanner468x60.height-1-[self.navigationController navigationBar].frame.size.height);
 
    
    BaiduMobAdView * _baiduView = [[BaiduMobAdView alloc]init];
    _baiduView.AdType = BaiduMobAdViewTypeBanner;
    _baiduView.frame = CGRectMake(0, pt.y, kBaiduAdViewBanner468x60.width, kBaiduAdViewBanner468x60.height);
    
    _baiduView.delegate = self;
    [self.view addSubview:_baiduView];
    [_baiduView start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)publisherId
{
    return @"bf498248";
}

/**
 *  应用在union.baidu.com上的APPID
 */
- (NSString*) appSpec
{
    return @"bf498248";
}



@end
