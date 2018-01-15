//
//  Demo_10_Mask.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/15.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_10_Mask.h"

@interface Demo_10_Mask ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation Demo_10_Mask

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //create mask layer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.imageView.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"hootel_map"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    //apply mask to image layer￼
    self.imageView.layer.mask = maskLayer;
    

}

@end
