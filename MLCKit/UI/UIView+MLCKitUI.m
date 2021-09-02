//
//  UIView+MLCKitUI.m
//  MLCKit
//
//  Created by menglingchao on 2021/1/22.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "UIView+MLCKitUI.h"
#import <objc/runtime.h>
#import "Masonry.h"
#import "UIColor+MLCKit.h"
#import "MLCProgressHUD.h"

@interface UIView ()

@property (nonatomic, strong) UIView *mlc_activityIndicatorBGView;
@property (nonatomic, strong) UIActivityIndicatorView *mlc_activityIndicatorView;

@end

@implementation UIView (MLCKitUI)

#pragma mark - Getter
- (UIView *)mlc_activityIndicatorBGView {
    return objc_getAssociatedObject(self, _cmd);
}
- (UIActivityIndicatorView *)mlc_activityIndicatorView {
    return objc_getAssociatedObject(self, _cmd);
}
#pragma mark - Setter
- (void)setMlc_activityIndicatorBGView:(UIView *)mlc_activityIndicatorBGView {
    objc_setAssociatedObject(self, @selector(mlc_activityIndicatorBGView), mlc_activityIndicatorBGView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setMlc_activityIndicatorView:(UIActivityIndicatorView *)mlc_activityIndicatorView {
    objc_setAssociatedObject(self, @selector(mlc_activityIndicatorView), mlc_activityIndicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark -
- (void)mlc_showToastWithTitle:(NSString *)title afterDelay:(NSTimeInterval)delay {
    MLCProgressHUD *hud = [[MLCProgressHUD alloc] initForView:self type:(MLCProgressHUDTypeToast)];
    hud.bezelView.backgroundColor = [UIColor mlc_colorWithHexString:@"000000" alpha:0.7];
    hud.bezelView.layer.cornerRadius = 5;
    hud.bezelViewMaxWidthRate = 0.7;
    hud.titleLabel.textColor = [UIColor whiteColor];
    hud.titleLabel.font = [UIFont systemFontOfSize:13];
    hud.titleLabel.numberOfLines = 0;
    hud.titleLabel.text = title.length > 0 ? title : @" ";
    hud.titleLabelEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    [hud hideAfterDelay:delay];
}
- (void)mlc_showLoadingWithTitle:(NSString *)title {
    MLCProgressHUD *hud = [[MLCProgressHUD alloc] initForView:self type:(MLCProgressHUDTypeLoading) annularWidth:24];
    hud.rotateDuration = 0.8;
//    hud.bezelView.backgroundColor = [UIColor mlc_colorWithHexString:@"000000" alpha:0.7];
//        hud.bezelView.backgroundColor = .lcs_color(hexString: "000000", alpha: 0.7)
//        hud.bezelView.layer.cornerRadius = 5
    [hud.annularView.line shapeLayer].strokeEnd = 0.1;
//        hud.annularViewTopMargin = 12
    hud.titleLabel.textColor = [UIColor mlc_colorWithHexString:@"C6C9CC"];
    hud.titleLabel.font = [UIFont systemFontOfSize:14];
    hud.titleLabel.numberOfLines = 0;
    hud.titleLabel.text = title.length > 0 ? title : @"加载中...";
    hud.titleLabelEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
}
- (void)mlc_removeHud {
    [MLCProgressHUD hideHUDForView:self];
}
- (void)mlc_showActivityIndicatorStyleLoadingWithHandler:(void (^)(UIActivityIndicatorView *))handler {
    if (self.mlc_activityIndicatorView) {
        if (@available(iOS 13.0, *)) {
            self.mlc_activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleMedium;
        } else {
            self.mlc_activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        }
        self.mlc_activityIndicatorView.color = [UIColor whiteColor];
        
        self.mlc_activityIndicatorBGView.hidden = NO;
    } else {
        self.mlc_activityIndicatorBGView = [[UIView alloc]init];
        [self addSubview:self.mlc_activityIndicatorBGView];
        [self.mlc_activityIndicatorBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        if (@available(iOS 13.0, *)) {
            self.mlc_activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleMedium)];
        } else {
            self.mlc_activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
        }
        [self.mlc_activityIndicatorBGView addSubview:self.mlc_activityIndicatorView];
        [self.mlc_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.mlc_activityIndicatorBGView);
        }];
    }
    [self.mlc_activityIndicatorView startAnimating];
    
    if (handler) {
        handler(self.mlc_activityIndicatorView);
    }
}
- (void)mlc_hideActivityIndicatorStyleLoading {
    [self.mlc_activityIndicatorView stopAnimating];
    self.mlc_activityIndicatorBGView.hidden = YES;
}

@end
