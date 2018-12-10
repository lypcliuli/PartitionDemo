//
//  Target_MainPartition.m
//  PartitionDemo
//
//  Created by LiuLi on 2018/12/10.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "Target_MainPartition.h"
#import "MainPartitionViewController.h"

@implementation Target_MainPartition

- (UIViewController *)Action_viewController:(NSDictionary *)params {
    MainPartitionViewController *viewController = [[MainPartitionViewController alloc] init];
    return viewController;
}

@end
