//
//  UIControl+MLCKit.m
//  Masonry
//
//  Created by menglingchao on 2019/12/20.
//

#import "UIControl+MLCKit.h"
#import <objc/runtime.h>

//#import <AppKit/AppKit.h>


@implementation UIControl (MLCKit)

#pragma mark - Getter
- (void (^)(void))mlc_touchUpInsideBlock {
    return objc_getAssociatedObject(self, _cmd);
}
#pragma mark - Setter
- (void)setMlc_touchUpInsideBlock:(void (^)(void))mlc_touchUpInsideBlock {
    objc_setAssociatedObject(self, @selector(mlc_touchUpInsideBlock), mlc_touchUpInsideBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(mlc_handleUIControlEventTouchUpInside:) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)mlc_handleUIControlEventTouchUpInside:(UIControl *)control {
    if (self.mlc_touchUpInsideBlock) {
        self.mlc_touchUpInsideBlock();
    }
}

@end
