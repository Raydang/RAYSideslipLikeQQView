//
//  ViewController.m
//  RAYSideslipLikeQQView
//
//  Created by richerpay on 15/6/4.
//  Copyright (c) 2015年 richerpay. All rights reserved.
//

#import "ViewController.h"

#import "RAYLeftViewController.h"

#import "RAYContactViewController.h"
#import "RAYDynamicViewController.h"

static CGFloat FullDistance = 0.78;
static CGFloat Proportion = 0.77;

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UINavigationController *homeNavigationController;
@property (nonatomic, strong) UIView *mainView; //构造主视图。实现UINavigationController.view 和 HomeViewController.view 一起缩放。

@property (nonatomic, strong) RAYLeftViewController *leftViewController;

@property (nonatomic, strong) UIView  *blackCover;

@property (nonatomic)CGFloat  distance;
@property (nonatomic)CGFloat  proportionOfLeftView;
@property (nonatomic)CGFloat  distanceOfLeftView;
@property (nonatomic)CGPoint  centerOfLeftViewAtBeginning;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.distance = 0;
    self.proportionOfLeftView = 1.f;
    self.distanceOfLeftView = 50;

//给主视图设置背景
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"back"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:imageView];

//初始化 leftViewController
    self.leftViewController = [[RAYLeftViewController alloc]init];
    
    if (ScreenWidth > 320) {
        self.proportionOfLeftView = ScreenWidth / 320;
        self.distanceOfLeftView += (ScreenWidth - 320) * FullDistance / 2;
    }
    self.leftViewController.view.center = CGPointMake(self.leftViewController.view.center.x - 50, self.leftViewController.view.center.y);
    self.leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    
    self.centerOfLeftViewAtBeginning = self.leftViewController.view.center;
    
    [self.view addSubview:self.leftViewController.view];
    
//增加黑色遮罩层，实现视差特效
    self.blackCover = [[UIView alloc]initWithFrame: CGRectOffset(self.view.frame, 0, 0) ];
    self.blackCover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.blackCover];
    
//主视图
    self.mainView = [[UIView alloc]initWithFrame:self.view.frame];

    self.homeViewController = [[RAYHomeViewController alloc]init];
    self.homeNavigationController =[[UINavigationController alloc] initWithRootViewController:self.homeViewController];
    
    RAYContactViewController *contactViewController = [[RAYContactViewController alloc]init];
    contactViewController.title = @"联系人";
    RAYDynamicViewController *dynamicViewController = [[RAYDynamicViewController alloc]init];
    dynamicViewController.title = @"动态";
    self.mainTabBarController = [[RAYTabBarController alloc]init];
    self.mainTabBarController.viewControllers = @[self.homeNavigationController, contactViewController, dynamicViewController];
    
    UIView *tabBarView = self.mainTabBarController.view;
    [self.mainView addSubview:tabBarView];
    
    [tabBarView addSubview:self.homeViewController.navigationController.view];
    [tabBarView addSubview:self.homeViewController.view];
    [tabBarView bringSubviewToFront:self.mainTabBarController.tabBar];
    
    [self.view addSubview:self.mainView];
    
// 绑定 UIPanGestureRecognizer
    UIPanGestureRecognizer *panGesture = self.homeViewController.panGesture;
    [panGesture addTarget:self action:@selector(pan:)];
    [self.mainView addGestureRecognizer:panGesture];
    
// 生成单击收起菜单手势
    self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showHome)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pan:(UIPanGestureRecognizer *)recongnizer {
    
    const CGFloat x = [recongnizer translationInView:self.view].x;
    const CGFloat trueDistance = self.distance + x;
    const CGFloat trueProportion = trueDistance / (ScreenWidth *FullDistance);
    
//   如果 UIPanGestureRecongnizer 结束  则激活自动停靠
    if (recongnizer.state == UIGestureRecognizerStateEnded) {
        if (trueDistance > ScreenWidth * (Proportion/3)) {
            [self showLeft];
            
        }
        else if (trueDistance < ScreenWidth * -(Proportion/3)) {
            [self showRight];
        }
        else {
            [self showHome];
        }
        return;
    }
    // 计算缩放比例
    CGFloat proportion = recongnizer.view.frame.origin.x >= 0 ? -1:1;
    proportion *= trueDistance / [UIScreen mainScreen].bounds.size.width;
    proportion *= 1 - Proportion;
    proportion /= FullDistance + Proportion/2 - 0.5;
    proportion += 1;
    if (proportion <= Proportion){//若比例已经达到最小，则不再继续动画
        
        return;
    }
    // 执行视差特效
    self.blackCover.alpha = (proportion - Proportion) / (1 - Proportion);
    
    // 执行平移和缩放动画
    recongnizer.view.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y);
    recongnizer.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    
    // 执行左视图动画
    const CGFloat pro = 0.8 + (self.proportionOfLeftView - 0.8) * trueProportion;
    self.leftViewController.view.center = CGPointMake(self.centerOfLeftViewAtBeginning.x + self.distanceOfLeftView * trueProportion, self.centerOfLeftViewAtBeginning.y - (self.proportionOfLeftView - 1) * self.leftViewController.view.frame.size.height * trueProportion / 2 );
    self.leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pro, pro);
}

- (void) showLeft {
    [self.mainView addGestureRecognizer:self.tapGesture];
    self.distance = self.view.center.x * (FullDistance*2 + Proportion - 1);
    [self doTheAnimate:Proportion showWhat:@"left"];
    [self.homeNavigationController popToRootViewControllerAnimated:YES];
}

- (void) showHome {
    [self.mainView removeGestureRecognizer:self.tapGesture];
    self.distance = 0;
    [self doTheAnimate:1 showWhat:@"home"];
    
}

-(void) showRight  {
    [self.mainView addGestureRecognizer:self.tapGesture];
    self.distance = self.view.center.x * -(FullDistance*2 + Proportion - 1);
    [self doTheAnimate:Proportion showWhat:@"right"];
}

- (void) doTheAnimate:(CGFloat)proportion showWhat:(NSString*)showWhat{

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.mainView.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y);
                         self.mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
                         if ([showWhat isEqualToString:@"left"]){
                             self.leftViewController.view.center = CGPointMake(self.centerOfLeftViewAtBeginning.x + self.distanceOfLeftView, self.leftViewController.view.center.y);
                             self.leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.proportionOfLeftView, self.proportionOfLeftView);
                         }
                         self.blackCover.alpha = ([showWhat isEqualToString: @"home"])? 1 : 0;
                         self.leftViewController.view.alpha = ([showWhat isEqualToString: @"right"]) ? 0 : 1;
                     }
                     completion:nil];
    
}

@end
