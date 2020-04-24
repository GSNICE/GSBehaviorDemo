//
//  GSBehaviorDataCache.h
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/24.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *      埋点数据存储管理模块
 */

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const kBehaviorLogData;

@interface GSBehaviorDataCache : NSObject

+ (instancetype)sharedManager;

/// 数据写入
+ (BOOL)writeWithData:(id)data storageType:(NSString *)type;

/// 数据读取
+ (id)readWithStorageType:(NSString *)type;

/// 数据移除
+ (BOOL)removeDataWithStorageType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
