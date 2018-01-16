//
//  Demo_14_CATransform3D.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/16.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_14_CATransform3D.h"

@interface Demo_14_CATransform3D ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation Demo_14_CATransform3D

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 = -1.0 / 500.0f;
    
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);//绕Y转180° 显示的就是背面了
    
    /*
     CALayer有一个叫做doubleSided的属性来控制图层的背面是否要被绘制。这是一个BOOL类型，默认为YES，如果设置为NO,那么当图层正面从相机视角消失的时候，它将不会被绘制。
     */
    self.imageView.layer.doubleSided = YES;
    
    self.imageView.layer.transform = transform;

    /*
     看起来图层并没有被旋转，而是仅仅在水平方向上的一个压缩，是哪里出了问题呢？
     
     其实完全没错，视图看起来更窄实际上是因为我们在用一个斜向的视角看它，而不是透视。
     */
    
    /*
     在真实世界中，当物体远离我们的时候，由于视角的原因看起来会变小，理论上说远离我们的视图的边要比靠近视角的边跟短，但实际上并没有发生，而我们当前的视角是等距离的，也就是在3D变换中任然保持平行，和之前提到的仿射变换类似。
     
     为了做一些修正，我们需要引入投影变换（又称作z变换）来对除了旋转之外的变换矩阵做一些修改，Core Animation并没有给我们提供设置透视变换的函数，因此我们需要手动修改矩阵值，幸运的是，很简单：
     
     CATransform3D的透视效果通过一个矩阵中一个很简单的元素来控制：m34。m34用于按比例缩放X和Y的值来计算到底要离视角多远。”
      */
    
    /*
     m34的默认值是0，我们可以通过设置m34为-1.0 / d来应用透视效果，d代表了想象中视角相机和屏幕之间的距离，以像素为单位，那应该如何计算这个距离呢？实际上并不需要，大概估算一个就好了”
     */
    
}


@end
