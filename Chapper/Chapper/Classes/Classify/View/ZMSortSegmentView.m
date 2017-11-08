//
//  ZMSortSegmentView.m
//  Chapper
//
//  Created by liyongfei on 2017/11/7.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMSortSegmentView.h"
#import "ZMLotteryVCViewController.h"
@interface ZMSortSegmentView()
// 普通状态下导航栏图片组
@property (nonatomic, strong) NSArray *defImageArr;
// 选中状态下导航栏图片组
@property (nonatomic, strong) NSArray *selimageArr;
@end

@implementation ZMSortSegmentView
// 普通状态下导航栏图片组 懒加载
-(NSArray *)defImageArr
{
    if (_defImageArr == nil) {
        _defImageArr =@[@"button_fl_nvzh1",@"button_fl_muying1",@"button_fl_hzpin1",@"button_fl_jvjia1",@"button_fl_xiebaops1",@"button_fl_meishi1",@"button_fl_wenticp1",@"button_fl_shumajd1",@"button_fl_nanzhua1",@"button_fl_neiyi1"];
        
    }
    return _defImageArr;
}
// 选中状态下导航栏图片组 懒加载
- (NSArray *)selimageArr
{
    if (_selimageArr == nil) {
         _selimageArr =@[@"button_fl_nvzh2",@"button_fl_muying2",@"button_fl_hzpin2",@"button_fl_jvjia2",@"button_fl_xiebaops2",@"button_fl_meishi2",@"button_fl_wenticp2",@"button_fl_shumajd2",@"button_fl_nanzhua2",@"button_fl_neiyi2"];
    }
    return _selimageArr;
}

// 创建sortView
- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    NSMutableArray *vcarr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        ZMLotteryVCViewController *lottery = [[ZMLotteryVCViewController alloc] init];
//        lottery.view.frame = CGRectMake(0, kDeviceWidth / 7, kDeviceWidth, kDeviceHeight);
//        lottery.view.backgroundColor = kSmallRed;
        
        [vcarr addObject:lottery];
    }
    self.frame = CGRectMake(0,64,self.jc_width, self.jc_height - 64 - 49);
//    self.isChildScollEnabled = NO;
    self.titleBarStyles = MJCTitlesScrollStyle;
    self.itemTextNormalColor = [UIColor redColor];
    self.itemTextSelectedColor = [UIColor purpleColor];
    self.isIndicatorFollow = NO;
    self.isItemTitleTextHidden = YES;
    self.selectedSegmentIndex = 0;
    self.defaultShowItemCount = 7;
    self.itemBackColor = [UIColor whiteColor];
    self.indicatorColor = kSmallRed;
    self.titlesViewFrame = CGRectMake(0,0,self.jc_width, kDeviceWidth / 7 );

    
    self.itemNormalBackImageArray = self.defImageArr;
    self.itemSelectedBackImageArray = self.selimageArr;

    [self intoChildControllerArray:vcarr];
}

@end
