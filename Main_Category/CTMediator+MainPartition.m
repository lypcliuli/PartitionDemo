//
//  CTMediator+MainPartition.m
//  PartitionDemo
//
//  Created by LiuLi on 2018/12/10.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "CTMediator+MainPartition.h"

@implementation CTMediator (MainPartition)

- (UIViewController *)MainPartition_mainPartitionViewController {
    
    //    return [[MainPartitionViewController alloc] init];
    return [self performTarget:@"MainPartition" action:@"viewController" params:nil shouldCacheTarget:NO];
}

@end
