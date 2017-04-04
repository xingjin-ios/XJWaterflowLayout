//
//  cellModel.h
//  XJWaterflowLayout
//
//  Created by 邢进 on 2017/3/28.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface cellModel : NSObject

@property (nonatomic, assign)float hh;//高
@property (nonatomic, assign)float ww;//宽
@property (nonatomic, strong)UIImage *icon;

+(cellModel *)createCellmodel;

@end
