//
//  ZMHeadView.h
//  Chapper
//
//  Created by liyongfei on 2017/11/4.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMHeadView : UIView

@property (nonatomic,strong) UIViewController *owner;

/** 轮播图**/
@property (nonatomic, strong)NSMutableArray *infImagArr;
/** 活动按钮**/
@property (nonatomic, strong) NSMutableArray *acBtnArr;
@end
