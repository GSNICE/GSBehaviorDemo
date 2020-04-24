//
//  GSBehaviorData.m
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/23.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "GSBehaviorData.h"
#import <objc/runtime.h>

@implementation GSBehaviorData

- (NSDictionary *)dicValue {
    return [self properties_aps];
}

- (NSDictionary *)properties_aps {
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    //  获取所有的属性列表
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        //  获取属性名称
        const char* char_f = property_getName(property);
        //  转换属性名称类型
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        //  取出相应属性的值
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        //  将属性值设置到字典中
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
        
    }
    //  使用 copy 出来的对象需要用 free 释放掉
    free(properties);
    
    return props;
}

#pragma mark - 获取当前的时间戳
+ (NSString *)getNowTimeTimestamp {

    NSDate *dateNow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)([dateNow timeIntervalSince1970] * 1000)];
    return timeSp;
}

@end

@implementation GSBehaviorUpLoadData

- (NSDictionary *)dicValue {
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:[self properties_aps]];
    NSMutableArray * arr = [NSMutableArray new];
    for (GSBehaviorData* data in self.datas) {
        [arr addObject:[data dicValue]];
    }
    
    [dic setValue:arr forKey:@"datas"];
    
    return dic;
}

- (NSDictionary *)properties_aps {
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    //  获取所有的属性列表
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i<outCount; i++) {
        
        objc_property_t property = properties[i];
        //  获取属性名称
        const char* char_f = property_getName(property);
        //  转换属性名称类型
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        //  取出相应属性的值
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        //  将属性值设置到字典中
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
        
    }
    //  使用 copy 出来的对象需要用 free 释放掉
    free(properties);
    
    return props;
}

@end
