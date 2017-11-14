//
//  ZMDayVC.m
//  Chapper
//
//  Created by liyongfei on 2017/11/9.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMDayVC.h"
#import "ZMTreatureCollectionViewCell.h"
#import "ZMGoodsVC.h"
#include <MJExtension.h>
#import "ZMTodayItem.h"
#import <UIImageView+WebCache.h>
#import "MJRefresh.h"
@interface ZMDayVC () <UICollectionViewDataSource,UICollectionViewDelegate>


@end

@implementation ZMDayVC
//- (NSMutableArray *)todayArr
//{
//    if (_todayArr) {
//        _todayArr = [NSMutableArray array];
//    }
//    return _todayArr;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initValue];
    [self loadCarouselData];
    
   
    // Do any additional setup after loading the view.
     UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
     UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - self.tabBarController.tabBar.bounds.size.height)
                                                          collectionViewLayout:layout];
    
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth * 0.5 * 1.2 * self.todayArr.count - self.tabBarController.tabBar.bounds.size.height)collectionViewLayout:layout];
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing = 0.5;
    [layout setSectionInset:UIEdgeInsetsMake(0.5, 0.5, 0.5, 0.5)];
    
    [collectionView setBackgroundColor:kSmallGray];
    [self.view addSubview:collectionView];
    [collectionView setDelegate:self];
    [collectionView setDataSource:self];
    [collectionView setScrollEnabled:false];
    
//    //上拉更新
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadCarouselData)];
//    [footer setTitle:@"点击或者上拉刷新" forState:MJRefreshStateIdle];
//    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"---没有更多数据---" forState:MJRefreshStateNoMoreData];
//    [footer setTitle:@"松开开始加载" forState:MJRefreshStatePulling];
//    collectionView.mj_footer = footer;
//    collectionView.mj_footer.y -= 20;
    
    self.collectionView = collectionView;

}

// 初始化数据
- (void)initValue
{
    //初始化默认页数
    self.index = 1;
    self.todayArr = [NSMutableArray array];
}

#pragma mark -- UICollectionViewDataSource,UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((float)(kDeviceWidth) * 0.5 - 1, kDeviceWidth * 0.5 * 1.2) ;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.todayArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifi = @"TreatureCollectionCell";
    
    UINib *nib = [UINib nibWithNibName:@"ZMTreatureCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:cellIndentifi];
    
    ZMTreatureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifi forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (self.todayArr.count > 0) {
        // 获取模型数据
        ZMTodayItem *item = self.todayArr[indexPath.row];
        // 设置数据
        [cell.photo sd_setImageWithURL:[NSURL URLWithString:item.itemImage] placeholderImage:nil];
        cell.inforLabel.text = item.itemName;
        cell.progressLabel.text = item.finalPrice;
        cell.personLabel.text = item.sellAmount;
    }
  

    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZMGoodsVC *goodVC = [[ZMGoodsVC alloc] init];
    NSLog(@"<测试>按钮点击");
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:goodVC];
    goodVC.todayArr = self.todayArr[indexPath.row];
    [self presentViewController:nav animated:NO completion:nil];
    //    [self.owner.navigationController pushViewController:goodVC animated:NO];
}


/******************
 *** 数据解析
 ******************/
#pragma mark - 数据解析
- (void)loadCarouselData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSNumber numberWithInt:0] forKey:@"query_type"];
    [parameters setObject:[NSNumber numberWithInt:20] forKey:@"page_size"];
    [parameters setObject:[NSNumber numberWithInt:_index] forKey:@"page_index"];
    [ZMHttpTool post:ZMItemUrl params:parameters success:^(id responseObj) {
        
//        self.todayArr = [responseObj objectForKey:@"item"];
        NSArray *todayArr = [ZMTodayItem mj_objectArrayWithKeyValuesArray:responseObj[@"item"]];
        [self.todayArr addObjectsFromArray:todayArr];
 
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.todayArr,@"dayArray",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dayH" object:nil userInfo:dict];
//        //创建通知
//        NSNotification *notification =[NSNotification notificationWithName:@"dayH" object:nil userInfo:dict];
//        //通过通知中心发送通知
//        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
       
         [self reloadAllData];
        

        // 页数
        _index ++;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 刷新数据
-(void)reloadAllData
{
    float hight = kDeviceWidth * 0.5 * 1.2 * (_todayArr.count * 0.5) + (_todayArr.count * 0.25);
    NSLog(@"%f",hight);
    self.collectionView.frame = CGRectMake(0, 0, kDeviceWidth, hight);
    [self.view setHeight:hight];
    [self.collectionView reloadData];
}
@end
