//
//  LCUseAnnularViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2021/2/1.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "LCUseAnnularViewController.h"
#import "MLCAnnularView.h"

@interface LCUseAnnularViewController ()

@end

@implementation LCUseAnnularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self useLCSAnnularView];
    [self useLCSAnnularView2];
    [self useLCSAnnularView3];
    [self useLCSAnnularView4];
}
#pragma mark -
- (void)useLCSAnnularView {//圆环
    CGFloat width = 100;
    MLCAnnularView *annularView = [[MLCAnnularView alloc] initWithStrokeThickness:6 width:width rounded:YES];
    annularView.line.shapeLayer.lineCap = kCALineCapRound;
    annularView.line.shapeLayer.strokeEnd = 0.3;//环结束位置
    [self.view addSubview:annularView];
    [annularView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
        make.width.height.mas_equalTo(width);
    }];
}
- (void)useLCSAnnularView2 {//四角圆环
    CGFloat width = 200;
    CGFloat height = 100;
    MLCAnnularView *annularView = [[MLCAnnularView alloc] initWithStrokeThickness:6 width:width height:height rounded:YES];
    annularView.line.shapeLayer.strokeEnd = 0.3;//环结束位置
    [self.view addSubview:annularView];
    [annularView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(250);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
}
- (void)useLCSAnnularView3 {//四角圆环
    CGFloat width = 200;
    CGFloat height = 100;
    MLCAnnularView *annularView = [[MLCAnnularView alloc]initWithStrokeThickness:6 width:width height:height rounded:NO];
    annularView.line.shapeLayer.strokeEnd = 0.3;//环结束位置
    [self.view addSubview:annularView];
    [annularView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(400);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
}
- (void)useLCSAnnularView4 {//饼形图
    CGFloat width = 100;
    MLCAnnularView *annularView = [[MLCAnnularView alloc]initWithStrokeThickness:width / 2 width:width rounded:YES];
    annularView.line.shapeLayer.strokeEnd = 0.3;//环结束位置
    [self.view addSubview:annularView];
    [annularView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(550);
        make.width.height.mas_equalTo(width);
    }];
}

@end
