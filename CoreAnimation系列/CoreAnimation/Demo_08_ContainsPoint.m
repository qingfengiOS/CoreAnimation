//
//  Demo_08_ContainsPoint.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/15.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_08_ContainsPoint.h"

@interface Demo_08_ContainsPoint ()
@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *blueLayer;
@end

@implementation Demo_08_ContainsPoint

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layerView = [[UIView alloc]initWithFrame:CGRectMake(20, 100, 200, 200)];
    _layerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.layerView];
    
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:self.blueLayer];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //get touch position relative to main view
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //
    point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
    if ([self.layerView.layer containsPoint:point]) {//
        NSLog(@"Inside Blue Layer");
    } else {
        NSLog(@"Inside Yellow Layer");
    }
}


@end

