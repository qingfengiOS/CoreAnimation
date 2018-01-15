//
//  Demo_01_Layer.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/15.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_01_Layer.h"

@interface Demo_01_Layer ()

@property (nonatomic, strong) UIView *layerView;

@end

@implementation Demo_01_Layer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 80, 200, 200)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    blueLayer.backgroundColor = [[UIColor blueColor] CGColor];
    [view.layer addSublayer:blueLayer];
    
}

@end
