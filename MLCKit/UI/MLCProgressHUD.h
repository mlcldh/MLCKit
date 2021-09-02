//
//  MLCProgressHUD.h
//  MLCKit
//
//  Created by menglingchao on 2021/9/1.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLCAnnularView.h"

typedef NS_ENUM(NSInteger, MLCProgressHUDType) {
    MLCProgressHUDTypeToast = 0,//
    MLCProgressHUDTypeLoading = 1,//
    MLCProgressHUDTypeCustom = 2,//
};

@interface MLCProgressHUD : UIView

///
@property (nonatomic, readonly) MLCProgressHUDType type;
///
@property (nonatomic) CGFloat rotateDuration;
///
@property (nonatomic, strong) UIView *backgroundView;
///
@property (nonatomic, strong) UIView *bezelView;
///
@property (nonatomic) CGFloat bezelViewMaxWidthRate;
///
@property (nonatomic, strong) MLCAnnularView *annularView;
///
@property (nonatomic, readonly) CGFloat annularWidth;
///
@property (nonatomic) CGFloat annularViewTopMargin;
///
@property (nonatomic, strong) UILabel *titleLabel;
///
@property (nonatomic) UIEdgeInsets titleLabelEdgeInsets;
///
@property (nonatomic, strong) UIView *customView;
///
@property (nonatomic) UIEdgeInsets customViewEdgeInsets;


- (instancetype)initForView:(UIView *)view type:(MLCProgressHUDType)type;
- (instancetype)initForView:(UIView *)view type:(MLCProgressHUDType)type annularWidth:(CGFloat)annularWidth;

- (void)hideAfterDelay:(CGFloat)delay;

+ (MLCProgressHUD *)HUDForView:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;

@end
