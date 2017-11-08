//
//  ZMTreatureCollectionViewCell.m
//  Chapper
//
//  Created by liyongfei on 2017/11/7.
//  Copyright © 2017年 liyongfei. All rights reserved.
//

#import "ZMTreatureCollectionViewCell.h"


@interface ZMTreatureCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *personLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (weak, nonatomic) IBOutlet UILabel *inforLabel;

@property (weak, nonatomic) IBOutlet UIImageView *footImage;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@end

@implementation ZMTreatureCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
