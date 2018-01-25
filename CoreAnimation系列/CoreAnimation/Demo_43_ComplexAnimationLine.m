//
//  Demo_43_ComplexAnimationLine.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/25.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_43_ComplexAnimationLine.h"

@interface Demo_43_ComplexAnimationLine ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *ballView;
@end

@implementation Demo_43_ComplexAnimationLine

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     考虑一个橡胶球掉落到坚硬的地面的场景，当开始下落的时候，它会持续加速知道落到地面，然后经过几次反弹，最后停下来。这种效果没法用一个简单的三次贝塞尔曲线表示，于是不能用CAMediaTimingFunction来完成。但如果想要实现这样的效果，可以用如下几种方法：
     
     1、用CAKeyframeAnimation创建一个动画，然后分割成几个步骤，每个小步骤使用自己的计时函数。
     2、使用定时器逐帧更新实现动画。
     */
    [self useCAKeyframeAnimation];
    
}

- (void)useCAKeyframeAnimation {//使用关键帧实现反弹球的动画
    /*
     为了使用关键帧实现反弹动画，我们需要在缓冲曲线中对每一个显著的点创建一个关键帧（在这个情况下，关键点也就是每次反弹的峰值），然后应用缓冲函数把每段曲线连接起来。同时，我们也需要通过keyTimes来指定每个关键帧的时间偏移，由于每次反弹的时间都会减少，于是关键帧并不会均匀分布。
     */
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(50, 64, 300, 300)];
    [self.view addSubview:self.containerView];
    
    self.ballView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock"]];
    self.ballView.frame = CGRectMake(120, 20, 30, 30);
    [self.containerView addSubview:self.ballView];
    
    [self animate];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self animate];
}

- (void)animate {
    self.ballView.frame = CGRectMake(120, 20, 30, 30);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0f;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(150, 32)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 140)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 220)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 250)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         ];
    animation.timingFunctions = @[
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                  ];
    animation.keyTimes = @[
                           @0.0,
                           @0.3,
                           @0.5,
                           @0.7,
                           @0.8,
                           @0.9,
                           @0.95,
                           @1.0,
                           ];
    
    self.ballView.layer.position = CGPointMake(150, 268);
    [self.ballView.layer addAnimation:animation forKey:nil];
    
}

@end
