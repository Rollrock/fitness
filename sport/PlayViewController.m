//
//  PlayViewController.m
//  sport
//
//  Created by zhuang chaoxiao on 15/7/29.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "PlayViewController.h"
#import "SvGifView.h"

@interface PlayViewController ()
{
    SvGifView * gifView;
}
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [self.view addSubview:navView];
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,20,25,25)];
    [backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor lightGrayColor];
    [navView addSubview:backBtn];

    //
    [self layoutGif:@"1_1"];
    //

    //
    UIButton * leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, gifView.frame.origin.y + gifView.frame.size.height + 20, 25,25)];
    [leftBtn addTarget:self action:@selector(leftClicked) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:leftBtn];
    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 40 - 25, gifView.frame.origin.y + gifView.frame.size.height + 20, 25,25)];
    [rightBtn addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:rightBtn];
}

-(void)play
{
    [gifView startGif];
}



-(void)layoutGif:(NSString*)imgName
{
    [gifView removeFromSuperview];
    gifView = nil;
    
    //
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:imgName withExtension:@"gif"];
    gifView = [[SvGifView alloc] initWithCenter:CGPointMake(self.view.bounds.size.width / 2, 130) fileURL:fileUrl];
    gifView.backgroundColor = [UIColor clearColor];
    gifView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:gifView];
    
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(play) userInfo:nil repeats:NO];
}


-(void)backClicked
{
    NSLog(@"backClicked");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)leftClicked
{
    NSLog(@"leftClicked");
    
    [self layoutGif:@"1_2"];
}

-(void)rightClicked
{
    NSLog(@"rightClicked");
    
    [self layoutGif:@"1_3"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
