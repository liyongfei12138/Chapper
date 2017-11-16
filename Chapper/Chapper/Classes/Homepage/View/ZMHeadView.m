//
//  ZMHeadView.m
//  Chapper
//
//  Created by liyongfei on 2017/11/4.
//  Copyright © 2017年 liyongfei. All rights reserved.
//// **********
// tableview head View
// **********

#import "ZMHeadView.h"
#import <BHInfiniteScrollView/BHInfiniteScrollView.h>
//#import "ZMHotHeadView.h"
#import "ZMExcellentViewController.h"
#import <AFNetworking.h>
#import <UIButton+WebCache.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "ZMLotteryViewController.h"
//#import "ZMFAQVC.h"
#import "ZMClassifyViewController.h"
//#import "ZMWebVC.h"
#import "ZMWebViewController.h"
#import "ZMWebViewController.h"
#import "ZMWebNavigationController.h"

@interface ZMHeadView ()<BHInfiniteScrollViewDelegate>
/** 活动按钮数据数组**/
@property (nonatomic, strong) NSMutableArray *acBtnDataArr;
/** 活动按钮数组**/
@property (nonatomic, strong) NSMutableArray *acBtnArr;
/** 轮播图**/
@property (nonatomic, strong) NSMutableArray *infScroImagArr;

@property (nonatomic, strong) BHInfiniteScrollView *infinitePageView;
@property (nonatomic, strong) ZMLotteryViewController *btnVC;

@property (nonatomic, strong) NSMutableArray *infinArr;

@property (nonatomic, strong) ZMLotteryViewController *imageVC;
@end
@implementation ZMHeadView


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 创建轮播图
    UIView *scrollView = [self setUpScrollView];
    //    view.bounds = CGRectMake(0, 60, kDeviceWidth, 200);
    [self addSubview:scrollView];
    
    // 初始化数据
    [self initValue];
    // 初始化数据
//    [self initValue];
//    self.backgroundColor = [UIColor whiteColor];
   
    
    //[[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth * 0.42 + kDeviceWidth * 0.25 * 1.11 + _collectedHeight + 60)];
    self.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceWidth * 0.42 + kDeviceWidth * 0.25 * 1.11 + collectedHeight + 60);
    self.backgroundColor = kSmallGray;
    
    UIView *btnBactView = [[UIView alloc] initWithFrame:CGRectMake(0 , kDeviceWidth * 0.42, kDeviceWidth, kDeviceWidth * 0.25 * 1.11)];
    btnBactView.backgroundColor = kSmallRed;
    btnBactView.backgroundColor = [UIColor whiteColor];
    [self addSubview:btnBactView];
    // 设置Button
    for (int i = 0 ; i < 4; i++)
    {
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kDeviceWidth * 0.25 * i , 0, kDeviceWidth * 0.25 - 1, kDeviceWidth * 0.25 * 1.11);

        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor whiteColor];
//        NSLog(@"%@",_acBtnDataArr[i]);
//        [btn sd_setBackgroundImageWithURL:_acBtnDataArr[i] forState:UIControlStateNormal];
        [btnBactView addSubview:btn];
        [_acBtnArr  addObject:btn];
        // 请求数据
//        [self loadCarouselData];
    }
    
    // 请求数据
    [self loadCarouselData];

}
// 设置轮播图
- (UIView *)setUpScrollView
{
    
    //要异步下载。。。待做优化
    NSArray *urlsArray = [NSArray array];
    CGFloat viewHeight =  kDeviceWidth * 0.42;
    
    BHInfiniteScrollView *infinitePageView = [BHInfiniteScrollView
                                               infiniteScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), viewHeight) Delegate:self ImagesArray:urlsArray];
