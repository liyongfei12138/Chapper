//
//  ZMGoodsHeadView.m
//  Chapper
//
//  Created by liyongfei on 2017/11/8.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMGoodsHeadView.h"
#import <BHInfiniteScrollView.h>

@interface ZMGoodsHeadView() <BHInfiniteScrollViewDelegate>

@property (nonatomic, strong) BHInfiniteScrollView *infinitePageView;

@end
@implementation ZMGoodsHeadView

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height =  kDeviceWidth * 1.5 + 130;
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, height)];
//    [headerView setBackgroundColor:[UIColor whiteColor]];
    self.frame = CGRectMake(0, 0, kDeviceWidth, height);
    
    //    NSArray* arr = [[NSArray alloc]initWithObjects:[_dataDic objectForKey:@"itemImage"], nil];
    NSArray* arr = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"button_wd_morentx"],nil];
    _infinitePageView = [BHInfiniteScrollView infiniteScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth) Delegate:self ImagesArray:arr];
    //    _infinitePageView.isToolInfor = YES;
    //    _infinitePageView.pageControl.dotSize = 10;
    //    _infinitePageView.pageControlAlignmentOffset = CGSizeMake(0, 10);
    _infinitePageView.autoScrollToNextPage = NO;
    _infinitePageView.scrollTimeInterval = 0;
    _infinitePageView.delegate = self;
    
    [self addSubview:_infinitePageView];
    
    UILabel* nameLabel = [[UILabel alloc]init];
    nameLabel.width = kDeviceWidth - 20;
    nameLabel.centerX = kDeviceWidth * 0.5;
    nameLabel.height = 50;
    nameLabel.y = kCICLYHEIGHT + 3;
    nameLabel.numberOfLines = 2;
    //    nameLabel.text = [_dataDic objectForKey:@"itemName"];
    nameLabel.text = @"这是测试的lable";
    [self addSubview:nameLabel];
    
    UILabel* beforLabel = [[UILabel alloc]init];
    //    [beforLabel setText:[NSString stringWithFormat:@"¥%@",[_dataDic objectForKey:@"price"]]];
    [beforLabel setText:[NSString stringWithFormat:@"¥%@",@"测试123"]];
    [beforLabel setFont:[UIFont systemFontOfSize:20]];
    [beforLabel sizeToFit];
    beforLabel.x = 10;
    beforLabel.centerY = kCICLYHEIGHT + 70;
    [self addSubview:beforLabel];
    
    UILabel* afterInfor = [[UILabel alloc]init];
    [afterInfor setText:@"实际券后价"];
    [afterInfor setFont:[UIFont systemFontOfSize:16]];
    [afterInfor sizeToFit];
    [afterInfor setTextColor:[UIColor lightGrayColor]];
    afterInfor.x = beforLabel.x + beforLabel.width + 20;
    afterInfor.centerY = kCICLYHEIGHT + 70;
    [self addSubview:afterInfor];
    
    
    UILabel* afterLabel = [[UILabel alloc]init];
    //    [afterLabel setText:[NSString stringWithFormat:@"¥%@",[_dataDic objectForKey:@"finalPrice"]]];
    [afterLabel setText:[NSString stringWithFormat:@"¥%@",@"123"]];
    [afterLabel setFont:[UIFont systemFontOfSize:20]];
    [afterLabel sizeToFit];
    [afterLabel setTextColor:kSmallRed];
    afterLabel.x = afterInfor.x + afterInfor.width + 5;
    afterLabel.centerY = kCICLYHEIGHT + 70;
    [self addSubview:afterLabel];
    
    UILabel* personLabel = [[UILabel alloc]init];
    //    [personLabel setText:[NSString stringWithFormat:@"月销%d件",[[_dataDic objectForKey:@"sellAmount"] intValue]]];
    [personLabel setText:[NSString stringWithFormat:@"月销%@件",@"测试10"]];
    [personLabel setFont:[UIFont systemFontOfSize:16]];
    [personLabel sizeToFit];
    [personLabel setTextColor:[UIColor lightGrayColor]];
    personLabel.x = kDeviceWidth - 10 - personLabel.width;
    personLabel.centerY = kCICLYHEIGHT + 70;
    [self addSubview:personLabel];
    
    UIView* colorView = [[UIView alloc]initWithFrame:CGRectMake(0, kDeviceWidth + 90, kDeviceWidth, kDeviceWidth * 0.5  + 5)];
    [colorView setBackgroundColor:kSmallGray];
    [self addSubview:colorView];
    
    UIImageView* iamge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xq_goumaixuzhi"]];
    iamge.width = kDeviceWidth;
    iamge.height = kDeviceWidth * 0.5;
    iamge.x =  0 ;
    iamge.y = 5;
    [colorView addSubview:iamge];
}

@end
