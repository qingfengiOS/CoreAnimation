//
//  Demo_41_TimingFunctions.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/23.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_41_TimingFunctions.h"

@interface Demo_41_TimingFunctions ()

@property (nonatomic, strong)  CALayer *colorLayer;
@property (nonatomic, strong)  UIView *layerView;

@end

@implementation Demo_41_TimingFunctions

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     CAKeyframeAnimation有一个NSArray类型的timingFunctions属性，我们可以用它来对每次动画的步骤指定不同的计时函数。但是指定函数的个数一定要等于keyframes数组的元素个数减一，因为它是描述每一帧之间动画速度的函数。
     
     在这个例子中，我们自始至终想使用同一个缓冲函数，但我们同样需要一个函数的数组来告诉动画不停地重复每个步骤，而不是在整个动画序列只做一次缓冲，我们简单地使用包含多个相同函数拷贝的数组就可以了
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
    
    //add timingFunctions
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions = @[fn,fn,fn];
    
    //add animation
    [self.colorLayer addAnimation:animation forKey:nil];
}

@end
