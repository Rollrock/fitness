//
//  WelcomeViewController.m
//  test11
//
//  Created by zhuang chaoxiao on 15/7/25.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()<UIScrollViewDelegate>
{
    NSMutableArray * imgArray;
    
    UIPageControl * pageControl;
}
@end

@implementation WelcomeViewController


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if( self )
    {
        NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
        BOOL bFlag = [def boolForKey:@"WELCOME_SHOWED"];
        
        _bShowed = bFlag;
        
        if( !_bShowed )
        {
            [def setBool:YES forKey:@"WELCOME_SHOWED"];
            [def synchronize];
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //imgArray = @[@"pg_1",@"pg_2",@"pg_3",@"pg_4"];
    
    imgArray = [NSMutableArray new];
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if( screenHeight == 480 || screenHeight == 960 )
    {
        for(int i = 1; i < 5; ++ i )
        {
            NSString * str = [NSString stringWithFormat:@"pg_%d_4",i];
            [imgArray addObject:str];
        }
    }
    else if( screenHeight == 1136 )
    {
        for(int i = 1; i < 5; ++ i )
        {
            NSString * str = [NSString stringWithFormat:@"pg_%d_5",i];
            [imgArray addObject:str];
        }

    }
    else if( screenHeight == 1334 )
    {
        for(int i = 1; i < 5; ++ i )
        {
            NSString * str = [NSString stringWithFormat:@"pg_%d_6",i];
            [imgArray addObject:str];
        }

    }
    else
    {
        for(int i = 1; i < 5; ++ i )
        {
            NSString * str = [NSString stringWithFormat:@"pg_%d_6p",i];
            [imgArray addObject:str];
        }

    }
    
    self.view.backgroundColor= [UIColor whiteColor];
    
    [self layoutSubViews];
}


-(void)layoutSubViews
{
    UIScrollView * scrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    
    scrView.delegate = self;
    
    scrView.pagingEnabled = YES;
    scrView.showsHorizontalScrollIndicator = NO;
    scrView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:scrView];
    
    
    for( int i = 0; i <imgArray.count; ++ i )
    {
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
        imgView.image = [UIImage imageNamed:[imgArray objectAtIndex:i]];
        [scrView addSubview:imgView];
    }
    
    scrView.contentSize = CGSizeMake(imgArray.count * [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, scrView.bounds.size.height - 20, 80, 12)];
    pageControl.numberOfPages = imgArray.count;
    pageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, pageControl.center.y);
    pageControl.backgroundColor= [UIColor lightGrayColor];
    pageControl.layer.cornerRadius = 4;
    pageControl.layer.masksToBounds = YES;
    
    [self.view addSubview:pageControl];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{    
    if( scrollView.contentOffset.x +scrollView.frame.size.width >= scrollView.contentSize.width + 20 )
    {
        if( [_welcomeDelegate respondsToSelector:@selector(dismissWelcome)] )
        {
            [_welcomeDelegate dismissWelcome];
        }
    }
    
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    pageControl.currentPage = index;
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
