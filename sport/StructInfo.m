//
//  StructInfo.m
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "StructInfo.h"
#import "CommData.h"


@implementation NSInfo

-(void)fromDict:(NSDictionary*)dict
{
    self.title = dict[@"title"];
    self.imgName = dict[@"imgName"];
    self.desc = dict[@"desc"];
    self.type = [dict[@"type"] intValue];
}

@end



///////////////////////////////////////////////////

@implementation StructInfo

@end
