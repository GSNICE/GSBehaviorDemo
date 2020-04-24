//
//  NSObject+GSAspectsHook.m
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/24.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "NSObject+GSAspectsHook.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "GSBehaviorData.h"
#import "Aspects.h"
#import "GSBehaviorDataManager.h"

static NSString * const kBehaviorEvents             = @"BehaviorEvents";
static NSString * const kBehaviorEventSelectorName  = @"BehaviorEventSelectorName"; // 方法名
static NSString * const kBehaviorParameter          = @"BehaviorParameter";         // 参数
static NSString * const kBehaviorEventId            = @"BehaviorEventId";           // 事件 ID
static NSString * const kBehaviorPageId             = @"BehaviorPageId";            // 页面 ID
static NSString * const kBehaviorType               = @"BehaviorType";              // 页面 ID

@implementation NSObject (GSAspectsHook)

+ (void)load {
    __block id observer_DidFinishLaunching = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [NSObject setupBehaviorObj];
        [[NSNotificationCenter defaultCenter] removeObserver:observer_DidFinishLaunching];
    }];
}

#pragma mark - private method
// hook 所有需要打点的对象方法
+ (void)setupBehaviorObj {
    //  使用 Plist 文件方式存储
    NSDictionary *behaviorPlist = [self getBehaviorEvents];
    
    for (NSString *className in behaviorPlist) {
        // 需要 hook 的 Class
        Class class = NSClassFromString(className);
        
        // 对应 Class 需要 hook 的方法名
        NSDictionary *events = behaviorPlist[className];
        
        if (events[kBehaviorEvents]) {
            // 事件数组
            for (NSDictionary *event in events[kBehaviorEvents]) {
                
                // 具体事件方法
                SEL selector = NSSelectorFromString(event[kBehaviorEventSelectorName]);
                
                [class aspect_hookSelector:selector withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
                    
                    // 获取参数
                    NSMutableDictionary *parameterDic = [NSMutableDictionary new];
                    if (event[kBehaviorParameter]) {
                        
                        NSDictionary *dic = [NSObject properties_apsWithObj:[aspectInfo instance]];
                        for (NSString *parameterStr in event[kBehaviorParameter]) {
                            
                            if ([dic valueForKey:parameterStr]) {
                                [parameterDic setValue:[dic valueForKey:parameterStr] forKey:parameterStr];
                            }
                        }
                    }
                    
                    GSBehaviorData * data = [GSBehaviorData new];
                    data.op_time = [GSBehaviorData getNowTimeTimestamp];
                    data.event_code = event[kBehaviorEventId];
                    data.object_dic = parameterDic;
                    data.page_code = event[kBehaviorPageId];
                    data.op_type = event[kBehaviorType];
                    
                    [[GSBehaviorDataManager sharedManager] pushGSBehaviorDataWithModel:data];
                } error:NULL];
                
            }
        }
    }

}

+ (NSDictionary *)getBehaviorEvents {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"GSBehaviorDemo" ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:plistPath];
}

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
