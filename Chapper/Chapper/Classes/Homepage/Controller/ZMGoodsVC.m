//
//  ZMGoodsVC.m
//  Chapper
//
//  Created by liyongfei on 2017/11/8.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMGoodsVC.h"
//#import <BHInfiniteScrollView.h>
#import "ZMGoodsHeadView.h"
@interface ZMGoodsVC () <UITableViewDelegate, UITableViewDataSource >
//@property (nonatomic, strong) BHInfiniteScrollView *infinitePageView;
@end

@implementation ZMGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    [self setUpTableView];
    
    [self setBuyButton];
//    [self createTableHeaderView];
    

}
// 隐藏nav 以及设置返回按钮
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn1.frame = CGRectMake(60, 0, 40, 40);
    [backBtn1 setImage:[UIImage imageNamed:@"icon_xq_fanhui"] forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn1 sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
}
// 返回事件
-(void)backBtn
{
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 创建购买按钮
- (void)setBuyButton
{
    CGFloat btnH = 64;
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setBackgroundColor:kSmallRed];
    [buyBtn setTitle:@"领劵并购买" forState:UIControlStateNormal];
    buyBtn.frame =CGRectMake(0, kDeviceHeight - 64, kDeviceWidth, btnH);
    [buyBtn addTarget:self action:@selector(didClickBuyBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
}
- (void)didClickBuyBtn
{
    NSLog(@"你点击了购买按钮");
}

// 创建tableview
- (void)setUpTableView
{
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kDeviceWidth, kDeviceHeight) style:UITableViewStyleGrouped];
    [tableV setBackgroundColor:kSmallGray];
    ZMGoodsHeadView *headView = [[ZMGoodsHeadView alloc] initWithFrame:CGRectMake(0, -64, kDeviceWidth, kDeviceHeight)];
//    [self createTableHeaderView];
//    UIView *headView = [self createTableHeaderView];
    headView.frame = CGRectMake(0, -64, kDeviceWidth, kDeviceHeight);
    
    headView.backgroundColor = [UIColor whiteColor];
    [tableV setTableHeaderView:headView];
    //    self.navigationController.title = @"商品详情";
    
    [self.view addSubview:tableV];
    [tableV setDelegate:self];
    [tableV setDataSource:self];
}
#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.01;
}
@end
