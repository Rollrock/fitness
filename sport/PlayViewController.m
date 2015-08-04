//
//  PlayViewController.m
//  sport
//
//  Created by zhuang chaoxiao on 15/7/29.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "PlayViewController.h"
#import "UIImage+animatedGIF.h"
#import "StructInfo.h"


@interface PlayViewController ()
{
    UIButton * leftBtn;
    UIButton * rightBtn;
    
    UILabel * timeLab;
    NSTimer * timer;
    NSInteger timeCount;
    
    UILabel * titleLab;
    UIImageView * imgView;
}
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    navView.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1];
    [self.view addSubview:navView];
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,20,25,25)];
    [backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    //backBtn.backgroundColor = [UIColor lightGrayColor];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [navView addSubview:backBtn];

    //
    [self layoutGif:[_dataArray objectAtIndex:_curIndex]];
    //

    //
    leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, imgView.frame.origin.y + imgView.frame.size.height + 20, 40,40)];
    [leftBtn addTarget:self action:@selector(leftClicked) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    [self.view addSubview:leftBtn];
    
    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 40 - 40, imgView.frame.origin.y + imgView.frame.size.height + 20, 40,40)];
    [rightBtn addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
    [self.view addSubview:rightBtn];
    
    //
    timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    timeLab.center = CGPointMake(self.view.center.x, rightBtn.frame.origin.y + 50);
    timeLab.text = @"60";
    timeLab.font = [UIFont systemFontOfSize:55];
    timeLab.textColor = [UIColor brownColor];
    [self.view addSubview:timeLab];
}

-(void)play
{
    //
    timeCount = 60;
    [timer invalidate];
    timer = nil;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(downCount) userInfo:nil repeats:YES];
}

-(void)resetTimeLab
{
    [timer invalidate];
    timer = nil;
    
    timeCount = 60;
    
    timeLab.text = [NSString stringWithFormat:@"%d",timeCount];
}

-(void)downCount
{
    -- timeCount;
    
    timeLab.text = [NSString stringWithFormat:@"%d",timeCount];
    
    if( timeCount <= 0 )
    {
        [timer invalidate];
        timer  = nil;
    }
}

-(void)layoutGif:(GifInfo*)gifInfo
{
    if( !titleLab )
    {
        titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, self.view.frame.size.width-10*2, 30)];
        titleLab.font = [UIFont systemFontOfSize:20];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:titleLab];
    }
    
    titleLab.text = gifInfo.title;
    
    //
    CGRect frame = CGRectMake(0, 0, 0, 0);
    frame.size = [UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",gifInfo.imgName]].size;
    
    NSLog(@"frame:%f-%f",frame.size.width,frame.size.height);
    
    [imgView removeFromSuperview];
    imgView = nil;
    
    
    imgView = [[UIImageView alloc]initWithFrame:frame];
    imgView.center = CGPointMake(self.view.center.x,frame.size.height+50);
    [self.view addSubview:imgView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:gifInfo.imgName withExtension:@"gif"];
    imgView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];

    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(play) userInfo:nil repeats:NO];
}


-(void)backClicked
{
    NSLog(@"backClicked");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)leftClicked
{
    NSLog(@"leftClicked");
    
    _curIndex = (_curIndex <= 0 ? 0:(_curIndex-1));
    if( _curIndex == 0 )
    {
        leftBtn.enabled = NO;
    }
    rightBtn.enabled = YES;
    
    [self resetTimeLab];
    
    GifInfo * info= [_dataArray objectAtIndex:_curIndex];
    
    [self layoutGif:info];
}

-(void)rightClicked
{
    NSLog(@"rightClicked");
    
    _curIndex = (_curIndex >= ([_dataArray count]-1) ? ([_dataArray count]-1):(_curIndex+1));
    
    if( _curIndex == [_dataArray count] -1 )
    {
        rightBtn.enabled = NO;
    }
    
    leftBtn.enabled = YES;
    
    [self resetTimeLab];
    
    GifInfo * info = [_dataArray objectAtIndex:_curIndex];
    
    [self layoutGif:info];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
