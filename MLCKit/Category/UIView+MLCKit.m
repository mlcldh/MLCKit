//
//  UIView+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "UIView+MLCKit.h"
#import <objc/runtime.h>

//#import <AppKit/AppKit.h>

@interface UIView ()

/**点击手势*/
@property (nonatomic, strong) UITapGestureRecognizer *mlc_tapGestureRecognizer;
/**长按手势*/
@property (nonatomic, strong) UILongPressGestureRecognizer *mlc_longPressGestureRecognizer;
/**点击回调*/
@property (nonatomic, copy) void(^mlc_tapBlock)(UIView *currentView);
/**长按手势回调*/
@property (nonatomic, copy) void(^mlc_longPressBlock)(UIView *currentView, UILongPressGestureRecognizer *recognizer);

@end

@implementation UIView (MLCKit)

- (UITapGestureRecognizer *)mlc_addTapGestureRecognizer:(void (^)(UIView *))callback {
    self.mlc_tapBlock = callback;
    [self removeGestureRecognizer:self.mlc_tapGestureRecognizer];
    self.mlc_tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mlc_handleTap:)];
    [self addGestureRecognizer:self.mlc_tapGestureRecognizer];
    self.userInteractionEnabled = YES;
    return self.mlc_tapGestureRecognizer;
}
- (void)mlc_removeTapGestureRecognizer {
    self.mlc_tapBlock = nil;
    [self removeGestureRecognizer:self.mlc_tapGestureRecognizer];
}
- (UILongPressGestureRecognizer *)mlc_addLongPressGestureRecognizer:(void (^)(UIView *, UILongPressGestureRecognizer *))callback {
    self.mlc_longPressBlock = callback;
    [self removeGestureRecognizer:self.mlc_longPressGestureRecognizer];
    self.mlc_longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(mlc_handleLongPress:)];
    [self addGestureRecognizer:self.mlc_longPressGestureRecognizer];
    self.userInteractionEnabled = YES;
    return self.mlc_longPressGestureRecognizer;
}
- (void)mlc_removeLongPressGestureRecognizer {
    self.mlc_longPressBlock = nil;
    [self removeGestureRecognizer:self.mlc_longPressGestureRecognizer];
}
#pragma mark - Getter
- (void (^)(UIView *))mlc_tapBlock {
    return objc_getAssociatedObject(self, _cmd);
}
- (void (^)(UIView *, UILongPressGestureRecognizer *))mlc_longPressBlock {
    return objc_getAssociatedObject(self, _cmd);
}
- (UITapGestureRecognizer *)mlc_tapGestureRecognizer {
    return objc_getAssociatedObject(self, _cmd);
}
- (UILongPressGestureRecognizer *)mlc_longPressGestureRecognizer {
    return objc_getAssociatedObject(self, _cmd);
}
#pragma mark - Setter
- (void)setMlc_tapBlock:(void (^)(UIView *))mlc_tapBlock {
    objc_setAssociatedObject(self, @selector(mlc_tapBlock), mlc_tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setMlc_longPressBlock:(void (^)(UIView *, UILongPressGestureRecognizer *))mlc_longPressBlock {
    objc_setAssociatedObject(self, @selector(mlc_longPressBlock), mlc_longPressBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setMlc_tapGestureRecognizer:(UITapGestureRecognizer *)mlc_tapGestureRecognizer {
    objc_setAssociatedObject(self, @selector(mlc_tapGestureRecognizer), mlc_tapGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setMlc_longPressGestureRecognizer:(UILongPressGestureRecognizer *)mlc_longPressGestureRecognizer {
    objc_setAssociatedObject(self, @selector(mlc_longPressGestureRecognizer), mlc_longPressGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - Event
- (void)mlc_handleTap:(UITapGestureRecognizer *)recognizer {
    if (self.mlc_tapBlock) {
        self.mlc_tapBlock(recognizer.view);
    }
}
- (void)mlc_handleLongPress:(UILongPressGestureRecognizer *)recognizer {
    if (self.mlc_longPressBlock) {
        self.mlc_longPressBlock(recognizer.view, recognizer);
    }
}
#pragma mark -
- (void)mlc_removeConstraintsWithFirstItem:(id)firstItem firstAttribute:(NSLayoutAttribute)firstAttribute {//移除某一些约束
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == firstItem && constraint.firstAttribute == firstAttribute) {
            if ([constraint respondsToSelector:@selector(active)]) {
                constraint.active = NO;
            } else {
                [self removeConstraint:constraint];
            }
        }
    }
}

@end
