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
    [self distributeViewsEqualCenterSpacingHorizontally];
}
#pragma mark -
- (void)combineViewsVertically {
    NSMutableArray <UIButton *>*buttons = [NSMutableArray array];
    
    NSArray<NSString *> *titles = @[@"中国", @"美国", @"津巴布韦\n非洲", @"加拿大"];
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
    {
        [buttons.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(100);
        }];
        [buttons mlc_combineViewsWithAxis:(UILayoutConstraintAxisVertical) withFixedSpacing:20];
//        [buttons mlc_combineViewsWithAxis:(UILayoutConstraintAxisVertical) withFixedSpacings:@[@20, @40, @40]];
    }
    
//    {
//        [buttons mlc_distributeViewsEqualCenterSpacingWithAxis:(UILayoutConstraintAxisVertical) leadCenterSpacing:120 tailCenterSpacing:600];
//    }
    
}
- (void)combineViewsHorizontally {
    NSMutableArray <UIButton *>*buttons = [NSMutableArray array];
    
    NSArray<NSString *> *titles = @[@"中国", @"美国", @"津巴布韦", @"加拿大"];
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.backgroundColor = [UIColor orangeColor];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button setTitle:obj forState:(UIControlStateNormal)];
        [buttons addObject:button];
        [self.view addSubview:button];
    }];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(250);
    }];
    [buttons.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
    }];
    [buttons mlc_combineViewsWithAxis:(UILayoutConstraintAxisHorizontal) withFixedSpacing:20];
//    [buttons mlc_combineViewsWithAxis:(UILayoutConstraintAxisHorizontal) withFixedSpacings:@[@20, @40, @40]];
}
- (void)distributeViewsEqualCenterSpacingHorizontally {
    NSMutableArray <UIButton *>*buttons = [NSMutableArray array];
    
//    NSArray<NSString *> *titles = @[@"中国", @"美国", @"津巴布韦", @"加拿大"];
    NSArray<NSString *> *titles = @[@"中国", @"美国", @"津巴布韦名字长"];
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.backgroundColor = [UIColor cyanColor];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button setTitle:obj forState:(UIControlStateNormal)];
        [buttons addObject:button];
        [self.view addSubview:button];
    }];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
    }];
    [buttons mlc_distributeViewsEqualCenterSpacingWithAxis:(UILayoutConstraintAxisHorizontal) leadCenterSpacing:100 tailCenterSpacing:100];
}

@end
