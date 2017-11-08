//
//  ZMMyVC.m
//  Chapper
//
//  Created by liyongfei on 2017/11/2.
//  Copyright © 2017年 liyongfei. All rights reserved.
//
// **********
// 我的
// **********

#import "ZMMyVC.h"
#import "ZMMyTableViewCell.h"
#import "ZMMyHeadView.h"
#import "ZMMyFootView.h"
#import "ZMMyItem.h"
#import <MJExtension.h>
#import "ZMFAQVC.h"
#import "ZMAboutVC.h"

@interface ZMMyVC () <UITableViewDataSource,UITableViewDelegate>

// 懒加载菜单数组
@property (nonatomic, strong) NSArray *itemArr;

//@property (nonatomic, strong) UINavigationController *nav;

@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation ZMMyVC

- (NSArray *)itemArr
{
    if (_itemArr == nil) {
        _itemArr = [ZMMyItem mj_objectArrayWithFilename:@"myMenu.plist"];
    }
    return _itemArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
   // 创建tableview
    [self setTableV];
}

// 创建tableview
- (void)setTableV
{
    // 创建我的界面tableview
    UITableView *tableV =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight + 64) style:UITableViewStyleGrouped];
    //    tableView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
    
    // 创建headview
    ZMMyHeadView *headView = [[ZMMyHeadView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight * 0.25)];
    [tableV setTableHeaderView:headView];
    
    tableV.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_wd_beijing"]];
    imageV.frame = headView.frame;
    imageV.frame = headView.frame;
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    imageV.layer.zPosition = 0;

    [headView addSubview:imageV];
    self.imageV = imageV;
    
    // 创建footview
    ZMMyFootView *footView = [[ZMMyFootView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    
    [self.view addSubview:footView];
    [tableV setTableFooterView:footView];
    
}
// 隐藏nav
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}

#pragma mark - UITableViewDataSource -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCellID = @"ownTableCell";
    ZMMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellID];
//    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZMMyTableViewCell" owner:nil options:nil] lastObject];
    }
//    cell.textLabel.text = @"test";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.item = self.itemArr[indexPath.row];
//    ZMLOG(@"%@",cell.item.name);
    
    return cell;
}

// tableView点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZMFAQVC *faqVC = [[ZMFAQVC alloc] init];
    ZMAboutVC *aboutVC = [[ZMAboutVC alloc] init];
    // 改变返回按钮样式
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn1.frame = CGRectMake(60, 0, 40, 40);
    [backBtn1 setImage:[UIImage imageNamed:@"icon_xq_fanhui2"] forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn1 sizeToFit];
    
    
//    faqVC.navigationItem.title = @"常见问题";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:faqVC];
     UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:aboutVC];
    
    switch (indexPath.row) {
        case 0:
            ZMLOG(@"你点击了第%zd的cell",indexPath.row);
            break;
        case 1:
//            ZMLOG(@"你点击了第%zd的cell",indexPath.row);
//            [self.navigationController pushViewController:faqVC animated:YES];
            // 改变nav样式以及返回按钮
            faqVC.navigationItem.title = @"常见问题";
            [faqVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];
            [faqVC.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
            faqVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
            [self presentViewController:nav animated:YES completion:nil];
            
            break;
        case 2:
            [self clickClean];
            break;
            
            
        case 3:
//            ZMLOG(@"你点击了第%zd的cell",indexPath.row);
            aboutVC.navigationItem.title = @"关于";
            [aboutVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64white"] forBarMetrics:UIBarMetricsDefault];
            [aboutVC.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
            aboutVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn1];
            [self presentViewController:nav1 animated:YES completion:nil];
            break;
            
        default:
            break;
    }
}
// 让cell选中无阴影

- (void)clickClean
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"确定清除缓存?" preferredStyle:UIAlertControllerStyleAlert];
    // 点击确定
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        // 清除缓存
        NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
        NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
//        NSLog ( @"cachpath = %@" , cachPath);
        for ( NSString * p in files) {
            NSError * error = nil ;
            NSString * path = [cachPath stringByAppendingPathComponent :p];
            if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
                [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            }
        }
        [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject :nil waitUntilDone : YES ];
        [self clearCachSuccess];
    }];
    // 点击返回
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    // 添加action
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)clearCachSuccess
{
//    NSLog ( @" 清理成功 " );
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"缓存清理完毕" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
// 返回按钮
-(void)backBtn
{
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 获取tableview偏移量
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat yOffset = scrollView.contentOffset.y; // 获取偏移量
    CGFloat viewH =  kDeviceHeight * 0.25;
    // 判断 ->向下是负值
    if (yOffset < 0) {
        self.imageV.frame = CGRectMake(0, yOffset, kDeviceWidth, viewH - yOffset);
    }
}
@end
