//
//  Demo_39_TimeOff.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/23.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_39_TimeOff.h"

@interface Demo_39_TimeOff ()<UIGestureRecognizerDelegate>{
    CALayer *doorLayer;
}
@property (nonatomic, strong) UIView *containerView;
@end

@implementation Demo_39_TimeOff

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     timeOffset一个很有用的功能在于你可以它可以让你手动控制动画进程，通过设置speed为0，可以禁用动画的自动播放，然后来使用timeOffset来来回显示动画序列。这可以使得运用手势来手动控制动画变得很简单。
     */
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(50, 64, 300, 300)];
    [self.view addSubview:self.containerView];
    
    doorLayer = [CALayer layer];
    doorLayer.frame = CGRectMake(0, 0, 128, 256);
    doorLayer.position = CGPointMake(150 - 64, 150);
    doorLayer.anchorPoint = CGPointMake(0, 0.5);
    doorLayer.contents = (__bridge id)[UIImage imageNamed: @"door"].CGImage;
    [self.containerView.layer addSublayer:doorLayer];
    
    //apply perspective transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    panGes.delegate = self;
    [self.view addGestureRecognizer:panGes];
    
    doorLayer.speed = 0.0;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0;
    [doorLayer addAnimation:animation forKey:nil];
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    
    //get horizontal component of pan gesture
    CGFloat x = [pan translationInView:self.view].x;
    NSLog(@"x = %f",x);
    //convert from points to animation duration
    //using a reasonable scale factor
    x /= 200.0f;
    
    CFTimeInterval timeOffset = doorLayer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    doorLayer.timeOffset = timeOffset;
    [pan setTranslation:CGPointZero inView:self.view];
    
}

@end
