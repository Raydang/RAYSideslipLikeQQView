//
//  OtherPageViewController.m
//  RAYSideslipLikeQQView
//
//  Created by richerpay on 15/6/5.
//  Copyright (c) 2015年 richerpay. All rights reserved.
//

#import "OtherPageViewController.h"
#import "ViewController.h"

@interface OtherPageViewController ()

@end

@implementation OtherPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"< 返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = backButton;
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
- (void) goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    ViewController *vc = (ViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        vc.mainTabBarController.tabBar.hidden = NO;
}

@end
