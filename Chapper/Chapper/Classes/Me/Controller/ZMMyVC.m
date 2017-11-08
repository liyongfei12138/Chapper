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

@interface ZMMyVC () <UITableViewDataSource,UITableViewDelegate>

// 懒加载菜单数组
@property (nonatomic, strong) NSArray *itemArr;

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
//    ZMFAQVC *vc = [[ZMFAQVC alloc] init];
    switch (indexPath.row) {
        case 0:
            ZMLOG(@"你点击了第%zd的cell",indexPath.row);
            break;
        case 1:
            ZMLOG(@"你点击了第%zd的cell",indexPath.row);
            
            break;
        case 2:
            ZMLOG(@"你点击了第%zd的cell",indexPath.row);
            break;
        case 3:
            ZMLOG(@"你点击了第%zd的cell",indexPath.row);
            break;
        default:
            break;
    }
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
