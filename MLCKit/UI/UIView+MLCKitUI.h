//
//  UIView+MLCKitUI.h
//  MLCKit
//
//  Created by menglingchao on 2021/1/22.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (MLCKitUI)

/// 显示toast
/// - Parameter title: 显示的文案
- (void)mlc_showToastWithTitle:(NSString *)title afterDelay:(NSTimeInterval)delay;
/// 显示loading
/// - Parameter title: 显示的文案
- (void)mlc_showLoadingWithTitle:(NSString *)title;
/// 移除所有LCSProgressHUD
- (void)mlc_removeHud;

/**显示菊花loading，默认白色小菊花*/
- (void)mlc_showActivityIndicatorStyleLoadingWithHandler:(void(^)(UIActivityIndicatorView *activityIndicatorView))handler;
/**隐藏菊花loading*/
- (void)mlc_hideActivityIndicatorStyleLoading;

@end
