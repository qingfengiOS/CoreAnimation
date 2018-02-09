//
//  Demo_49_Draw_CAShapeLayer_View.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/9.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_49_Draw_CAShapeLayer_View.h"

@implementation Demo_49_Draw_CAShapeLayer_View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.path = [UIBezierPath bezierPath];
        //configure the layer
        CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineWidth = 3.0f;
    }
    return self;
}

+ (Class)layerClass {
    
    //this makes our view create a CAShapeLayer
    //instead of a CALayer for its backing layer
    return [CAShapeLayer class];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //get the starting point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //move the path drawing cursor to the starting point
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //get the current point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //add a new line segment to our path
    [self.path addLineToPoint:point];
    
    //update the layer with a copy of the path
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
}

@end
