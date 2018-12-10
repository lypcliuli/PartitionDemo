//
//  PartitionTabBarController.m
//  PartitionDemo
//
//  Created by LiuLi on 2018/11/29.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "PartitionTabBarController.h"
#import "PartitionNaviGationController.h"
#import "LSDUtils.h"

#import "TempViewController.h"
#import "CTMediator+MainPartition.h"
#import "CTMediator+MePartition.h"

@interface PartitionTabBarController ()

@end

@implementation PartitionTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize {
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11 * Rate];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = MainColor;
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11 * Rate];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildVc];
    self.tabBar.backgroundColor = [UIColor blackColor];
}

- (void)setUpChildVc {
    // 原始的方式 直接引入头文件使用
//    MainPartitionViewController *homeVC = [[MainPartitionViewController alloc] init];
    UIViewController *homeVc = [[CTMediator sharedInstance] MainPartition_mainPartitionViewController];
    [self setUpOneChildVcWithVc:homeVc Image:@"tab_btn_home" selectedImage:@"tab_btn_home_pre" title:@"首页"];
    
//    MePartitionViewController *userVC = [[MePartitionViewController alloc] init];
    UIViewController *userVC = [[CTMediator sharedInstance] MePartition_viewControllerWithContentText:@"hello, world!"];
    [self setUpOneChildVcWithVc:userVC Image:@"tab_btn_wode" selectedImage:@"tab_btn_wode_pre" title:@"我的"];
    
    TempViewController *TempVC = [[TempViewController alloc] init];
    [self setUpOneChildVcWithVc:TempVC Image:@"tab_btn_wode" selectedImage:@"tab_btn_wode_pre" title:@"TempVC"];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    
    PartitionNaviGationController *nav = [[PartitionNaviGationController alloc] initWithRootViewController:Vc];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.selectedImage = mySelectedImage;
    Vc.tabBarItem.title = title;
    Vc.navigationItem.title = title;
    
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
