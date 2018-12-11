//
//  Target_Temp.m
//  PartitionDemo
//
//  Created by LiuLi on 2018/12/11.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "Target_Temp.h"
#import "TempViewController.h"

@implementation Target_Temp

- (UIViewController *)Action_viewController:(NSDictionary *)params {
    TempViewController *viewController = [[TempViewController alloc] init];
    return viewController;
}

@end
