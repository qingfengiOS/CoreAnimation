//
//  Demo_38_TimeOffsetAndSpeed.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/23.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_38_TimeOffsetAndSpeed.h"

@interface Demo_38_TimeOffsetAndSpeed ()
@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UILabel *speedLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeOffsetLabel;
@property (nonatomic, weak) IBOutlet UISlider *speedSlider;
@property (nonatomic, weak) IBOutlet UISlider *timeOffsetSlider;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CALayer *shipLayer;
@end

@implementation Demo_38_TimeOffsetAndSpeed

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     beginTime指定了动画开始之前的的延迟时间。这里的延迟从动画添加到可见图层的那一刻开始测量，默认是0（就是说动画会立刻执行）。
     
     speed是一个时间的倍数，默认1.0，减少它会减慢图层/动画的时间，增加它会加快速度。如果2.0的速度，那么对于一个duration为1的动画，实际上在0.5秒的时候就已经完成了。
     
     timeOffset和beginTime类似，但是和增加beginTime导致的延迟动画不同，增加timeOffset只是让动画快进到某一点，例如，对于一个持续1秒的动画来说，设置timeOffset为0.5意味着动画将从一半的地方开始。
     
     和beginTime不同的是，timeOffset并不受speed的影响。所以如果你把speed设为2.0，把timeOffset设置为0.5，那么你的动画将从动画最后结束的地方开始，因为1秒的动画实际上被缩短到了0.5秒。然而即使使用了timeOffset让动画从结束的地方开始，它仍然播放了一个完整的时长，这个动画仅仅是循环了一圈，然后从头开始播放。
     */
    
    self.bezierPath = [UIBezierPath bezierPath];
    [self.bezierPath moveToPoint:CGPointMake(20,150)];
    [self.bezierPath addCurveToPoint:CGPointMake(300,150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //划弧线
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.fillColor = [UIColor whiteColor].CGColor;
    pathLayer.strokeColor =  [UIColor redColor].CGColor;
    pathLayer.path = self.bezierPath.CGPath;
    pathLayer.lineWidth = 3;
    [self.containerView.layer addSublayer:pathLayer];
    
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(20, 150, 50, 50);
    self.shipLayer.position = CGPointMake(20, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed: @"air"].CGImage;
    self.shipLayer.contentsGravity = kCAGravityCenter;
    [self.containerView.layer addSublayer:self.shipLayer];
    
}


- (IBAction)updateSlider:(id)sender {
    CFTimeInterval timeOffset = self.timeOffsetSlider.value;
    self.timeOffsetLabel.text = [NSString stringWithFormat:@"%0.2f", timeOffset];
    
    float speed = self.speedSlider.value;
    self.speedLabel.text = [NSString stringWithFormat:@"%0.2f", speed];

}

- (IBAction)play:(id)sender {
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc]init];
    animation.keyPath = @"position";
    animation.path = self.bezierPath.CGPath;
    animation.timeOffset = self.timeOffsetSlider.value;
    animation.speed = self.speedSlider.value;
    animation.duration = 1.0;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.removedOnCompletion = NO;
    [self.shipLayer addAnimation:animation forKey:@"slide"];
}

@end
