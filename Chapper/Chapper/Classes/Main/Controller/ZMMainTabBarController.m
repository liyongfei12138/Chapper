//
//  ZMTabBarVC.m
//  Chapper
//
//  Created by liyongfei on 2017/11/2.
//  Copyright © 2017年 liyongfei. All rights reserved.

// **********
// 底部导航栏
// **********

#import "ZMMainTabBarController.h"

#import "ZMHomeViewController.h"
#import "ZMClassifyViewController.h"
#import "ZMDetailViewController.h"
#import "ZMMainNavigationController.h"
#import "ZMHomeNavigationController.h"
#import "ZMProductViewController.h"

@interface ZMMainTabBarController ()

@end

@implementation ZMMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //调用创建tabBar方法
    [self setUpTabBar];
    self.tabBar.backgroundColor = [UIColor whiteColor];
}

//创建tabBar方法
- (void)setUpTabBar{
    //创建主页
    ZMHomeViewController *homepageVC = [[ZMHomeViewController alloc] init];
    //调用创建图片方法
    [self childViewController:homepageVC tabBarImage:[UIImage imageWithRandAsOriImagename:@"button_shouye1"] selImage:[UIImage imageWithRandAsOriImagename:@"button_shouye2"] title:nil];
    
     //调用修改tabBar选中状态颜色方
    [self tabBarWithViewController:homepageVC tabBarText:@"首页" textColor:kSmallRed];

   //创建分类
    ZMClassifyViewController *classifyVC = [[ZMClassifyViewController alloc] init];
    //调用创建图片方法
    [self childViewController:classifyVC tabBarImage:[UIImage imageWithRandAsOriImagename:@"button_fenlei1"] selImage:[UIImage imageWithRandAsOriImagename:@"button_fenlei2"] title:@"分类"];
    //调用修改tabBar选中状态颜色方
    [self tabBarWithViewController:classifyVC tabBarText:@"分类" textColor:kSmallRed];
    
    //创建我的
    ZMDetailViewController *myVC = [[ZMDetailViewController alloc] init];
    //调用创建图片方法
    [self childViewController:myVC tabBarImage:[UIImage imageWithRandAsOriImagename:@"button_wode1"] selImage:[UIImage imageWithRandAsOriImagename:@"button_wode2"] title:@"我的"];
    //调用修改tabBar选中状态颜色方
    [self tabBarWithViewController:myVC tabBarText:@"我的" textColor:kSmallRed];
}

// 修改tabBar选中状态颜色方法
- (void)tabBarWithViewController:(UIViewController *)childVC tabBarText:(NSString *)tabBarText textColor:(UIColor *)color
{
    childVC.tabBarItem.title = tabBarText;
    //修改tabBar字典
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    dict1[NSForegroundColorAttributeName] = color;
    [childVC.tabBarItem setTitleTextAttributes:dict1 forState:UIControlStateSelected];
}

//创建图片方法
- (void)childViewController:(UIViewController *)childVC tabBarImage:(UIImage *)tabBarImage selImage:(UIImage *)selImage title:(NSString *)title
{
    ZMMainNavigationController *nav = [[ZMMainNavigationController alloc] initWithRootViewController: childVC];
//    nav.tabBarItem.title =
    childVC.navigationItem.title = title;
    
    if ([childVC isKindOfClass:[ZMHomeViewController class]]) {
        nav = [[ZMHomeNavigationController alloc] initWithRootViewController:childVC];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    }
    
    [self addChildViewController:nav];
    
    childVC.tabBarItem.image =  tabBarImage;
    
    childVC.tabBarItem.selectedImage = selImage;
    
}

@end
