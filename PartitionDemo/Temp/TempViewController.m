//
//  TempViewController.m
//  PartitionDemo
//
//  Created by LiuLi on 2018/12/10.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "TempViewController.h"

@interface TempViewController ()

@end

@implementation TempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 200, 100, 100)];
    [button setBackgroundColor:[UIColor greenColor]];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"跳转到另一个app" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

- (void)clickBtn:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"MainDemo://?userId=123&userName=lypc"] options:@{@"userId":@"1232342"} completionHandler:^(BOOL success) {}];

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
