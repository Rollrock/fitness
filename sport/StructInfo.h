//
//  StructInfo.h
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlarmInfo : NSObject<NSCoding>
@property(strong) NSNumber * snooze;
@property(strong) NSNumber * on;
@property(strong) NSNumber * hour;
@property(strong) NSNumber * min;
@property(strong) NSNumber * repeat;
@property(strong) NSString * alarmName;
@property(strong) NSString * soundName;
@property(strong) NSString * alarmId;
@property(strong) NSNumber * forceWakeUp;

-(id)initWithCopy:(AlarmInfo*)info;
@end


///////////////////////////////////////////////////

@interface StructInfo : NSObject

@end
