//
//  Demo_40_TimingFunction.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/23.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_40_TimingFunction.h"

@interface Demo_40_TimingFunction ()
@property (nonatomic, strong) CALayer *colorLayer;
@end

@implementation Demo_40_TimingFunction

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     动画实际上就是一段时间内的变化，这就暗示了变化一定是随着某个特定的速率进行。速率由以下公式计算而来：
     
     velocity = change / time
     
     这里的变化可以指的是一个物体移动的距离，时间指动画持续的时长，用这样的一个移动可以更加形象的描述（比如position和bounds属性的动画），但实际上它应用于任意可以做动画的属性（比如color和opacity）。
     
     首先需要设置CAAnimation的timingFunction属性，是CAMediaTimingFunction类的一个对象。如果想改变隐式动画的计时函数，同样也可以使用CATransaction的+setAnimationTimingFunction:方法。
     
     这里有一些方式来创建CAMediaTimingFunction，最简单的方式是调用+timingFunctionWithName:的构造方法。这里传入如下几个常量之一：
     
     kCAMediaTimingFunctionLinear
     kCAMediaTimingFunctionEaseIn
     kCAMediaTimingFunctionEaseOut
     kCAMediaTimingFunctionEaseInEaseOut
     kCAMediaTimingFunctionDefault
     */
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = self.view.center;
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    self.colorLayer.position = [[touches anyObject]locationInView:self.view];
    [CATransaction commit];
    
}



@end
