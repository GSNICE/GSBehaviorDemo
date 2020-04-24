//
//  GSBehaviorDataUpLoader.m
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/24.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSBehaviorDataUpLoader.h"
#import "GSBehaviorDataCache.h"

@implementation GSBehaviorDataUpLoader

+ (void)load {
    //  程序启动、上报记录
    __block id observer_DidFinishLaunching = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        [GSBehaviorDataUpLoader upLoadData];
        [[NSNotificationCenter defaultCenter] removeObserver:observer_DidFinishLaunching];
    }];
}


+ (void)upLoadData {
    id data = [GSBehaviorDataCache readWithStorageType:kBehaviorLogData];
    if (data) {
        //  上报
        NSLog(@"程序启动、上报记录：%@",data);
        [GSBehaviorDataCache removeDataWithStorageType:kBehaviorLogData];
    }
}

@end
