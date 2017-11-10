//
//  ZMTodayItem.h
//  Chapper
//
//  Created by liyongfei on 2017/11/10.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMTodayItem : NSObject

/** 图片 **/
@property (nonatomic, strong) NSString *itemImage;

/** 名称 **/
@property (nonatomic, strong) NSString *itemName;

/** 价格 **/
@property (nonatomic, strong) NSString *finalPrice;

/** 人数 **/
@property (nonatomic, strong) NSString *sellAmount;

@end
