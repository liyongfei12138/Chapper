//
//  ZMMyFootView.m
//  Chapper
//
//  Created by liyongfei on 2017/11/7.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMMyFootView.h"

@implementation ZMMyFootView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 创建申明
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    titleLabel.text = @"声明:所有活动均与苹果公司无关!";
    [titleLabel setTextColor:kSmallRed];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
}

@end
