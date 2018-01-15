//
//  Demo_04_ContentsCenter.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/15.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_04_ContentsCenter.h"

@interface Demo_04_ContentsCenter ()
@property (nonatomic, weak) IBOutlet UIView *button1;
@property (nonatomic, weak) IBOutlet UIView *button2;
@end

@implementation Demo_04_ContentsCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     “contentsCenter其实是一个CGRect，它定义了一个固定的边框和一个在图层上可拉伸的区域。 改变contentsCenter的值并不会影响到寄宿图的显示”
     */
    
    UIImage *image = [UIImage imageNamed:@"loading_1"];
    [self addStretchableImage:image withContentCenter:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.button1.layer];
    
    [self addStretchableImage:image withContentCenter:CGRectMake(0, 0.25, 0.5, 0.5) toLayer:self.button2.layer];
}


- (void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer
{
    //set image
    layer.contents = (__bridge id)image.CGImage;
    
    //set contentsCenter
    layer.contentsCenter = rect;
}



@end

