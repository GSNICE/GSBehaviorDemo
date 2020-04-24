//
//  NSObject+GSAspectsHook.m
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/24.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "NSObject+GSAspectsHook.h"
#import <objc/runtime.h>

@implementation NSObject (GSAspectsHook)

+ (NSDictionary *)properties_apsWithObj:(id)obj {
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        const char* char_f =property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        id propertyValue = [obj valueForKey:(NSString *)propertyName];
        
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    
    free(properties);
    
    return props;
}

@end
