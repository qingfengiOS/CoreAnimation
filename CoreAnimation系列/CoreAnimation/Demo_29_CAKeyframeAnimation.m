//
//  Demo_29_CAKeyframeAnimation.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/22.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_29_CAKeyframeAnimation.h"

@interface Demo_29_CAKeyframeAnimation ()
@property (nonatomic, strong)  CALayer *colorLayer;
@property (nonatomic, strong)  UIView *layerView;
@end

@implementation Demo_29_CAKeyframeAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     CAKeyframeAnimation是另一种UIKit没有暴露出来但功能强大的类。和CABasicAnimation类似，CAKeyframeAnimation同样是CAPropertyAnimation的一个子类，它依然作用于单一的一个属性，但是和CABasicAnimation不一样的是，它不限制于设置一个起始和结束的值，而是可以根据一连串随意的值来做动画。
     
     关键帧起源于传动动画，意思是指主导的动画在显著改变发生时重绘当前帧（也就是关键帧），每帧之间剩下的绘制（可以通过关键帧推算出）将由熟练的艺术家来完成。CAKeyframeAnimation也是同样的道理：你提供了显著的帧，然后Core Animation在每帧之间进行插入。
     */
    
    self.layerView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:self.layerView];
    
    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 70.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
    
    UIButton *changBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changBtn.frame = CGRectMake(100, 300, 200, 50);
    [changBtn setTitle:@"changeColor" forState:UIControlStateNormal];
    [changBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changBtn];
}

- (void)change {
    
    //Create a keyFrame animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0f;
    animation.values = @[(__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor];
    [self.colorLayer addAnimation:animation forKey:nil];
    
    /*
     “注意到序列中开始和结束的颜色都是蓝色，这是因为CAKeyframeAnimation并不能自动把当前值作为第一帧（就像CABasicAnimation那样把fromValue设为nil）。动画会在开始的时候突然跳转到第一帧的值，然后在动画结束的时候突然恢复到原始的值。所以为了动画的平滑特性，我们需要开始和结束的关键帧来匹配当前属性的值。
     
     当然可以创建一个结束和开始值不同的动画，那样的话就需要在动画启动之前手动更新属性和最后一帧的值保持一致，就和之前讨论的一样。
     
     我们用duration属性把动画时间从默认的0.25秒增加到2秒，以便于动画做的不那么快。运行它，你会发现动画通过颜色不断循环，但效果看起来有些奇怪。原因在于动画以一个恒定的步调在运行。当在每个动画之间过渡的时候并没有减速，这就产生了一个略微奇怪的效果，为了让动画看起来更自然，我们需要调整一下缓冲，第十章将会详细说明。
     */
}

@end
