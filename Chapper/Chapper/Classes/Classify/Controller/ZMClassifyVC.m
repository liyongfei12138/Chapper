//
//  ZMClassifyVC.m
//  Chapper
//
//  Created by liyongfei on 2017/11/2.
//  Copyright © 2017年 liyongfei. All rights reserved.
//
// **********
// 分类
// **********

#import "ZMClassifyVC.h"
#import "ZMLotteryVCViewController.h"
#import <MJCSegmentInterface.h>
#import "ZMSortSegmentView.h"
@interface ZMClassifyVC ()
//@property (strong,nonatomic) MJCSegmentInterface *segement;
@end

@implementation ZMClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   NSArray *titlesArr = @[@"0",@"1",@"2",@"3",@"4",@"5车",@"6",@"7",@"8",@"9"];
    ZMSortSegmentView *sortView = [[ZMSortSegmentView alloc] init];
    sortView.frame = CGRectMake(0,64,self.view.jc_width, self.view.jc_height - 64 - 49);
    [self.view addSubview:sortView];
    
   [sortView intoTitlesArray:titlesArr hostController:self];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [JsonHelper getInstand].treatureViewTag = 0;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    self.navigationController.navigationBar.topItem.rightBarButtonItem = nil;
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分类" style:UIBarButtonItemStylePlain target:self action:nil];
    
}

// 设置Nav
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.topItem.titleView.hidden = NO;
    UILabel *topView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 64)];
    topView.text = @"分类";
    topView.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    [topView setTextAlignment:NSTextAlignmentCenter];
    
    self.navigationController.navigationBar.topItem.titleView= topView;
}


@end
