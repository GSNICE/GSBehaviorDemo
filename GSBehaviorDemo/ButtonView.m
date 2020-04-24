//
//  ButtonView.m
//  GSBehaviorDemo
//
//  Created by Gavin on 2020/4/24.
//  Copyright © 2020 GSNICE. All rights reserved.
//

#import "ButtonView.h"

@interface ButtonView ()

@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSArray *arr;

- (IBAction)didClickToDo:(UIButton *)sender;

@end

@implementation ButtonView

- (NSArray *)arr {
    return @[@"1",@"2",@"3",@"4"];
}

- (NSString *)str {
    return @"vc---str";
}

- (IBAction)didClickToDo:(UIButton *)sender {
    
}
@end
