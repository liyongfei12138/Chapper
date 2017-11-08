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
#import "ZMHotHeadView.h"
#import "ZMGoodsVC.h"

@interface ZMHeadView ()<BHInfiniteScrollViewDelegate>

@end
@implementation ZMHeadView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    //[[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth * 0.42 + kDeviceWidth * 0.25 * 1.11 + _collectedHeight + 60)];
    self.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceWidth * 0.42 + kDeviceWidth * 0.25 * 1.11 + collectedHeight + 60);
    self.backgroundColor = kSmallGray;
    
    // 设置Button
    for (int i = 0 ; i < 4; i++)
    {
         UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kDeviceWidth * 0.25 * i , kDeviceWidth * 0.42, kDeviceWidth * 0.25 - 1, kDeviceWidth * 0.25 * 1.11);
        btn.tag = i;
        [btn addTarget:self action:@selector(clickTextBtn) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setImage:[UIImage imageNamed:@"button_wd_morentx"] forState:UIControlStateNormal];
        [self addSubview:btn];
//        [_activityBtnArr  addObject:btn];
    }
    
    UIView *scrollView = [self setUpScrollView];
//    view.bounds = CGRectMake(0, 60, kDeviceWidth, 200);
    [self addSubview:scrollView];
    
    //创建hot页面
    ZMHotHeadView *hotView = [[ZMHotHeadView alloc] initWithFrame:CGRectMake(0, kDeviceWidth * 0.42 + kDeviceWidth * 0.25 * 1.11 + 10, kDeviceWidth, collectedHeight)];
    hotView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:hotView];
}
// 设置轮播图
- (UIView *)setUpScrollView
{
    
    //要异步下载。。。待做优化
    NSArray *urlsArray = @[
                           @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg",
                           @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646649_1456498410838_800x600.jpg",
                           @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646706_1456498430419_800x600.jpg",
                           @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646723_1456498427059_800x600.jpg",
                           @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646705_1456498422529_800x600.jpg"
                           ];
//    NSArray* titlesArray = @[@"1",
//                             @"2",
//                             @"3",
//                             @"4",
//                             @"5",
//                             ];
//
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
    
    return infinitePageView1;
}
// <测试>按钮点击
- (void)clickTextBtn
{
    ZMGoodsVC *goodVC = [[ZMGoodsVC alloc] init];
    NSLog(@"<测试>按钮点击");
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:goodVC];

    [self.owner presentViewController:nav animated:NO completion:nil];
//    [self.owner.navigationController pushViewController:goodVC animated:NO];
}
@end
