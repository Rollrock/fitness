//
//  SelectView.m
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-16.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if( self )
    {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor lightGrayColor];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    
    self.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    if( [_clickedDelegate respondsToSelector:@selector(viewClicked:)])
    {
        [_clickedDelegate viewClicked:self.tag];
    }
}



@end
