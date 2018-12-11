//
//  CTMediator+Temp.m
//  PartitionDemo
//
//  Created by LiuLi on 2018/12/11.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "CTMediator+Temp.h"

@implementation CTMediator (Temp)

- (UIViewController *)Temp_tempViewController {
    
    //    return [[TempViewController alloc] init];

    return [self performTarget:@"Temp" action:@"viewController" params:nil shouldCacheTarget:NO];
}

@end
