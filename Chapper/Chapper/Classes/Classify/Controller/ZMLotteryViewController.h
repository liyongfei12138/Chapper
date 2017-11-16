//
//  ZMLotteryVCViewController.h
//  Chapper
//
//  Created by liyongfei on 2017/11/7.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMLotteryViewController : UIViewController

@property (nonatomic,strong) NSString * keyWorld;
@property (nonatomic,assign) NSInteger poseType;



// 请求数据方法
- (void)loadCarouselData;
@end
