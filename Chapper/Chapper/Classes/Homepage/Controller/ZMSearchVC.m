//
//  ZMSearchVC.m
//  Chapper
//
//  Created by liyongfei on 2017/11/8.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMSearchVC.h"

@interface ZMSearchVC ()

@end

@implementation ZMSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackBtn];
}

- (void)setBackBtn
{
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn1.frame = CGRectMake(40, 0, 40, 40);
    [backBtn1 setImage:[UIImage imageNamed:@"icon_xq_fanhui2"] forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn1 sizeToFit];
    backBtn1.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
}

// 设置nav
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_reset];
}
- (void)viewDidAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    UILabel *topView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 64)];
    topView.text = @"搜索结果";
    topView.font = topView.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    [topView setTextAlignment:NSTextAlignmentCenter];
    self.navigationController.navigationBar.topItem.titleView.hidden = NO;
    self.navigationController.navigationBar.topItem.titleView= topView;
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.translucent = NO;  
}

// 返回方法
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
