//
//  LCUseProgressHUDViewController.m
//  LCDemo
//
//  Created by menglingchao on 2021/9/1.
//

#import "LCUseProgressHUDViewController.h"
#import "UIView+MLCKitUI.h"
#import "UIColor+MLCKit.h"
#import "MLCProgressHUD.h"

@interface LCUseProgressHUDViewController ()

@end

@implementation LCUseProgressHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addUseToastHudButton];
    [self addUseLoadingHudButton];
    [self addUseCustomHudButton];
}
#pragma mark -
- (void)addUseToastHudButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"使用Toast" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [self.view mlc_showToastWithTitle:@"这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。" afterDelay:2];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
}
- (void)addUseLoadingHudButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"使用loadingHud" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [self.view mlc_showLoadingWithTitle:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self)
            [self.view mlc_removeHud];
        });
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(150);
        make.top.equalTo(self.view).offset(100);
    }];
}
- (void)addUseCustomHudButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"使用自定义Hud" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        MLCProgressHUD *hud = [[MLCProgressHUD alloc] initForView:self.view type:(MLCProgressHUDTypeCustom)];
        hud.bezelView.backgroundColor = [UIColor mlc_colorWithHexString:@"000000" alpha:0.7];
        hud.bezelView.layer.cornerRadius = 5;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.text = @"自定义";
        
        hud.customView = titleLabel;
        hud.customViewEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
        [hud hideAfterDelay:2];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(150);
    }];
}

@end
