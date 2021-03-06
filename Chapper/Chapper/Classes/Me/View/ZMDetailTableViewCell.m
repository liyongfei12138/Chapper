//
//  ZMMyTableViewCell.m
//  Chapper
//
//  Created by liyongfei on 2017/11/7.
//  Copyright © 2017年 liyongfei. All rights reserved.
// **********
// 信息页自定义cell
// **********
#import "ZMDetailTableViewCell.h"
#import "ZMDetailItem.h"
@interface ZMDetailTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation ZMDetailTableViewCell
- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName[indexPath.row]]];
    [self.image  setCenter:CGPointMake(self.bounds.size.width * 0.1, 25)];
    [self.contentView addSubview:self.image];
    self.image.contentMode = UIViewContentModeCenter;
    
//    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(image.x + image.width + 20, 0, 200, 50)];
    self.name.frame = CGRectMake(self.image.x + self.image.width + 10, 0, 200, 50);
//    [self.name setText:oneSectionStr[indexPath.row]];
    [self.name setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:self.name];
}
//重写set方法
- (void)setItem:(ZMDetailItem *)item
{
    _item = item;
    self.image.image = [UIImage imageNamed:item.icon];
    self.name.text = item.name;
}
@end
// 
