//
//  RAYLeftViewController.m
//  RAYSideslipLikeQQView
//
//  Created by richerpay on 15/6/4.
//  Copyright (c) 2015年 richerpay. All rights reserved.
//

#import "RAYLeftViewController.h"
#import "ViewController.h"
#import "OtherPageViewController.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface RAYLeftViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic)NSArray *titlesDictionary;

@end

@implementation RAYLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titlesDictionary = @[@"开通会员", @"QQ钱包", @"网上营业厅", @"个性装扮", @"我的收藏", @"我的相册", @"我的文件"];
    self.view.frame = CGRectMake(0, 0, 320 * 0.78, ScreenHeight);
//    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(16, 163, 568, 379) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.titlesDictionary[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ViewController *vc = (ViewController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];

    OtherPageViewController *otherPageViewController = [[OtherPageViewController alloc]init];
    otherPageViewController.title = self.titlesDictionary[indexPath.row];
    [vc.homeViewController.navigationController pushViewController:otherPageViewController animated:YES];
    vc.mainTabBarController.tabBar.hidden = YES;
    vc.mainTabBarController.selectedIndex = 0;
    [vc showHome];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

@end
