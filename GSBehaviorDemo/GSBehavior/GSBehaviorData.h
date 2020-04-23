//
//  GSBehaviorData.h
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/23.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GSBehaviorData : NSObject

@property (nonatomic, strong) NSString *op_type;        // 1：点击事件 2：页面事件 3：IO 操作
@property (nonatomic, strong) NSString *page_code;      // 页面 ID
@property (nonatomic, strong) NSString *event_code;     // 事件 ID
@property (nonatomic, strong) NSDictionary *object_dic; // 内容 ID
@property (nonatomic, strong) NSString *op_time;        // 点击事件操作时间
@property (nonatomic, strong) NSString *start_time;     // 页面事件开始时间
@property (nonatomic, strong) NSString *end_time;       // 页面事件结束时间

- (NSDictionary *)dicValue;

//  获取当前的时间戳
+ (NSString *)getNowTimeTimestamp;

@end


@interface GSBehaviorUpLoadData : NSObject

@property (nonatomic, strong) NSString *app_type;       // App 类型（如发布平台或 Debug版，Release 版）
@property (nonatomic, strong) NSString *app_version;
@property (nonatomic, strong) NSString *os_type;        // 1:苹果iOS 2:Other
@property (nonatomic, strong) NSString *os_version;     // 系统版本
@property (nonatomic, strong) NSString *device_id;      // 设备id
@property (nonatomic, strong) NSString *user_id;        // 用户id
@property (nonatomic, strong) NSString *login_account;  // 用户账号
@property (nonatomic, strong) NSString *screen;         // 屏幕分辨率...
@property (nonatomic, strong) NSMutableArray <GSBehaviorData *>*datas;

- (NSDictionary *)dicValue;

@end

NS_ASSUME_NONNULL_END
