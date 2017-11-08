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
/*
//- (UIView *)createTableHeaderView
//{
//      CGFloat height =  kDeviceWidth * 1.5 + 130;
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, height)];
//    [headerView setBackgroundColor:[UIColor whiteColor]];
//    
//    
////    NSArray* arr = [[NSArray alloc]initWithObjects:[_dataDic objectForKey:@"itemImage"], nil];
//    NSArray* arr = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"button_wd_morentx"],nil];
//    _infinitePageView = [BHInfiniteScrollView infiniteScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth) Delegate:self ImagesArray:arr];
//    //    _infinitePageView.isToolInfor = YES;
////    _infinitePageView.pageControl.dotSize = 10;
//    //    _infinitePageView.pageControlAlignmentOffset = CGSizeMake(0, 10);
//    _infinitePageView.autoScrollToNextPage = NO;
//    _infinitePageView.scrollTimeInterval = 0;
//    _infinitePageView.delegate = self;
//    
//    [headerView addSubview:_infinitePageView];
//    
//    UILabel* nameLabel = [[UILabel alloc]init];
//    nameLabel.width = kDeviceWidth - 20;
//    nameLabel.centerX = kDeviceWidth * 0.5;
//    nameLabel.height = 50;
//    nameLabel.y = kCICLYHEIGHT + 3;
//    nameLabel.numberOfLines = 2;
////    nameLabel.text = [_dataDic objectForKey:@"itemName"];
//    nameLabel.text = @"这是测试的lable";
//    [headerView addSubview:nameLabel];
//    
//    UILabel* beforLabel = [[UILabel alloc]init];
////    [beforLabel setText:[NSString stringWithFormat:@"¥%@",[_dataDic objectForKey:@"price"]]];
//    [beforLabel setText:[NSString stringWithFormat:@"¥%@",@"测试123"]];
//    [beforLabel setFont:[UIFont systemFontOfSize:20]];
//    [beforLabel sizeToFit];
//    beforLabel.x = 10;
//    beforLabel.centerY = kCICLYHEIGHT + 70;
//    [headerView addSubview:beforLabel];
//    
//    UILabel* afterInfor = [[UILabel alloc]init];
//    [afterInfor setText:@"实际券后价"];
//    [afterInfor setFont:[UIFont systemFontOfSize:16]];
//    [afterInfor sizeToFit];
//    [afterInfor setTextColor:[UIColor lightGrayColor]];
//    afterInfor.x = beforLabel.x + beforLabel.width + 20;
//    afterInfor.centerY = kCICLYHEIGHT + 70;
//    [headerView addSubview:afterInfor];
//    
//    
//    UILabel* afterLabel = [[UILabel alloc]init];
////    [afterLabel setText:[NSString stringWithFormat:@"¥%@",[_dataDic objectForKey:@"finalPrice"]]];
//    [afterLabel setText:[NSString stringWithFormat:@"¥%@",@"123"]];
//    [afterLabel setFont:[UIFont systemFontOfSize:20]];
//    [afterLabel sizeToFit];
//    [afterLabel setTextColor:kSmallRed];
//    afterLabel.x = afterInfor.x + afterInfor.width + 5;
//    afterLabel.centerY = kCICLYHEIGHT + 70;
//    [headerView addSubview:afterLabel];
//    
//    UILabel* personLabel = [[UILabel alloc]init];
////    [personLabel setText:[NSString stringWithFormat:@"月销%d件",[[_dataDic objectForKey:@"sellAmount"] intValue]]];
//    [personLabel setText:[NSString stringWithFormat:@"月销%@件",@"测试10"]];
//    [personLabel setFont:[UIFont systemFontOfSize:16]];
//    [personLabel sizeToFit];
//    [personLabel setTextColor:[UIColor lightGrayColor]];
//    personLabel.x = kDeviceWidth - 10 - personLabel.width;
//    personLabel.centerY = kCICLYHEIGHT + 70;
//    [headerView addSubview:personLabel];
//    
//    UIView* colorView = [[UIView alloc]initWithFrame:CGRectMake(0, kDeviceWidth + 90, kDeviceWidth, kDeviceWidth * 0.5  + 5)];
//    [colorView setBackgroundColor:kSmallGray];
//    [headerView addSubview:colorView];
//    
//    UIImageView* iamge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xq_goumaixuzhi"]];
//    iamge.width = kDeviceWidth;
//    iamge.height = kDeviceWidth * 0.5;
//    iamge.x =  0 ;
//    iamge.y = 5;
//    [colorView addSubview:iamge];
    
//    return headerView;
//}
*/


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
