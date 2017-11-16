//
//  ZMLotteryVCViewController.m
//  Chapper
//
//  Created by liyongfei on 2017/11/7.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMLotteryViewController.h"
#import "MJRefresh.h"
#import "ZMTreatureCollectionViewCell.h"
#import "ZMExcellentViewController.h"
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import "ZMClassifyItem.h"
#import "ZMGoodsHeadView.h"

@interface ZMLotteryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSDictionary *goodDict;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger index;
@end

@implementation ZMLotteryViewController

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initValue];
    // 解析数据
    [self loadCarouselData];
    
    self.view.backgroundColor = [UIColor yellowColor];
//    self.view.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing = 0.5;
    [layout setSectionInset:UIEdgeInsetsMake(0.5, 0.5, 0.5, 0.5)];
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) collectionViewLayout:layout];
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing = 0.5;
    [layout setSectionInset:UIEdgeInsetsMake(0.5, 0.5, 0.5, 0.5)];
    
    [collectionView setBackgroundColor:kSmallGray];
    [self.view addSubview:collectionView];
    [collectionView setDelegate:self];
    [collectionView setDataSource:self];
    
    //    _dataArr = [[NSMutableArray alloc]init];
    collectionView.height = kDeviceHeight;
    
    //    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadCarouselData)];
    
    [footer setTitle:@"点击或者上拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"---没有更多数据---" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"松开开始加载" forState:MJRefreshStatePulling];
    collectionView.mj_footer.hidden = YES;
    collectionView.mj_footer = footer;
    
    self.collectionView = collectionView;
}

- (void)initValue
{
    self.goodDict = [NSDictionary dictionary];
//    self.dataArr = [NSMutableArray array];
    self.index = 1;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((float)(kDeviceWidth) * 0.5 - 1, kDeviceWidth * 0.5 * 1.2 ) ;
}
//定义每个Section的四边间距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(1, 1, 1, 1);//分别为上、左、下、右
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifi = @"TreatureCollectionCell";
    
    UINib *nib = [UINib nibWithNibName:@"ZMTreatureCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:cellIndentifi];
    
    ZMTreatureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifi forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
//    cell.backgroundColor = [UIColor grayColor];
    if (self.dataArr.count > 0) {
        ZMClassifyItem *item = self.dataArr[indexPath.row];
        [cell.photo sd_setImageWithURL:[NSURL URLWithString:item.itemImage]];
        cell.inforLabel.text = item.itemName;
        cell.progressLabel.text = [NSString stringWithFormat:@"%@",item.finalPrice];
        cell.personLabel.text = item.sellAmount;
    }

    
    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZMExcellentViewController *goodVC = [[ZMExcellentViewController alloc] init];
    goodVC.lotterArr = _dataArr[indexPath.row];
    NSLog(@"<测试>按钮点击");
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:goodVC];
    
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
    [parameters setObject:_keyWorld forKey:@"query_data"];
    [parameters setObject:[NSNumber numberWithInt:_poseType] forKey:@"query_type"];
    [parameters setObject:[NSNumber numberWithInt:_index] forKey:@"page_index"];
    [ZMHttpTool post:ZMItemUrl params:parameters success:^(id responseObj) {
        
        self.goodDict = [responseObj valueForKey:@"item"];
        
//      [ZMClassItem mj_objectWithKeyValues:self.goodDict];
        NSArray *arr = [ZMClassifyItem mj_objectArrayWithKeyValuesArray:self.goodDict];
        [self.dataArr addObjectsFromArray:arr];
        
//        [self.dataArr removeAllObjects];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
        _index ++;
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请检查网络"];
        [SVProgressHUD dismissWithDelay:0.5];
    }];
}



@end
