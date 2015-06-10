//
//  RAYHomeViewController.m
//  RAYSideslipLikeQQView
//
//  Created by richerpay on 15/6/4.
//  Copyright (c) 2015年 richerpay. All rights reserved.
//

#import "RAYHomeViewController.h"

@interface RAYHomeViewController ()



@end

@implementation RAYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息";
    self.view.backgroundColor = [UIColor orangeColor];
    self.panGesture = [[UIPanGestureRecognizer alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
