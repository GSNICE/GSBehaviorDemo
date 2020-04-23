//
//  UIViewController+GSHook.m
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/23.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "UIViewController+GSHook.h"
#import "GSHook.h"
#import "GSBehaviorDataManager.h"
#import "GSBehaviorData.h"

@implementation UIViewController (GSHook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector_Appear = @selector(viewWillAppear:);
        SEL swizzledSelector_Appear = @selector(gs_viewWillAppear:);
        
        [GSHook swizzlingInClass:[self class] originalSelector:originalSelector_Appear swizzledSelector:swizzledSelector_Appear];
        
        SEL originalSelector_Disappear = @selector(viewWillDisappear:);
        SEL swizzledSelector_Disappear = @selector(gs_viewWillDisappear:);
        
        [GSHook swizzlingInClass:[self class] originalSelector:originalSelector_Disappear swizzledSelector:swizzledSelector_Disappear];
    });
}

- (void)gs_viewWillAppear:(BOOL)animated {
    [[GSBehaviorDataManager sharedManager] pushGSBehaviorDataWithPageId:NSStringFromClass([self class]) time:[GSBehaviorData getNowTimeTimestamp]];
    
    [self gs_viewWillAppear:animated];
}

- (void)gs_viewWillDisappear:(BOOL)animated {
    [[GSBehaviorDataManager sharedManager] pushGSBehaviorDataWithPageId:NSStringFromClass([self class]) time:[GSBehaviorData getNowTimeTimestamp]];
    [self gs_viewWillDisappear:animated];
}
@end
