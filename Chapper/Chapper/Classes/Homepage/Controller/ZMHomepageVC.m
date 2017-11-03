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

@interface ZMHomepageVC ()

@end

@implementation ZMHomepageVC
// **********
// 宏
// **********
//获取searchBar中field
#define searchFieldKey @"_searchField"
//获取placeholder中text
#define placeholderKey @"_placeholderLabel.font"
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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



@end
