//
//  Demo_46_CADisplayLink.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/7.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_46_CADisplayLink.h"

@interface Demo_46_CADisplayLink ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *ballView;

@property (nonatomic, strong) CADisplayLink *timer;

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval timeOffset;
@property (nonatomic, assign) CFTimeInterval lastStep;

@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;
@end

@implementation Demo_46_CADisplayLink

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     CADisplayLink有一个整型的frameInterval属性，指定了间隔多少帧之后才执行。默认值是1，意味着每次屏幕更新之前都会执行一次。但是如果动画的代码执行起来超过了六十分之一秒，你可以指定frameInterval为2，就是说动画每隔一帧执行一次（一秒钟30帧）或者3，也就是一秒钟20次
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
    //reset ball to top of screen
    self.ballView.center = CGPointMake(150, 32);
    
    self.duration = 1.0;
    self.timeOffset = 0.0;
    
    //set up animation parameters
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];//初始位置
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];//结束位置
    
    //stop the timer if it is already running
    [self.timer invalidate];
    
    //start the timer
    self.lastStep = CACurrentMediaTime();
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step:)];
    
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)step:(CADisplayLink *)timer {
    
    //calculate time delta
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    
    self.lastStep = thisStep;
    
    //update time offest
    self.timeOffset = MIN(self.timeOffset + stepDuration, self.duration);
    
    //get normalized time offset (in range 0 - 1)
    float time = self.timeOffset / self.duration;
    
     //apply easing
    time = easeOut(time);
    
    //interpolate position
    id position = [self interpolatFromValue:self.fromValue toValue:self.toValue
                                         time:time];
    //move ball view to new position
    self.ballView.center = [position CGPointValue];
    //stop the timer if we've reached the end of the animation
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

//动感弹球，改善效果
float easeOut(float t) {
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

- (id)interpolatFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [(NSValue *)fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolat(from.x, to.x, time), interpolat(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}

float interpolat(float from, float to, float time) {
    return (to - from) * time + from;
}

@end
