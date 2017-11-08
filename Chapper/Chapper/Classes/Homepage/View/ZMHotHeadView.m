//
//  ZMHotHeadView.m
//  Chapper
//
//  Created by liyongfei on 2017/11/4.
//  Copyright © 2017年 liyongfei. All rights reserved.
//
// **********
// 主页 热门商品view
// **********
#import "ZMHotHeadView.h"
#import "ZMHotCollectionViewCell.h"

@interface ZMHotHeadView() <UICollectionViewDelegate,UICollectionViewDataSource>
//@property (nonatomic, strong) UICollectionView *collectionView;
@end
@implementation ZMHotHeadView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.5;
    layout.minimumInteritemSpacing = 0.5;
    [layout setSectionInset:UIEdgeInsetsMake(0.5, 0.5, 0.5, 0.5)];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, kDeviceWidth, collectedHeight) collectionViewLayout:layout];
//    collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, kDeviceWidth, collectedHeight) collectionViewLayout:layout];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    //设置代理
    [collectionView setDelegate:self];
    [collectionView setDataSource:self];
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:[self setUpHeadView]];
    [self addSubview:collectionView];
//    self.collectionView = collectionView;
}

// 创建热门商品头view
- (UIView *) setUpHeadView
{
    UIImageView *hotImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_rementj.png"]];
    [hotImage sizeToFit];
    hotImage.x = 10;
    hotImage.y = 10;
//    [hotBg addSubview:hotImage];
    return hotImage;

}
#pragma mark collectdelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((float)(kDeviceWidth) * 0.4 - 1,((float)(kDeviceWidth) * 0.4 - 0.5) / 4.0 * 5.0);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Indentifi = @"HotToosCell";
    
    UINib *nib = [UINib nibWithNibName:@"ZMHotCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:Indentifi];
    
    ZMHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Indentifi forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
}
    @end
    
