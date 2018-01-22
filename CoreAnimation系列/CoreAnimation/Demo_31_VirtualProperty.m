//
//  Demo_30_VirtualProperty.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/22.
//  Copyright © 2018年 情风. All rights reserved.
//
// 虚拟属性
#import "Demo_31_VirtualProperty.h"

@interface Demo_31_VirtualProperty (){
    CALayer *shipLayer;
}
@property (nonatomic, strong) UIView *containerView;
@end

@implementation Demo_31_VirtualProperty

- (void)viewDidLoad {
    [super viewDidLoad];

    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(50, 64, 300, 300)];
    [self.view addSubview:self.containerView];
    
    UISwitch *swith = [[UISwitch alloc]initWithFrame:CGRectMake(120, 370, 60, 30)];
    [self.view addSubview:swith];
    [swith addTarget:self action:@selector(swithAction:) forControlEvents:UIControlEventValueChanged];

    //add the ship
    shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 128, 128);
    shipLayer.position = CGPointMake(150, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"air"].CGImage;
    shipLayer.contentsGravity = kCAGravityCenter;
    [self.containerView.layer addSublayer:shipLayer];
    
}

- (void)transform {//用transform属性对图层做动画
    
    //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform";
    animation.duration = 2.0;
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    [shipLayer addAnimation:animation forKey:nil];
    
    /*
     如果我们把旋转的值从M_PI（180度）调整到2 * M_PI（360度），然后运行程序，会发现这时候飞船完全不动了。这是因为这里的矩阵做了一次360度的旋转，和做了0度是一样的，所以最后的值根本没变。
     
     现在继续使用M_PI，但这次用byValue而不是toValue。也许你会认为这和设置toValue结果一样，因为0 + 90度 == 90度，但实际上飞船的图片变大了，并没有做任何旋转，这是因为变换矩阵不能像角度值那样叠加。
     
     那么如果需要独立于角度之外单独对平移或者缩放做动画呢？由于都需要我们来修改transform属性，实时地重新计算每个时间点的每个变换效果，然后根据这些创建一个复杂的关键帧动画，这一切都是为了对图层的一个独立做一个简单的动画。
     
     幸运的是，有一个更好的解决方案：为了旋转图层，我们可以对transform.rotation关键路径应用动画，而不是transform本身 见transformRotationf方法
     */
   
}

- (void)transformRotation {//对虚拟的transform.rotation属性做动画

    //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    [shipLayer addAnimation:animation forKey:nil];
}

- (void)swithAction:(UISwitch *)waySwitch {
    if (waySwitch.isOn) {
        [self transform];
    } else {
        [self transformRotation];
    }
}
/*
 用transform.rotation而不是transform做动画的好处如下：
 
 1、我们可以不通过关键帧一步旋转多于180度的动画。
 2、可以用相对值而不是绝对值旋转（设置byValue而不是toValue）。
 3、可以不用创建CATransform3D，而是使用一个简单的数值来指定角度。
 4、不会和transform.position或者transform.scale冲突（同样是使用关键路径来做独立的动画属性）。
 
 */


@end
