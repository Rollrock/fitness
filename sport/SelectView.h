//
//  SelectView.h
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-16.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectViewDelegate <NSObject>

-(void)viewClicked:(int)tag;

@end


@interface SelectView : UIView
@property(weak)id<SelectViewDelegate> clickedDelegate;
@end
