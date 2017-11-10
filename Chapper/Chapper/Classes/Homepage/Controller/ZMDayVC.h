//
//  ZMDayVC.h
//  Chapper
//
//  Created by liyongfei on 2017/11/9.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMDayVC : UIViewController

@property (nonatomic, strong) NSMutableArray *todayArr;
@property (nonatomic, strong) UICollectionView *collectionView;

// 刷新数据
- (void)reloadAllData;
@end
