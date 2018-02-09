//
//  Demo_50_BlackBorad.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/2/9.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "Demo_50_BlackBorad.h"
#import "Demo_50_BlackBorad_View.h"

@interface Demo_50_BlackBorad ()

@end

@implementation Demo_50_BlackBorad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Demo_50_BlackBorad_View *view = [[Demo_50_BlackBorad_View alloc]initWithFrame:self.view.frame];
    [self.view addSubview:view];
}

@end
