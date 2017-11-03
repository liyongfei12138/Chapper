//
//  ZMHomepageVC.m
//  Chapper
//
//  Created by liyongfei on 2017/11/2.
//  Copyright © 2017年 liyongfei. All rights reserved.
//
// **********
// 主页
// **********
#import "ZMHomepageVC.h"

@interface ZMHomepageVC ()

@end

@implementation ZMHomepageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

// 在页面将要显示时创建nav
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //使用分类更改nav背景
    [self.navigationController.navigationBar lt_setBackgroundColor:kSmallRed];
    
}

@end
