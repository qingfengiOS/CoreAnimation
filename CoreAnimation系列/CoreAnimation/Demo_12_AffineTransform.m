//
//  Demo_12_AffineTransform.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/16.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_12_AffineTransform.h"

@interface Demo_12_AffineTransform ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

#define RADIANS_TO_DEGREES(x) ((x)/M_PI*180.0)

@implementation Demo_12_AffineTransform

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     当对图层应用变换矩阵，图层矩形内的每一个点都被相应地做变换，从而形成一个新的四边形的形状。CGAffineTransform中的“仿射”的意思是无论变换矩阵用什么值，图层中平行的两条线在变换之后任然保持平行
    */
    CGAffineTransform transform = CGAffineTransformMakeRotation(RADIANS_TO_DEGREES(45));
    self.imageView.layer.affineTransform = transform;
    
}

@end
