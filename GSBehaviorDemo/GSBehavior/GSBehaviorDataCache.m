//
//  GSBehaviorDataCache.m
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/24.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "GSBehaviorDataCache.h"

NSString *const FileName = @"LocalStorage";

@interface GSBehaviorDataCache ()

@property (nonatomic, strong) NSString *storagePath;

@end

@implementation GSBehaviorDataCache

+ (instancetype)sharedManager {
    static GSBehaviorDataCache *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self allocWithZone:NULL] init];
    });
    return sharedManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [GSBehaviorDataCache sharedManager];
}

//- (id)copyWithZone:(nullable NSZone *)zone {
//    return [GSBehaviorDataCache sharedManager];
//}
//
//- (id)mutableCopyWithZone:(nullable NSZone *)zone {
//    return [GSBehaviorDataCache sharedManager];
//}

#pragma mark - 写入（归档）
+ (BOOL)writeWithData:(id)data storageType:(NSString *)type {
    GSBehaviorDataCache *manager = [GSBehaviorDataCache sharedManager];
    NSString *path = [manager.storagePath stringByAppendingString:type];
    NSData *temp = [NSKeyedArchiver archivedDataWithRootObject:data];
    return [NSKeyedArchiver archiveRootObject:temp toFile:path];
}

#pragma mark - 读取（解归档）
+ (id)readWithStorageType:(NSString *)type {
    GSBehaviorDataCache *mamager = [GSBehaviorDataCache sharedManager];
    NSString *path = [mamager.storagePath stringByAppendingPathComponent:type];
    NSData *data = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!data) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

#pragma mark - 移除存储
+ (BOOL)removeDataWithStorageType:(NSString *)type {
    GSBehaviorDataCache *mamager = [GSBehaviorDataCache sharedManager];
    NSString *path = [mamager.storagePath stringByAppendingPathComponent:type];
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

#pragma mark - Getter
- (NSString *)storagePath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:FileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return path;
}

@end
