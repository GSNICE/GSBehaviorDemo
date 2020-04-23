//
//  GSBehaviorDataManager.m
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/23.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "GSBehaviorDataManager.h"

@interface GSBehaviorDataManager ()

@property (nonatomic, strong) GSBehaviorUpLoadData *data;

@property (nonatomic, strong) NSMutableDictionary *startTimeDic;

@end

@implementation GSBehaviorDataManager

+ (instancetype)sharedManager {
    static GSBehaviorDataManager *sharedInstaller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstaller = [[super allocWithZone:NULL] init];
    });
    return sharedInstaller;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [GSBehaviorDataManager sharedManager];
}

//- (id)copyWithZone:(nullable NSZone *)zone {
//    return [GSBehaviorDataManager sharedManager];
//}
//
//- (id)mutableCopyWithZone:(nullable NSZone *)zone {
//    return [GSBehaviorDataManager sharedManager];
//}

- (void)pushGSBehaviorDataWithModel:(GSBehaviorData *)model {
    
    //  线程锁、保证数据完整性
    @synchronized(self) {
        [self.data.datas addObject:model];
    }
}

- (void)pushGSBehaviorDataWithPageId:(NSString *)pageId time:(NSString *)time {
    if ([self.startTimeDic.allKeys containsObject:pageId]) {
        NSString *start = [self.startTimeDic valueForKey:pageId];
        [self pushGSBehaviorDataWithPageId:pageId start:start end:time];
        [self.startTimeDic removeObjectForKey:pageId];
    } else {
        [self.startTimeDic setValue:time forKey:pageId];
    }
}

- (void)pushGSBehaviorDataWithPageId:(NSString *)pageId start:(NSString *)startTime end:(NSString *)endTime {
    
    GSBehaviorData * data = [GSBehaviorData new];
    data.op_type = @"2";
    data.page_code = pageId;
    data.start_time = startTime;
    data.end_time = endTime;
    [[GSBehaviorDataManager sharedManager] pushGSBehaviorDataWithModel:data];
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[endTime doubleValue]];
    NSTimeInterval seconds = [date2 timeIntervalSinceDate:date];
    NSLog(@"Controller:%@ | 进入:%@ | 离开:%@ | 间隔%0.0f秒",data.page_code,data.start_time,data.end_time,seconds/1000.0f);
}


- (NSMutableDictionary *)startTimeDic {
    if (!_startTimeDic) {
        _startTimeDic = [NSMutableDictionary new];
    }
    return _startTimeDic;
}


@end
