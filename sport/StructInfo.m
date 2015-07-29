//
//  StructInfo.m
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "StructInfo.h"
#import "CommData.h"


@implementation AlarmInfo

-(NSString*)getRandId
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    
    NSString * timeStr = [NSString stringWithFormat:@"%lf",time];
    
    NSLog(@"alarmId:%@",timeStr);
    
    return timeStr;
}

-(id)init
{
    self = [super init];
    if( self )
    {
        self.alarmId = [self getRandId];
    }
    
    return self;
}

-(id)initWithCopy:(AlarmInfo*)info
{
    self = [super init];
    
    if( self )
    {
        self.forceWakeUp = info.forceWakeUp;
        self.snooze = info.snooze;
        self.on = info.on;
        self.hour = info.hour;
        self.min = info.min;
        self.repeat = info.repeat;
        self.alarmName = info.alarmName;
        self.soundName = info.soundName;
        self.alarmId = info.alarmId;
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.forceWakeUp forKey:@"forceWakeUp"];
    [aCoder encodeObject:self.snooze forKey:@"snooze"];
    [aCoder encodeObject:self.on forKey:@"on"];
    [aCoder encodeObject:self.hour forKey:@"hour"];
    [aCoder encodeObject:self.min forKey:@"min"];
    [aCoder encodeObject:self.repeat forKey:@"repeat"];
    [aCoder encodeObject:self.alarmName forKey:@"alarmName"];
    [aCoder encodeObject:self.soundName forKey:@"soundName"];
    [aCoder encodeObject:self.alarmId forKey:@"alarmId"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if( self )
    {
        self.forceWakeUp = [aDecoder decodeObjectForKey:@"forceWakeUp"];
        self.alarmId = [aDecoder decodeObjectForKey:@"alarmId"];
        self.snooze = [aDecoder decodeObjectForKey:@"snooze"];
        self.on = [aDecoder decodeObjectForKey:@"on"];
        self.hour = [aDecoder decodeObjectForKey:@"hour"];
        self.min = [aDecoder decodeObjectForKey:@"min"];
        self.repeat = [aDecoder decodeObjectForKey:@"repeat"];
        self.alarmName = [aDecoder decodeObjectForKey:@"alarmName"];
        self.soundName = [aDecoder decodeObjectForKey:@"soundName"];
    }
    
    return self;
}

@end



///////////////////////////////////////////////////

@implementation StructInfo

@end
