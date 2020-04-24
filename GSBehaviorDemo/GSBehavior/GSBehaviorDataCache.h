//
//  GSBehaviorDataCache.h
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/24.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GSBehaviorDataCache : NSObject

+ (instancetype)sharedManager;

// 写入
+ (BOOL)writeWithData:(id)data storageType:(NSString *)type;

// 读取
+ (id)readWithStorageType:(NSString *)type;

// 移除
+ (BOOL)removeDataWithStorageType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
