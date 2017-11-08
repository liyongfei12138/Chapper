//
//  ZMMyHeadView.m
//  Chapper
//
//  Created by liyongfei on 2017/11/7.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMMyHeadView.h"
#import "ZMMyButton.h"

@implementation ZMMyHeadView

 - (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = kSmallRed;
    
    // 创建LoginBtn
    ZMMyButton *loginBtn = [ZMMyButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = self.frame;
    [loginBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginBtn];

    
}
//点击登入按钮
- (void)clickLoginBtn
{
    ZMLOG(@"你点击了login按钮");
}

@end