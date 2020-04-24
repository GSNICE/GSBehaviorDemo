//
//  NSObject+GSAspectsHook.h
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/24.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GSAspectsHook)

+ (NSDictionary *)properties_apsWithObj:(id)obj;

@end

NS_ASSUME_NONNULL_END
