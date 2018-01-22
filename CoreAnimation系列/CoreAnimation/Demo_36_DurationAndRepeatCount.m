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
    
    //add the ship
    _shipLayer = [CALayer layer];
    _shipLayer.frame = CGRectMake(0, 0, 300, 128);
    _shipLayer.position = CGPointMake(150, 150);
    _shipLayer.contents = (__bridge id)[UIImage imageNamed: @"air"].CGImage;
    _shipLayer.contentsGravity = kCAGravityCenter;
    [self.containerView.layer addSublayer:_shipLayer];
}

- (void)setControlsEnabled:(BOOL)enabled {
    for (UIControl *control in @[self.durationField,self.repeatField,self.startButton]) {
        control.enabled = enabled;
        control.alpha = enabled ? 1.0f : 0.25f;
    }
}

- (IBAction)hideKeyboard
{
    [self.durationField resignFirstResponder];
    [self.repeatField resignFirstResponder];
}

- (IBAction)start
{
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


@end
