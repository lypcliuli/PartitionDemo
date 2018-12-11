//
//  Target_MePartition.m
//  PartitionDemo
//
//  Created by LiuLi on 2018/12/10.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "Target_MePartition.h"
#import "MePartitionViewController.h"

@implementation Target_MePartition

- (UIViewController *)Action_viewController:(NSDictionary *)params {
    NSString *contentText = params[@"contentText"];
    NSLog(@"传递的参数是：%@", contentText);
    MePartitionViewController *viewController = [[MePartitionViewController alloc] init];
    return viewController;
}

@end
