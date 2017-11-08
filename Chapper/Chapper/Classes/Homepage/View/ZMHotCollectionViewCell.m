//
//  ZMHotCollectionViewCell.m
//  Chapper
//
//  Created by liyongfei on 2017/11/6.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMHotCollectionViewCell.h"

@interface ZMHotCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *inforLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *beforMoneyLabel;

@end

@implementation ZMHotCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
