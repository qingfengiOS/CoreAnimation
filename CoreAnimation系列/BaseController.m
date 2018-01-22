//
//  BaseController.m
//  CoreAnimation系列
//
//  Created by iosyf-02 on 2018/1/15.
//  Copyright © 2018年 情风. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
