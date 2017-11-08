//
//  ZMHomepageVC.h
//  Chapper
//
//  Created by liyongfei on 2017/11/2.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMHotVC.h"
@interface ZMHomepageVC : UIViewController<UISearchBarDelegate>

{
    
    float _collectedHeight;

}
@property (nonatomic,strong) ZMHotVC *hotViewController;
@property (nonatomic,strong) UICollectionView* collectionView;
//- (UIView *)createHeartView;


@end
