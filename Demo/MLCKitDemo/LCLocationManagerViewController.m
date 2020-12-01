//
//  LCLocationManagerViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/12/1.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCLocationManagerViewController.h"
#import "Masonry.h"
//#import "MLCMacror.h"
#import "UIControl+MLCKit.h"
#import "MLCLocationManager.h"

@interface LCLocationManagerViewController ()

@end

@implementation LCLocationManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addGetLocationButton];
}
#pragma mark -
- (void)addGetLocationButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"获取定位" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [[MLCLocationManager sharedInstance]getLocation];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
}

@end
