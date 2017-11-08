//
//  ZMFAQVC.m
//  Chapper
//
//  Created by liyongfei on 2017/11/7.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMFAQVC.h"

@interface ZMFAQVC ()

@end

@implementation ZMFAQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    NSURL *url = [NSURL URLWithString:@"http://onepay.kunleen.com/images/onepay/html/Coupon-FAQ.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
    
    [self.view addSubview:web];
}




@end
