//
//  ZMWebVC.m
//  Chapper
//
//  Created by liyongfei on 2017/11/14.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMWebVC.h"

@interface ZMWebVC () <UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;


@end

@implementation ZMWebVC


-(instancetype)initWithWebView
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    [_webView setUserInteractionEnabled:YES];//是否支持交互
    [_webView setDelegate:self];
    [_webView setBackgroundColor:kSmallGray];
    [_webView setOpaque:NO];//opaque是不透明的意思
    [self.view addSubview:_webView];
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:_webUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = request.URL;
    
    
    if ([url.scheme  isEqualToString:@"tbopen"])
    {
        NSLog(@"%@",url.scheme);
        return NO;
    }
    
    return YES;
}

@end
