//
//  CTMediator+MePartition.m
//  PartitionDemo
//
//  Created by LiuLi on 2018/12/10.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "CTMediator+MePartition.h"

@implementation CTMediator (MePartition)

- (UIViewController *)MePartition_viewControllerWithContentText:(NSString *)contentText {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"contentText"] = contentText;
    return [self performTarget:@"MePartition" action:@"viewController" params:params shouldCacheTarget:NO];
}

@end
