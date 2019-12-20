//
//  UIView+MLCKit.m
//  Masonry
//
//  Created by menglingchao on 2019/12/20.
//

#import "UIView+MLCKit.h"
#import <objc/runtime.h>

//#import <AppKit/AppKit.h>

@interface UIView ()

@property (nonatomic, strong) UITapGestureRecognizer *mlc_tapGestureRecognizer;

@end

@implementation UIView (MLCKit)

#pragma mark - Getter
- (void (^)(void))mlc_tapBlock {
    return objc_getAssociatedObject(self, _cmd);
}
- (UITapGestureRecognizer *)mlc_tapGestureRecognizer {
    return objc_getAssociatedObject(self, _cmd);
}
#pragma mark - Setter
- (void)setMlc_tapBlock:(void (^)(void))mlc_tapBlock {
    [self removeGestureRecognizer:self.mlc_tapGestureRecognizer];
    self.mlc_tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mlc_tapAction:)];
    [self addGestureRecognizer:self.mlc_tapGestureRecognizer];
    objc_setAssociatedObject(self, @selector(mlc_tapBlock), mlc_tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.userInteractionEnabled = YES;
}
- (void)setMlc_tapGestureRecognizer:(UITapGestureRecognizer *)mlc_tapGestureRecognizer {
    objc_setAssociatedObject(self, @selector(mlc_tapGestureRecognizer), mlc_tapGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - Event
- (void)mlc_tapAction:(UITapGestureRecognizer *)recognizer {
    if (self.mlc_tapBlock) {
        self.mlc_tapBlock();
    }
}

@end
