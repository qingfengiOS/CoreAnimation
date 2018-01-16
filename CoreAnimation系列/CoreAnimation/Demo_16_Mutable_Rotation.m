//
//  Demo_16_Mutable_Rotation.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/16.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_16_Mutable_Rotation.h"

@interface Demo_16_Mutable_Rotation ()

@property (nonatomic, weak) IBOutlet UIView *outerView;
@property (nonatomic, weak) IBOutlet UIView *innerView;

@end

@implementation Demo_16_Mutable_Rotation

- (void)viewDidLoad {
    [super viewDidLoad];

    //rotate the outer layer 45 degrees
    CATransform3D outer = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    self.outerView.layer.transform = outer;
    
    //rotate the inner layer -45 degrees
    CATransform3D inner = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    self.innerView.layer.transform = inner;
    
    /*care:
         1、当旋转外部图层时，内部和外部一起旋转
         2、再次旋转内部时，抵消掉刚刚旋转的角度，但是不会影响外部
     */
}

@end
