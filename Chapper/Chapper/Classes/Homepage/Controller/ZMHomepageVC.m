//
//  ZMHomepageVC.m
//  Chapper
//
//  Created by liyongfei on 2017/11/2.
//  Copyright © 2017年 liyongfei. All rights reserved.
//
// **********
// 主页
// **********
#import "ZMHomepageVC.h"
#import <MJRefresh.h>
#import "ZMHeadView.h"
#import <AFNetworking.h>
#import "ZMCarouselImageItem.h"

@interface ZMHomepageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
// 数据模型
@property (nonatomic, strong) ZMCarouselImageItem *carouselItem;
@end

@implementation ZMHomepageVC
// **********
// 宏
// **********
//#define collectedHeight ((float)(kDeviceWidth) * 0.4 - 0.5)/ 4.0 * 5.0
//获取searchBar中field
#define searchFieldKey @"_searchField"
//获取placeholder中text
#define placeholderKey @"_placeholderLabel.font"
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置背景颜色
    self.view.backgroundColor = kSmallGray;
    // 创建tableview
    [self setUpTableView];

    [self loadCarouselData];
}

// 创建tableview
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 49) style:UITableViewStylePlain];
    
//    [self.tableView setTableHeaderView:self.createHeartView];
    
    ZMHeadView *headView = [[ZMHeadView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth * 0.42 + kDeviceWidth * 0.25 * 1.11 + collectedHeight + 60)];
    
    [self.tableView setTableHeaderView:headView];
    [self.tableView setRowHeight:kDeviceHeight];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
//    [UIImage imageNamed:]
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:
                                     ^{
                                         //Call this Block When enter the refresh status automatically
                                         [self.tableView.mj_footer resetNoMoreData];
                                         
                                     }];
    self.tableView.mj_header = header;
    self.tableView.mj_header.hidden = NO;
    [header setTitle:@"正在加载哦。。。。" forState:MJRefreshStateRefreshing];
    
    //上拉更新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"点击或者上拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"---没有更多数据---" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"松开开始加载" forState:MJRefreshStatePulling];
    self.tableView.mj_footer = footer;
    self.tableView.mj_footer.y -= 20;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *showUserInfoCellIdentifier = @"ShowUserInfoCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:showUserInfoCellIdentifier];
        if (_hotViewController == nil) {
            _hotViewController = [[ZMHotVC alloc] init];
            [self addChildViewController:_hotViewController];
            [cell addSubview:_hotViewController.view];
        }

    }
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

// 在页面将要显示时创建nav
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //使用分类更改nav背景
//    [self.navigationController.navigationBar lt_setBackgroundColor:kSmallRed];

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth * 0.9, 44)];
    titleView.backgroundColor = kSmallRed;
     UIColor *color =  self.navigationController.navigationBar.backgroundColor ;
    
    //设置nav标题图片
    UIImageView *titleImageV = [[UIImageView alloc] initWithImage:[UIImage imageWithRandAsOriImagename:@"logo"]];
    [titleImageV sizeToFit];
    titleImageV.centerY = titleView.height * 0.5 - 2;
    titleImageV.x = 0;
    [titleView addSubview:titleImageV];
    
    //创建searchBar
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(titleImageV.x + titleImageV.width + 20, 3, titleView.width - titleImageV.width - 20, 35);
    searchBar.backgroundColor = color;
    searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    searchBar.placeholder = @"搜索好宝贝";
    //修改placeholder字体颜色和大小
    UITextField *searchField = [searchBar valueForKey:searchFieldKey];
    [searchField setValue:[UIFont systemFontOfSize:17] forKeyPath:placeholderKey];
    [searchBar setContentMode:UIViewContentModeLeft];//设置内容模式
    [titleView addSubview:searchBar];
    
    self.navigationItem.titleView = titleView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30;
    
}
//今日优品头部view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tableSectionHeart = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
    [tableSectionHeart setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView* imageName = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_jinriyp"]];
    [imageName sizeToFit];
    imageName.x = 10;
    imageName.centerY = tableSectionHeart.height * 0.5;
    [tableSectionHeart addSubview:imageName];
    return tableSectionHeart;
}

/******************
 *** 数据解析
 ******************/
- (void)loadCarouselData
{
    // 请求地址 http://192.168.1.50:8080/coupon.webapi//api/deploy/carousel
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://192.168.1.50:8080/coupon.webapi//api/deploy/carousel" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/liyongfei/Documents/carouse.plist" atomically:YES];
//        NSArray *carouseDict = [responseObject[@"carousels"] lastObject];
//        NSLog(@"%@",carouseDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
