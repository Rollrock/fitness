//
//  StructInfo.h
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

//news list
@interface NSInfo : NSObject   //<NSCoding>

@property(strong) NSString * title;
@property(strong) NSString * imgName;
@property(strong) NSString * desc;
@property(assign) NSInteger type;
-(void)fromDict:(NSDictionary*)dict;

@end


///////////////////////////////////////////////////

@interface StructInfo : NSObject

@end
