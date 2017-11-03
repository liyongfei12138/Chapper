//
//  ZMHomepageNavVC.m
//  Chapper
//
//  Created by liyongfei on 2017/11/3.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMHomepageNavVC.h"

@interface ZMHomepageNavVC ()

@end

@implementation ZMHomepageNavVC

+ (void)initialize
{
    if (self == [ZMHomepageNavVC class]) {
        //创建navBar
        UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[ZMHomepageNavVC class]]];
        
        [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    }
}

@end
