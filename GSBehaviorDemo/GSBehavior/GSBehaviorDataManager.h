//
//  GSBehaviorDataManager.h
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/23.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSBehaviorData.h"

NS_ASSUME_NONNULL_BEGIN

@interface GSBehaviorDataManager : NSObject

+ (instancetype)sharedManager;

- (void)pushGSBehaviorDataWithModel:(GSBehaviorData *)model;

/// 页面停留（pageId：页面 ID；time：事件触发时刻（时间戳））
- (void)pushGSBehaviorDataWithPageId:(NSString *)pageId time:(NSString *)time;
/// 页面停留（pageId：页面 ID；startTime：停留开始时刻（时间戳）；endTime：停留结束时刻（时间戳））
- (void)pushGSBehaviorDataWithPageId:(NSString *)pageId start:(NSString *)startTime end:(NSString *)endTime;

@end

NS_ASSUME_NONNULL_END