//    infinitePageView1.titlesArray = titlesArray;
//    infinitePageView1.pageControl.dotSize = 10;
//    [infinitePageView1. setDotSize:10];
    infinitePageView.dotSpacing = 10;
    infinitePageView.pageControlAlignmentOffset = CGSizeMake(0,10);
    infinitePageView.scrollTimeInterval = 4;
    infinitePageView.autoScrollToNextPage = YES;
    infinitePageView.delegate = self;
    [self addSubview:infinitePageView];
    self.infinitePageView = infinitePageView;
    
    return infinitePageView;
}
// 轮播图点击方法
- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index
{
    int type = [[[_infinArr objectAtIndex:index] objectForKey:@"carouselType"] intValue];
    
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn1.frame = CGRectMake(60, 0, 40, 40);
    [backBtn1 setImage:[UIImage imageNamed:@"icon_xq_fanhui2"] forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn1 sizeToFit];
    
    // 类型1
    if (type == 1) {
        ZMExcellentViewController *goodVC = [[ZMExcellentViewController alloc] init];
        goodVC.toolID = [[_infinArr objectAtIndex:index] objectForKey:@"carouselValue"];
    }
    else if (type == 2)
    {
        ZMLotteryViewController *imageVC = [[ZMLotteryViewController alloc] init];
        UINavigationController *navBtn = [[UINavigationController alloc] initWithRootViewController:imageVC];
        [imageVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];
//        [imageVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];[imageVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];
        [imageVC.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        imageVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];

        self.imageVC = imageVC;
        // 添加参数
        NSString *keyWorld = [self.infinArr[index] objectForKey:@"carouselValue"];
        NSString *titleName = [self.infinArr[index] objectForKey:@"carouselName"];
        self.imageVC.navigationItem.title = titleName;
        self.imageVC.keyWorld = keyWorld;
        self.imageVC.poseType = 5;
        [self.owner presentViewController:navBtn animated:YES completion:nil];
    }
    else if (type == 3)
    {
        ZMLotteryViewController *imageVC = [[ZMLotteryViewController alloc] init];
        UINavigationController *navBtn = [[UINavigationController alloc] initWithRootViewController:imageVC];
        [imageVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];
        //        [imageVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];[imageVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];
        [imageVC.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        imageVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
        
        self.imageVC = imageVC;
        // 添加参数
        NSString *keyWorld = [self.infinArr[index] objectForKey:@"carouselValue"];
        NSString *titleName = [self.infinArr[index] objectForKey:@"carouselName"];
        self.imageVC.navigationItem.title = titleName;
        self.imageVC.keyWorld = keyWorld;
        self.imageVC.poseType = 6;
        [self.owner presentViewController:navBtn animated:YES completion:nil];
    }
    else if (type == 4)
    {
        [self.owner.tabBarController setSelectedIndex:1];
        UINavigationController *nav = self.owner.tabBarController.viewControllers[1];
        ZMClassifyViewController *sort = nav.viewControllers[0];
        
        [sort selectedSortID:[[[_infinArr objectAtIndex:index] objectForKey:@"carouselValue"] intValue]];
    }else if (type == 5)
    {
        ZMWebViewController *webVC = [[ZMWebViewController alloc] init];
        UINavigationController *navWeb = [[UINavigationController alloc] initWithRootViewController:webVC];
        [webVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];
        //        [imageVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];[imageVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];
        [webVC.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        webVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
        
//        self.webVC = webVC;
        // 添加参数
        NSString *webUrl = [self.infinArr[index] objectForKey:@"carouselValue"];
        NSString *titleName = [self.infinArr[index] objectForKey:@"carouselName"];
        webVC.navigationItem.title = titleName;
        webVC.webUrl = webUrl;
//        self.webVC.poseType = 6;
        [self.owner presentViewController:navWeb animated:YES completion:nil];
    }
}

// 按钮点击
- (void)clickBtn:(UIButton *)button
{
     NSInteger index = button.tag;
    // 改变返回按钮样式
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn1.frame = CGRectMake(60, 0, 40, 40);
    [backBtn1 setImage:[UIImage imageNamed:@"icon_xq_fanhui2"] forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn1 sizeToFit];
   
    if (index != 3) {
  
        ZMLotteryViewController *btnVC = [[ZMLotteryViewController alloc]init];
        UINavigationController *navBtn = [[UINavigationController alloc] initWithRootViewController:btnVC];
        [btnVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];
//        [btnVC.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        btnVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
        self.btnVC = btnVC;
        [self.owner presentViewController:navBtn animated:YES completion:nil];
    }
   
    // 创建常见问题页面
    ZMWebViewController *faqVC = [[ZMWebViewController alloc] initWithWebView];
    ZMWebNavigationController *nav = [[ZMWebNavigationController alloc] initWithRootViewController:faqVC];
  
//    NSDictionary *dic = [self.acBtnDataArr objectAtIndex:index];
//    int type = [[dic objectForKey:@"carouselType"] intValue];
    
    // 判断 但是毫无拓展性
    switch (index) {
        case 0:
            self.btnVC.poseType = 5;
            self.btnVC.keyWorld = @"10";
            self.btnVC.navigationItem.title = @"9.9包邮";
            break;
        case 1:
            self.btnVC.poseType = 5;
            self.btnVC.keyWorld = @"20";
            self.btnVC.navigationItem.title = @"20封顶";
            break;
        case 2:
            self.btnVC.poseType = 6;
            self.btnVC.keyWorld = @"0";
            self.btnVC.navigationItem.title = @"畅销榜";
            break;
        case 3:
            faqVC.navigationItem.title = @"常见问题";
            faqVC.webUrl = FAQUrl;
//            [faqVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];
//            [faqVC.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//            faqVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
            [self.owner presentViewController:nav animated:YES completion:nil];
            
            break;
        case 4:
            // 预留
            break;
        case 5:
            // 预留
            break;
        default:
            break;
    }
    
}
// 返回按钮
-(void)backBtn
{
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.owner dismissViewControllerAnimated:YES completion:nil];
}
// 初始化
- (void)initValue
{
    self.acBtnDataArr = [NSMutableArray array];
    self.infScroImagArr = [NSMutableArray array];
    self.acBtnArr = [NSMutableArray array];
    self.infinArr = [NSMutableArray array];

}

/******************
 *** 数据解析
 ******************/
#pragma mark - 数据解析
- (void)loadCarouselData
{
    // 初始化数据
//        [self initValue];
    [self.acBtnDataArr removeAllObjects];
     // 请求地址 https://taoboo.kunleen.com/coupon.webapi//api/deploy/carousel
    [ZMHttpTool get:ZMMainUrl params:nil success:^(id responseObj) {
//        NSLog(@"%@",responseObj);
        // 请求按钮数据
        NSMutableArray *btnArr = [[responseObj objectAtIndex:1] objectForKey:@"carousels"];
        for (int i = 0; i < btnArr.count; i ++) {
            NSString *btnUrl = [btnArr[i] objectForKey:@"carouselImage"];
            NSURL *url = [NSURL URLWithString:btnUrl];
            [self.acBtnDataArr addObject:url];

            UIButton *btn = _acBtnArr[i];
            if (btn.tag == i) {
                [btn sd_setBackgroundImageWithURL:self.acBtnDataArr[i] forState:UIControlStateNormal];
                //                }
            }
            
        }
        
        [self.infScroImagArr removeAllObjects];
        // 轮播图数据
        self.infinArr = [[responseObj objectAtIndex:0] objectForKey:@"carousels"];
        
        //添加数组
        for (int i = 0; i < self.infinArr.count; i ++) {
            NSString *infinUrl = [self.infinArr[i] objectForKey:@"carouselImage"];
//            NSURL *url = [NSURL URLWithString:infinUrl];
            [self.infScroImagArr addObject:infinUrl];
        }
        
        [self.infinitePageView setImagesArray:_infScroImagArr];
        
//        [header endRefreshing];

    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
        [SVProgressHUD dismissWithDelay:0.5];
    }];
}

@end
