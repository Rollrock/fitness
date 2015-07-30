//
//  StructInfo.h
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    NS_TYPE_WEB,//网页加载
    NS_TYPE_GIF,//GIF动画播放
    
    
    NS_TYPE_MAX
}NS_TYPE_ENUM;


@interface GifInfo : NSObject
@property(strong) NSString * title;
@property(strong) NSString * imgName;
-(void)fromDict:(NSDictionary*)dict;
@end

//news list
@interface NSInfo : NSObject   //<NSCoding>

@property(strong) NSString * title;
@property(strong) NSString * imgName;
@property(strong) NSString * desc;
@property(assign) NSInteger type;
@property(strong) NSString * src;
-(void)fromDict:(NSDictionary*)dict;

@end


///////////////////////////////////////////////////

@interface StructInfo : NSObject

@end
