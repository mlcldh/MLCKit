//
//  UIView+MLCKitUI.h
//  MLCKit
//
//  Created by menglingchao on 2021/1/22.
//

#import <UIKit/UIKit.h>


@interface UIView (MLCKitUI)

/**显示菊花loading，默认白色小菊花*/
- (void)mlc_showActivityIndicatorStyleLoadingWithHandler:(void(^)(UIActivityIndicatorView *activityIndicatorView))handler;
/**隐藏白色菊花loading*/
- (void)mlc_hideActivityIndicatorStyleLoading;

@end
