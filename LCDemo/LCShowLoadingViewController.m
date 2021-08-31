//
//  LCShowLoadingViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2021/1/22.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "LCShowLoadingViewController.h"
#import "Masonry.h"
#import "UIView+MLCKitUI.h"
#import "UIControl+MLCKit.h"
#import "MLCMacror.h"

@interface LCShowLoadingViewController ()

@end

@implementation LCShowLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showActivityIndicatorStyleLoading];
}
#pragma mark -
- (void)showActivityIndicatorStyleLoading {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [button setTitle:@"显示白色菊花loading" forState:(UIControlStateNormal)];
    @weakify(button)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(button)
        [button mlc_showActivityIndicatorStyleLoadingWithHandler:^(UIActivityIndicatorView *activityIndicatorView) {
//            if (@available(iOS 13.0, *)) {
//                activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
//            } else {
//                activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
//            }
//            activityIndicatorView.color = [UIColor lightGrayColor];
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(button)
            [button mlc_hideActivityIndicatorStyleLoading];
        });
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
        make.height.mas_equalTo(40);
    }];
}

@end
