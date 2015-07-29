//
//  FirstTableViewCell.m
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "CommData.h"
#import "AppDelegate.h"

@interface FirstTableViewCell ()
{
    AppDelegate * _appDel;
}

@end

@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)freshCell:(AlarmInfo*)info
{
    _appDel = [[UIApplication sharedApplication] delegate];
    
    //
}


@end
