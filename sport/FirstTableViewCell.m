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
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;

@end

@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)freshCell:(NSInfo*)info
{
    
    _imgView.image = [UIImage imageNamed:info.imgName];
    _titleLab.text = info.title;
    _descLab.text = info.desc;
    
}


@end
