//
//  RAYTabBarController.m
//  RAYSideslipLikeQQView
//
//  Created by richerpay on 15/6/5.
//  Copyright (c) 2015年 richerpay. All rights reserved.
//

#import "RAYTabBarController.h"
#import "ViewController.h"
#import "RAYContactViewController.h"
#import "RAYDynamicViewController.h"
#import "RAYHomeViewController.h"

@interface RAYTabBarController ()

@end

@implementation RAYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UITabBar *tabBar = self.tabBar;
//    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
//    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
//    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
//    
//    tabBarItem1.title = @"title1";
//    tabBarItem2.title = @"title2";
//    tabBarItem3.title = @"title3";
//    UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"message" image:nil   tag:1];
//    UITabBarItem *contactItem = [[UITabBarItem alloc] initWithTitle:@"contact" image:nil   tag:2];
//    UITabBarItem *dynamicItem = [[UITabBarItem alloc] initWithTitle:@"dynamic" image:nil   tag:3];
//    - (void)setItems:(NSArray *)items animated:(BOOL)animated;
//    [self.tabBar setItems:@[messageItem,contactItem,dynamicItem] animated:YES];
//    self.tabBarItem
    
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
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if ([item.title isEqualToString:@"消息"]) {
        
//        ViewController *vc = (ViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
//                RAYContactViewController *contactViewController = [[RAYContactViewController alloc]init];
//        if ([vc  isMemberOfClass: [RAYContactViewController  class]]) {
//            NSLog(@"");
//        }
        RAYHomeViewController *homeViewController = [[RAYHomeViewController alloc]init];
        UINavigationController *navigationController =[[UINavigationController alloc] initWithRootViewController:homeViewController];

        ViewController *vc = (ViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        
//            [tabBarView addSubview:homeViewController.navigationController.view];
        [vc.mainTabBarController.view addSubview:navigationController.view];
        [vc.mainTabBarController.view bringSubviewToFront:vc.mainTabBarController.tabBar];
    }
    else if ([item.title isEqualToString:@"联系人"]) {
        RAYContactViewController *contactViewController = [[RAYContactViewController alloc]init];
        ViewController *vc = (ViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        [vc.mainTabBarController.view addSubview:contactViewController.view];
        [vc.mainTabBarController.view bringSubviewToFront:vc.mainTabBarController.tabBar];
    }
    else if ([item.title isEqualToString:@"动态"]) {
        RAYDynamicViewController *dynamicViewController = [[RAYDynamicViewController alloc]init];
        ViewController *vc = (ViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        [vc.mainTabBarController.view addSubview:dynamicViewController.view];
        [vc.mainTabBarController.view bringSubviewToFront:vc.mainTabBarController.tabBar];
    }
}

@end
