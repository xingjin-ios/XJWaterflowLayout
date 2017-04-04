//
//  MyCollectionViewCell.h
//  XJWaterflowLayout
//
//  Created by 邢进 on 2017/3/28.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import <UIKit/UIKit.h>
@class cellModel;

@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

- (void)configureCellWithModel:(cellModel *)model indexPatch:(NSIndexPath *)indexpatch;

@end
