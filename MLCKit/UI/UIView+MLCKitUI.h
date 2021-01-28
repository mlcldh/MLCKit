//
//  UIView+MLCKitUI.h
//  MLCKit
//
//  Created by menglingchao on 2021/1/22.
//

#import <UIKit/UIKit.h>


@interface UIView (MLCKitUI)

/**显示成功*/
- (void)mlc_showSuccessWithImage:(UIImage *)image status:(NSString*)status;
/**显示错误*/
- (void)mlc_showErrorWithImage:(UIImage *)image status:(NSString*)status;
/**显示toast*/
- (void)mlc_showToastWithStatus:(NSString *)status afterDelay:(NSTimeInterval)delay;
/**让toast消失*/
- (void)mlc_hideHud;

/**显示菊花loading，默认白色小菊花*/
- (void)mlc_showActivityIndicatorStyleLoadingWithHandler:(void(^)(UIActivityIndicatorView *activityIndicatorView))handler;
/**隐藏菊花loading*/
- (void)mlc_hideActivityIndicatorStyleLoading;

@end
