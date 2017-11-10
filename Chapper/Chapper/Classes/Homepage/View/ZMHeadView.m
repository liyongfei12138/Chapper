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
@interface ZMHeadView ()<BHInfiniteScrollViewDelegate>

//@property (nonatomic, copy) NSMutableArray *acBtnArr;
@property (nonatomic, strong) BHInfiniteScrollView *infinitePageView1;
//@property (nonatomic, strong) NSMutableArray *imageAr;

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
    // 请求数据
    [self loadCarouselData];
    
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
//        [btn setImage:[UIImage imageNamed:@"button_wd_morentx"] forState:UIControlStateNormal];
//        [self addSubview:btn];
        [btnBactView addSubview:btn];
        [_acBtnArr  addObject:btn];
    }
    
   

}
// 设置轮播图
- (UIView *)setUpScrollView
{
    
    //要异步下载。。。待做优化
    NSArray *urlsArray = [NSArray array];
    CGFloat viewHeight =  kDeviceWidth * 0.42;
    
    BHInfiniteScrollView *infinitePageView1 = [BHInfiniteScrollView
                                               infiniteScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), viewHeight) Delegate:self ImagesArray:urlsArray];
//    infinitePageView1.titlesArray = titlesArray;
//    infinitePageView1.pageControl.dotSize = 10;
//    [infinitePageView1. setDotSize:10];
    infinitePageView1.dotSpacing = 10;
    infinitePageView1.pageControlAlignmentOffset = CGSizeMake(0,10);
    infinitePageView1.scrollTimeInterval = 4;
    infinitePageView1.autoScrollToNextPage = YES;
    infinitePageView1.delegate = self;
    [self addSubview:infinitePageView1];
    self.infinitePageView1 = infinitePageView1;
    
    return infinitePageView1;
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
    self.acBtnArr = [NSMutableArray array];
    self.infImagArr = [NSMutableArray array];
}
/******************
 *** 数据解析
 ******************/
- (void)loadCarouselData
{
//    [self initValue];
    dispatch_queue_t queue = dispatch_queue_create("downImage", DISPATCH_QUEUE_SERIAL);
    //设置按钮图片
    dispatch_async(queue, ^{
        [ZMHttpTool get:@"http://192.168.1.50:8080/coupon.webapi//api/deploy/carousel" params:nil success:^(id responseObj) {
            //         NSLog(@"%@",responseObj);
            // 请求按钮数据
            NSMutableArray *btnArr = [[responseObj objectAtIndex:1] objectForKey:@"carousels"];
            
            NSString *btnUrl;
            NSMutableArray *btnImageArr = [NSMutableArray array];
            for (int i = 0 ; i < btnArr.count ; i++ )
            {
                btnUrl = [btnArr[i] objectForKey:@"carouselImage"];
                //            NSLog(@"%@",btnImageArr[i]);
                NSURL *url = [NSURL URLWithString:btnUrl];
                [btnImageArr addObject:url];
//                NSLog(@"%@",_acBtnArr[i]);
                //获取按钮 并设置图片
                UIButton *acBtn = _acBtnArr[i];
                if (acBtn.tag == i) {
                    [acBtn sd_setBackgroundImageWithURL:btnImageArr[i] forState:UIControlStateNormal];
                }
            }
        } failure:^(NSError *error) {
            NSLog(@"失败");
        }];
    });
    
    // 轮播图
    dispatch_async(queue, ^{
//        [af]
        [ZMHttpTool get:@"http://192.168.1.50:8080/coupon.webapi//api/deploy/carousel" params:nil success:^(id responseObj) {
            NSMutableArray *imageArr = [[responseObj objectAtIndex:0] objectForKey:@"carousels"];
            NSString *imageUrl;
            NSMutableArray *infImageUrlArr = [NSMutableArray array];
            for (int i = 0; i < imageArr.count; i++) {
                imageUrl = [imageArr[i] objectForKey:@"carouselImage"];
//                NSLog(@"%@",imageUrl);
                [infImageUrlArr addObject:imageUrl];
                [self.infinitePageView1 setImagesArray:infImageUrlArr];
            }
        } failure:^(NSError *error) {
             NSLog(@"失败");
        }];
    });
    
}
/*
- (void)loadCarouselData
{
    self.imageAr = [NSMutableArray array];
    // 初始化活动按钮图片
    _acBtnArr = [NSMutableArray array];
    // 请求地址 http://192.168.1.50:8080/coupon.webapi//api/deploy/carousel
    [ZMHttpTool get:@"http://192.168.1.50:8080/coupon.webapi//api/deploy/carousel" params:nil success:^(id responseObj) {
//         NSLog(@"%@",responseObj);
        // 请求按钮数据
        NSMutableArray *btnArr = [[responseObj objectAtIndex:1] objectForKey:@"carousels"];

        NSString *btnUrl;
        NSMutableArray *btnImageArr = [NSMutableArray array];
        for (int i = 0 ; i < btnArr.count ; i++ )
        {
            btnUrl = [btnArr[i] objectForKey:@"carouselImage"];
            //            NSLog(@"%@",btnImageArr[i]);
            NSURL *url = [NSURL URLWithString:btnUrl];
            [btnImageArr addObject:url];
            
            //获取按钮 并设置图片
            UIButton *acBtn = _acBtnArr[i];
            if (acBtn.tag == i) {
                [acBtn sd_setBackgroundImageWithURL:btnImageArr[i] forState:UIControlStateNormal];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
}*/
@end
