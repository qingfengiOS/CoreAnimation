//
//  Demo_36_DurationAndRepeatCount.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/22.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_36_DurationAndRepeatCount.h"

@interface Demo_36_DurationAndRepeatCount ()<CAAnimationDelegate>
@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UITextField *durationField;
@property (nonatomic, weak) IBOutlet UITextField *repeatField;
@property (nonatomic, weak) IBOutlet UIButton *startButton;
@property (nonatomic, strong) CALayer *shipLayer;

@end

@implementation Demo_36_DurationAndRepeatCount

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     duration（CAMediaTiming的属性之一），duration是一个CFTimeInterval的类型（类似于NSTimeInterval的一种双精度浮点类型），对将要进行的动画的一次迭代指定了时间。
     
     这里的一次迭代是什么意思呢？CAMediaTiming另外还有一个属性叫做repeatCount，代表动画重复的迭代次数。如果duration是2，repeatCount设为3.5（三个半迭代），那么完整的动画时长将是7秒。
     
     duration和repeatCount默认都是0。但这不意味着动画时长为0秒，或者0次，这里的0仅仅代表了“默认”，也就是0.25秒和1次，你可以用一个简单的测试来尝试为这两个属性赋多个值
     */
    
    //add the ship
    _shipLayer = [CALayer layer];
    _shipLayer.frame = CGRectMake(0, 0, 300, 128);
    _shipLayer.position = CGPointMake(150, 150);
    _shipLayer.contents = (__bridge id)[UIImage imageNamed: @"air"].CGImage;
    _shipLayer.contentsGravity = kCAGravityCenter;
    [self.containerView.layer addSublayer:_shipLayer];
}

- (void)setControlsEnabled:(BOOL)enabled {//设置控件的enabled
    for (UIControl *control in @[self.durationField,self.repeatField,self.startButton]) {
        control.enabled = enabled;
        control.alpha = enabled ? 1.0f : 0.25f;
    }
}

- (IBAction)hideKeyboard {
    [self.durationField resignFirstResponder];
    [self.repeatField resignFirstResponder];
}

- (IBAction)start {
    CFTimeInterval duration = [self.durationField.text doubleValue];
    float repeatCount = [self.repeatField.text floatValue];
    
    //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    animation.byValue = @(M_PI * 2);
    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:@"rotateAnimation"];
    
    //disable controls
    [self setControlsEnabled:NO];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //reenable controls
    [self setControlsEnabled:YES];
}
/*
 创建重复动画的另一种方式是使用repeatDuration属性，它让动画重复一个指定的时间，而不是指定次数。你甚至设置一个叫做autoreverses的属性（BOOL类型）在每次间隔交替循环过程中自动回放。这对于播放一段连续非循环的动画很有用
 */


@end
