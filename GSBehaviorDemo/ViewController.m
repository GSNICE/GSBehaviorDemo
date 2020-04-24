//
//  ViewController.m
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/23.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "ViewController.h"
#import "GSBehaviorData.h"
#import "GSBehaviorDataManager.h"

@interface ViewController ()
- (IBAction)didClickToPush:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //  模拟图片下载
    [self downloadSimulationPictures];
}

#pragma mark - 模拟图片下载
- (void)downloadSimulationPictures {
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         // Do the work in background
         GSBehaviorData * data = [GSBehaviorData new];
         data.op_type = @"3";
         data.page_code = @"ViewController";
         data.event_code = @"upLoadPic";
         data.start_time =[GSBehaviorData getNowTimeTimestamp];
         // 模拟图片下载，耗时 5s
         [NSThread sleepForTimeInterval:5];

         data.end_time = [GSBehaviorData getNowTimeTimestamp];
         
         [[GSBehaviorDataManager sharedManager] pushGSBehaviorDataWithModel:data];
     });
}

- (IBAction)didClickToPush:(UIButton *)sender {
    //  跳转到 NextViewController
}
@end
