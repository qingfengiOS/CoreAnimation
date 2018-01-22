//
//  Demo_35_CancleAnimation.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/22.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_35_CancleAnimation.h"

@interface Demo_35_CancleAnimation ()<CAAnimationDelegate>

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, strong) CALayer *shipLayer;

@end

@implementation Demo_35_CancleAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     可以用-addAnimation:forKey:方法中的key参数来在添加动画之后检索一个动画，使用如下方法：
     
     - (CAAnimation *)animationForKey:(NSString *)key;
     但并不支持在动画运行过程中修改动画，所以这个方法主要用来检测动画的属性，或者判断它是否被添加到当前图层中。
     
     为了终止一个指定的动画，你可以用如下方法把它从图层移除掉：
     
     - (void)removeAnimationForKey:(NSString *)key;
     或者移除所有动画：
     
     - (void)removeAllAnimations;
     
     动画一旦被移除，图层的外观就立刻更新到当前的模型图层的值。一般说来，动画在结束之后被自动移除，除非设置removedOnCompletion为NO，如果你设置动画在结束之后不被自动移除，那么当它不需要的时候你要手动移除它；否则它会一直存在于内存中，直到图层被销毁。
     */
    
    //add the ship
    _shipLayer = [CALayer layer];
    _shipLayer.frame = CGRectMake(0, 0, 300, 128);
    _shipLayer.position = CGPointMake(150, 150);
    _shipLayer.contents = (__bridge id)[UIImage imageNamed: @"bg"].CGImage;
    [self.containerView.layer addSublayer:_shipLayer];

}

- (IBAction)start:(id)sender {
    //animate the air rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.toValue = @(M_PI * 2);
    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:@"rotation"];
    
}

- (IBAction)stop:(id)sender {
    [self.shipLayer removeAnimationForKey:@"rotation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //log that the animation stopped
    
    NSLog(@"the animation stopped(finished:%@)",flag ? @"YES" : @"NO");
}


@end
