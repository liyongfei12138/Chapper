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
#import "ZMGoodsVC.h"
#import <AFNetworking.h>
#import <UIButton+WebCache.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
@interface ZMHeadView ()<BHInfiniteScrollViewDelegate>
/** 活动按钮数据数组**/
@property (nonatomic, strong) NSMutableArray *acBtnDataArr;
/** 活动按钮数组**/
@property (nonatomic, strong) NSMutableArray *acBtnArr;
/** 轮播图**/
@property (nonatomic, strong) NSMutableArray *infScroImagArr;

@property (nonatomic, strong) BHInfiniteScrollView *infinitePageView;
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
        [btn addTarget:self action:@selector(clickTestBtn) forControlEvents:UIControlEventTouchUpInside];
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
// <测试>按钮点击
- (void)clickTestBtn
{
//    ZMGoodsVC *goodVC = [[ZMGoodsVC alloc] init];
    NSLog(@"<测试>按钮点击");
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:goodVC];
//
//    [self.owner presentViewController:nav animated:NO completion:nil];
//    [self.owner.navigationController pushViewController:goodVC animated:NO];
}

- (void)initValue
{
    self.acBtnDataArr = [NSMutableArray array];
    self.infScroImagArr = [NSMutableArray array];
    self.acBtnArr = [NSMutableArray array];
}
/******************
 *** 数据解析
 ******************/
#pragma mark - 数据解析
- (void)loadCarouselData
{
    // 初始化数据
//        [self initValue];
    
     // 请求地址 https://taoboo.kunleen.com/coupon.webapi//api/deploy/carousel
    [ZMHttpTool get:ZMMainUrl params:nil success:^(id responseObj) {
        // 请求按钮数据
        NSMutableArray *btnArr = [[responseObj objectAtIndex:1] objectForKey:@"carousels"];
        for (int i = 0; i < btnArr.count; i ++) {
            NSString *btnUrl = [btnArr[i] objectForKey:@"carouselImage"];
            NSURL *url = [NSURL URLWithString:btnUrl];
            [self.acBtnDataArr addObject:url];
//            [self.acBtnArr[i] sd_setBackgroundImageWithURL:self.acBtnDataArr[i] forState:UIControlStateNormal];
//            NSLog(@"%@",self.acBtnDataArr[i]);
            UIButton *btn = _acBtnArr[i];
            if (btn.tag == i) {
                [btn sd_setBackgroundImageWithURL:self.acBtnDataArr[i] forState:UIControlStateNormal];
                //                }
            }
            
        }
        
        // 轮播图数据
        NSMutableArray *infinArr = [[responseObj objectAtIndex:0] objectForKey:@"carousels"];
        //添加数组
        for (int i = 0; i < infinArr.count; i ++) {
            NSString *infinUrl = [infinArr[i] objectForKey:@"carouselImage"];
//            NSURL *url = [NSURL URLWithString:infinUrl];
            [self.infScroImagArr addObject:infinUrl];
        }
        
        [self.infinitePageView setImagesArray:_infScroImagArr];

    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
    }];
}

@end
