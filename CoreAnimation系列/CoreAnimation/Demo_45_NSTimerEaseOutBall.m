//
//  Demo_45_NSTimerEaseOutBall.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/6.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_45_NSTimerEaseOutBall.h"

@interface Demo_45_NSTimerEaseOutBall ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *ballView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval timeOffset;

@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;
@end

@implementation Demo_45_NSTimerEaseOutBall

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     由于现在我们在定时器启动之后连续计算动画帧，我们需要在类中添加一些额外的属性来存储动画的fromValue，toValue，duration和当前的timeOffset。
     */
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(50, 64, 300, 300)];
    [self.view addSubview:self.containerView];
    
    self.ballView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock"]];
    self.ballView.frame = CGRectMake(120, 20, 30, 30);
    [self.containerView addSubview:self.ballView];
    
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
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0
                                                  target:self
                                                selector:@selector(step:)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    
}

- (void)step:(NSTimer *)step {
    //update time offset
    self.timeOffset = MIN(self.timeOffset + 1 / 60.0f, self.duration);//千万注意这里的60必需写成浮点数,否则两个整数相除结果我0，球永远不动
    
    //get normalized time offset (in range 0 - 1)
    float time = self.timeOffset / self.duration;
    
    //apply easing
    time = bounceEaseOut(time);
    
    //interpolate position
    id position = [self interpolateFromValue:self.fromValue toValue:self.toValue time:time];
    
    //move ball view to new position
    self.ballView.center = [position CGPointValue];
    
    //stop the timer if we've reached the end of the animation
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self animate];
}

float interpolate(float from, float to, float time) {
    return (to - from) * time + from;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [(NSValue *)fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}

//动感弹球，改善效果
float bounceEaseOut(float t) {
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}


@end
