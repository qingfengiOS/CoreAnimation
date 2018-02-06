//
//  Demo_44_LineBuffer.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/6.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_44_LineBuffer.h"

@interface Demo_44_LineBuffer ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *ballView;
@end

@implementation Demo_44_LineBuffer

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     在Demo_43_ComplexAnimationLine中，我们把动画分割成相当大的几块，然后用Core Animation的缓冲进入和缓冲退出函数来大约形成我们想要的曲线。但如果我们把动画分割成更小的几部分，那么我们就可以用直线来拼接这些曲线（也就是线性缓冲）。为了实现自动化，我们需要知道如何做如下两件事情：
     
     自动把任意属性动画分割成多个关键帧
     用一个数学函数表示弹性动画，使得可以对帧做便宜
     
     */
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(50, 64, 300, 300)];
    [self.view addSubview:self.containerView];
    
    self.ballView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock"]];
    self.ballView.frame = CGRectMake(120, 20, 30, 30);
    [self.containerView addSubview:self.ballView];
}

- (void)animation {
    //reset ball to top of screen
    self.ballView.center = CGPointMake(150, 32);

    //set up animation parameters
    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];//初始位置
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];//结束位置

    CFTimeInterval duration = 1.0;

    //generate keyframes
    NSInteger numFrames = duration * 60.0;

    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < numFrames; i++) {
        float time = 1 / (float)numFrames * i;

        time = bounceEaseOut2(time);//动感弹球，改善效果

        [frames addObject:[self interpolaterFromValue2:fromValue toValue:toValue time:time]];
    }

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.values = frames;
    [self.ballView.layer addAnimation:animation forKey:nil];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self animation];
}


float interpolate2(float from, float to, float time) {
    return (to - from) * time + from;
}

- (id)interpolaterFromValue2:(id)fromValue toValue:(id)toValue time:(float)time {
    /*
     我们在示例中仅仅引入了对CGPoint类型的插值代码。但是，从代码中很清楚能看出如何扩展成支持别的类型。作为不能识别类型的备选方案，我们仅仅在前一半返回了fromValue，在后一半返回了toValue。
     */

    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate2(from.x,to.x,time), interpolate2(from.y,to.y,time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    //provide safe default implementation
    return (time < 0.5) ? fromValue : toValue;
}



/*
 “这可以起到作用，但效果并不是很好，到目前为止我们所完成的只是一个非常复杂的方式来使用线性缓冲复制CABasicAnimation的行为。这种方式的好处在于我们可以更加精确地控制缓冲，这也意味着我们可以应用一个完全定制的缓冲函数。那么该如何做呢？

 缓冲背后的数学并不很简单，但是幸运的是我们不需要一一实现它。罗伯特·彭纳有一个网页关于缓冲函数（http://www.robertpenner.com/easing），包含了大多数普遍的缓冲函数的多种编程语言的实现的链接，包括C。这里是一个缓冲进入缓冲退出函数的示例（实际上有很多不同的方式去实现它）。
 */

//改善效果
float quadraticEaseInOut2(float t) {
    return (t < 0.5) ? (2 * t * t) : (-2 * t * t) + (4 * t) - 1;
}
//动感弹球，改善效果
float bounceEaseOut2(float t) {
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

