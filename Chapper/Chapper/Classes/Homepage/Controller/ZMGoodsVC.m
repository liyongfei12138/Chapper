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

#import <SVProgressHUD.h>
@interface ZMGoodsVC () <UITableViewDelegate, UITableViewDataSource >
// 商品字典
@property (nonatomic, strong) NSDictionary *goodDict;
@end

@implementation ZMGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 初始化
    [self initValue];
    // 解析数据
    [self loadCarouselData];
    // 设置背景
    self.view.backgroundColor = [UIColor whiteColor];
    
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
// 初始化
- (void)initValue
{
    self.goodDict = [NSDictionary dictionary];
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
    headView.lotterArr = _lotterArr;
    headView.todayArr = _todayArr;
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
    static NSString *ID = @"goodsID";
    
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

/******************
 *** 数据解析
 ******************/
#pragma mark - 数据解析
- (void)loadCarouselData
{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSNumber numberWithInt:4] forKey:@"query_type"];
    [parameters setValue:_toolID forKey:@"query_data"];
    
    [ZMHttpTool post:ZMItemUrl params:parameters success:^(id responseObj) {
//        NSLog(@"%@",responseObj);
        self.goodDict = [responseObj valueForKey:@"item"];
//        self.goodArr =
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.goodDict,@"goodDict",nil];
        
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"goods" object:nil userInfo:dict];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"请检查网络"];
//        [SVProgressHUD dismissWithDelay:1];
    }];
}


@end
