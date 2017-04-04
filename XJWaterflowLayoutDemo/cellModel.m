//
//  cellModel.m
//  XJWaterflowLayout
//
//  Created by 邢进 on 2017/3/28.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "cellModel.h"

@implementation cellModel


+(cellModel *)createCellmodel {
    cellModel *model = [cellModel new];
    model.ww = [self randFloatBetween:100 and:280];
    model.hh = [self randFloatBetween:150 and:400];
    int i = arc4random()%7;
    model.icon = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
    return model;
}

+(float)randFloatBetween:(float)low and:(float)high
{
    float diff = high - low;
    return (((float) rand() / RAND_MAX) * diff) + low;
}

@end
