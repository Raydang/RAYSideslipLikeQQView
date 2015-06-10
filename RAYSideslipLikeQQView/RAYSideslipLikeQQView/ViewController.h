//
//  ViewController.h
//  RAYSideslipLikeQQView
//
//  Created by richerpay on 15/6/4.
//  Copyright (c) 2015年 richerpay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAYTabBarController.h"
#import "RAYHomeViewController.h"


@interface ViewController : UIViewController

@property (nonatomic, strong) RAYTabBarController *mainTabBarController;
@property (nonatomic, strong) RAYHomeViewController *homeViewController;

- (void) showHome;
@end

