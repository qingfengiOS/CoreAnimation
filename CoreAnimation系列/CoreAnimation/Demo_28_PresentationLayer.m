//
//  Demo_28_PresentationLayer.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/19.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_28_PresentationLayer.h"

@interface Demo_28_PresentationLayer ()
@property (nonatomic, strong) CALayer *colorLayer;
@end

@implementation Demo_28_PresentationLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     用presentationLayer图层来判断当前图层位置
     */
    
    //create a red layer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //check if we've tapped the moving layer
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        //randomize the layer background color
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    } else {
        //otherwise (slowly) move the layer to new position
        [CATransaction begin];
        [CATransaction setAnimationDuration:2.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}

@end
