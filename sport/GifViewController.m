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


@interface GifViewController ()
{
    UIScrollView * scrView;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray * array = @[@"1_1",@"1_2",@"1_3",@"1_4",@"1_5",@"1_6"];
    
    scrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TAB_HEIGHT)];
    [self.view addSubview:scrView];
    scrView.backgroundColor = [UIColor whiteColor];
    scrView.pagingEnabled = YES;
    
    
    for( int i = 0; i < [array count]; ++ i )
    {
        UIImageView * imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",[array objectAtIndex:i]]]];
        imgView.center = CGPointMake(self.view.frame.size.width/2.0+i*self.view.bounds.size.width, 150);
        [scrView addSubview:imgView];
    }
    
    scrView.contentSize = CGSizeMake(scrView.frame.size.width*[array count], 0);
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    [btn setTitle:@"开始训练" forState:UIControlStateNormal];
    btn.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height - 100);
    btn.backgroundColor = [UIColor brownColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    
    [btn addTarget:self action:@selector(startPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


-(void)startPlay
{
    NSLog(@"startPlay");
    
    PlayViewController * vc = [[PlayViewController alloc]init];
    vc.imgArray = @[@"1_1",@"1_2",@"1_3",@"1_4",@"1_5",@"1_6"];
    [self presentViewController:vc animated:YES completion:nil];
    
    //[self.view.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
