//
//  MyCollectionViewCell.m
//  XJWaterflowLayout
//
//  Created by 邢进 on 2017/3/28.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "cellModel.h"

@implementation MyCollectionViewCell

- (void)configureCellWithModel:(cellModel *)model indexPatch:(NSIndexPath *)indexpatch {
    self.myImageView.image = model.icon;
    self.myLabel.text = [NSString stringWithFormat:@"row = %ld", indexpatch.row];
}

@end
