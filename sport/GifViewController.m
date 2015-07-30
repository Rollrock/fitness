//
//  GifViewController.m
//  sport
//
//  Created by zhuang chaoxiao on 15/7/29.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "GifViewController.h"
#import "SvGifView.h"
#import "CommData.h"
#import "PlayViewController.h"
#import "JSONKit.h"
#import "StructInfo.h"


@interface GifViewController ()<UIScrollViewDelegate>
{
    UIScrollView * scrView;
    NSInteger curIndex;
    
    NSMutableArray * dataArray;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    
    //
    scrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TAB_HEIGHT)];
    [self.view addSubview:scrView];
    scrView.delegate = self;
    scrView.backgroundColor = [UIColor whiteColor];
    scrView.pagingEnabled = YES;
    
    for( int i = 0; i < [dataArray count]; ++ i )
    {
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10+i*self.view.bounds.size.width, 10, self.view.frame.size.width-10*2, 30)];
        titleLab.text = ((GifInfo*)[dataArray objectAtIndex:i]).title;
        titleLab.textAlignment = NSTextAlignmentCenter;
        [scrView addSubview:titleLab];
        
        UIImageView * imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",((GifInfo*)[dataArray objectAtIndex:i]).imgName]]];
        imgView.center = CGPointMake(self.view.frame.size.width/2.0+i*self.view.bounds.size.width, 150);
        [scrView addSubview:imgView];
    }
    
    scrView.contentSize = CGSizeMake(scrView.frame.size.width*[dataArray count], 0);
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    [btn setTitle:@"开始训练" forState:UIControlStateNormal];
    btn.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height - 100);
    btn.backgroundColor = [UIColor brownColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    
    [btn addTarget:self action:@selector(startPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}



-(void)initData
{
    dataArray = [NSMutableArray new];
    
    //
    NSString * txtPath = [[NSBundle mainBundle] pathForResource:_strUrl ofType:@"txt"];
    NSString * strBody = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
    
    NSArray * array = [strBody objectFromJSONString];
    
    for( NSDictionary *dict in array )
    {
        GifInfo * info = [GifInfo new];
        [info fromDict:dict];
        
        [dataArray addObject:info];
    }
}

-(void)startPlay
{
    NSLog(@"startPlay");
    
    PlayViewController * vc = [[PlayViewController alloc]init];
    vc.dataArray = dataArray;
    vc.curIndex = curIndex;
    [self presentViewController:vc animated:YES completion:nil];
    
    //[self.view.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UIScrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"x:%f y:%f",scrView.contentOffset.x,scrView.contentOffset.y);
    
    curIndex = scrView.contentOffset.x/scrView.frame.size.width;
    
    //NSLog(@"curIndex:%d",curIndex);
}


@end
