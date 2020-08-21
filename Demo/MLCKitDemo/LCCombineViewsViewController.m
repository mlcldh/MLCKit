//
//  LCCombineViewsViewController.m
//  MengAutoLayout
//
//  Created by menglingchao on 2020/8/13.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCCombineViewsViewController.h"
#import "Masonry.h"
#import "NSArray+MLCKit.h"

@interface LCCombineViewsViewController ()

@end

@implementation LCCombineViewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self combineViewsVertically];
    [self combineViewsHorizontally];
}
#pragma mark -
- (void)combineViewsVertically {
    NSMutableArray <UIButton *>*buttons = [NSMutableArray array];
    
    NSArray<NSString *> *titles = @[@"中国", @"美国", @"津巴布韦", @"加拿大"];
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.backgroundColor = [UIColor purpleColor];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button setTitle:obj forState:(UIControlStateNormal)];
        [buttons addObject:button];
        [self.view addSubview:button];
    }];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
    }];
    [buttons.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
    }];
    [buttons mlc_combineViewsWithAxis:(UILayoutConstraintAxisVertical) withFixedSpacing:20];
//    [buttons mlc_combineViewsWithAxis:(UILayoutConstraintAxisVertical) withFixedSpacings:@[@20, @40, @40]];
}
- (void)combineViewsHorizontally {
    NSMutableArray <UIButton *>*buttons = [NSMutableArray array];
    
    NSArray<NSString *> *titles = @[@"中国", @"美国", @"津巴布韦", @"加拿大"];
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.backgroundColor = [UIColor purpleColor];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button setTitle:obj forState:(UIControlStateNormal)];
        [buttons addObject:button];
        [self.view addSubview:button];
    }];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(350);
    }];
    [buttons.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
    }];
//    [buttons mlc_combineViewsWithAxis:(UILayoutConstraintAxisHorizontal) withFixedSpacing:20];
    [buttons mlc_combineViewsWithAxis:(UILayoutConstraintAxisHorizontal) withFixedSpacings:@[@20, @40, @40]];
}

@end
