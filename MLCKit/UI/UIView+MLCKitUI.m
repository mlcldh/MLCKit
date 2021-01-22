//
//  UIView+MLCKitUI.m
//  MLCKit
//
//  Created by menglingchao on 2021/1/22.
//

#import "UIView+MLCKitUI.h"
#import <objc/runtime.h>
#import "Masonry.h"

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
- (void)mlc_showActivityIndicatorStyleLoadingWithHandler:(void (^)(UIActivityIndicatorView *))handler {
    if (!self.mlc_activityIndicatorView) {
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
    self.mlc_activityIndicatorBGView.hidden = NO;
    
    if (@available(iOS 13.0, *)) {
        self.mlc_activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleMedium;
    } else {
        self.mlc_activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    }
    self.mlc_activityIndicatorView.color = [UIColor whiteColor];
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
