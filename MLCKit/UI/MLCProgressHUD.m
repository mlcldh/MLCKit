//
//  MLCProgressHUD.m
//  MLCKit
//
//  Created by menglingchao on 2021/9/1.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "MLCProgressHUD.h"
#import "Masonry.h"
#import "MLCProxy.h"
#import "UIView+MLCKit.h"

@interface MLCProgressHUD ()

@property (nonatomic, strong) NSTimer *hideDelayTimer;//

@end


@implementation MLCProgressHUD

static NSString *MLCProgressHUDRotationAnimationKey = @"rotate";

- (instancetype)initForView:(UIView *)view type:(MLCProgressHUDType)type {
    return [self initForView:view type:type annularWidth:0];
}
- (instancetype)initForView:(UIView *)view type:(MLCProgressHUDType)type annularWidth:(CGFloat)annularWidth {
    self = [super init];
    if (self) {
        _type = type;
        _annularWidth = annularWidth;
        _bezelViewMaxWidthRate = 1;
        _titleLabelEdgeInsets = UIEdgeInsetsZero;
        _customViewEdgeInsets = UIEdgeInsetsZero;
        
        [self backgroundView];
        [self bezelView];
        
        switch (type) {
            case MLCProgressHUDTypeToast: {
                [self titleLabel];
                [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.bezelView);
                }];
            }
                break;
            case MLCProgressHUDTypeLoading: {
                self.annularView = [[MLCAnnularView alloc] initWithStrokeThickness:2 width:annularWidth rounded:YES];
                [self.bezelView addSubview:self.annularView];
                [self.annularView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.top.equalTo(self.bezelView);
                    make.width.height.mas_equalTo(self.annularWidth);
                }];
                
                [self titleLabel];
                [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.annularView.mas_bottom).offset(5);
                }];
            }
                break;
            default:
                break;
        }
        [view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
    }
    return self;
}
- (void)hideAfterDelay:(CGFloat)delay {
    self.hideDelayTimer = [NSTimer timerWithTimeInterval:delay target:[MLCProxy proxyWithTarget:self] selector:@selector(hideAfterDelayAction:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.hideDelayTimer forMode:NSRunLoopCommonModes];
}
+ (MLCProgressHUD *)HUDForView:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[MLCProgressHUD class]]) {
            return (MLCProgressHUD *)subview;
        }
    }
    return nil;
}
+ (void)hideHUDForView:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[MLCProgressHUD class]]) {
            [subview removeFromSuperview];
        }
    }
}
#pragma mark - Getter
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        [self addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _backgroundView;
}
- (UIView *)bezelView {
    if (!_bezelView) {
        _bezelView = [[UIView alloc] init];
        [self addSubview:_bezelView];
        [_bezelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.lessThanOrEqualTo(self);
            make.height.lessThanOrEqualTo(self);
        }];
    }
    return _bezelView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self.bezelView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.bezelView);
        }];
    }
    return _titleLabel;
}
#pragma mark - Setter
- (void)setRotateDuration:(CGFloat)rotateDuration {
    [self.annularView.layer removeAnimationForKey:MLCProgressHUDRotationAnimationKey];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = @0;
    animation.toValue = @(M_PI * 2);
    animation.duration = rotateDuration;
    animation.removedOnCompletion = NO;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    [self.annularView.layer addAnimation:animation forKey:MLCProgressHUDRotationAnimationKey];
}
- (void)setBezelViewMaxWidthRate:(CGFloat)bezelViewMaxWidthRate {
    [self mlc_removeConstraintsWithFirstItem:self.bezelView firstAttribute:(NSLayoutAttributeWidth)];
//    [self.bezelView mlc_removeConstraintsWithFirstAttribute:(NSLayoutAttributeWidth) secondItem:self];
    [self.bezelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(self).multipliedBy(bezelViewMaxWidthRate);
    }];
}
- (void)setAnnularViewTopMargin:(CGFloat)annularViewTopMargin {
    if (self.type != MLCProgressHUDTypeLoading) {
        return;
    }
    [self.annularView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(annularViewTopMargin);
    }];
}
- (void)setTitleLabelEdgeInsets:(UIEdgeInsets)titleLabelEdgeInsets {
    switch (self.type) {
        case MLCProgressHUDTypeToast: {
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.bezelView).insets(titleLabelEdgeInsets);
            }];
        }
            break;
        case MLCProgressHUDTypeLoading: {
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bezelView).offset(titleLabelEdgeInsets.left);
                make.right.equalTo(self.bezelView).offset(- titleLabelEdgeInsets.right);
                make.top.equalTo(self.annularView.mas_bottom).offset(titleLabelEdgeInsets.top);
                make.bottom.equalTo(self.bezelView).offset(- titleLabelEdgeInsets.bottom);
            }];
        }
            break;
        default:
            break;
    }
}
- (void)setCustomView:(UIView *)customView {
    if (self.type != MLCProgressHUDTypeCustom) {
        return;
    }
    [self.customView removeFromSuperview];
    _customView = customView;
    [self.bezelView addSubview:self.customView];
    [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bezelView);
    }];
}
- (void)setCustomViewEdgeInsets:(UIEdgeInsets)customViewEdgeInsets {
    if (self.type != MLCProgressHUDTypeCustom) {
        return;
    }
    [self.customView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bezelView).insets(customViewEdgeInsets);
    }];
}
#pragma mark - Event
- (void)hideAfterDelayAction:(NSTimer *)timer {
    self.hideDelayTimer = nil;
    [self removeFromSuperview];
}

@end
