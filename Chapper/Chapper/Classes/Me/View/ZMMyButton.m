//
//  ZMMyButton.m
//  Chapper
//
//  Created by liyongfei on 2017/11/7.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMMyButton.h"

@implementation ZMMyButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"button_wd_morentx"]];
    image.frame = CGRectMake(kDeviceWidth * 0.08, kDeviceHeight * 0.08, kDeviceWidth * 0.25, kDeviceWidth * 0.25);
    [self addSubview: image];
    
    UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"button_wd_touxiangwq"]];
    image1.bounds = CGRectMake(0, 0, kDeviceWidth * 0.25, kDeviceWidth * 0.25);
    image1.center = image.center;
    [self addSubview: image1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth * 0.38, self.height * 0.35 + 25, kDeviceWidth * 0.65, kDeviceHeight * 0.1)];
    
    label.text = @"请先登录";
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    label.centerY = image.centerY;
    [self addSubview:label];
}

@end
