//
//  Demo_03_ContentsRect.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/15.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_03_ContentsRect.h"

@interface Demo_03_ContentsRect ()

@property (nonatomic, weak) IBOutlet UIView *coneView;
@property (nonatomic, weak) IBOutlet UIView *shipView;
@property (nonatomic, weak) IBOutlet UIView *iglooView;
@property (nonatomic, weak) IBOutlet UIView *anchorView;

@end

@implementation Demo_03_ContentsRect

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    UIImage *image = [UIImage imageNamed:@"loading_1"];
    //    [self addSpriteImage:image contentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.iglooView.layer];
    
    UIImage *image = [UIImage imageNamed:@"loading_1"];
    //set igloo sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.iglooView.layer];
    //set cone sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.coneView.layer];
    //set anchor sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.anchorView.layer];
    //set spaceship sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.shipView.layer];
}

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer {
    layer.contents = (__bridge id _Nullable)(image.CGImage);
    layer.contentsGravity = kCAGravityCenter;
    layer.contentsRect = rect;
}

@end

