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

@interface MLCViewTarget : NSObject

@property (nonatomic) MLCGestureRecognizerType type;//
@property (nonatomic, weak) UIGestureRecognizer *gestureRecognizer;
@property (nonatomic, copy) void (^actionCallback)(UIGestureRecognizer *recognizer);

@end

@implementation MLCViewTarget

- (void)senderAction:(UIGestureRecognizer *)sender {
    if (_actionCallback) {
        _actionCallback(sender);
    }
}

@end

@implementation UIView (MLCKit)

- (UIGestureRecognizer *)mlc_addGestureRecognizerWithType:(MLCGestureRecognizerType)type callback:(void (^)(UIGestureRecognizer *))callback {
    MLCViewTarget *viewTarget = [[MLCViewTarget alloc] init];
    UIGestureRecognizer *recognizer = nil;
    switch (type) {
        case MLCGestureRecognizerTypeTap: {
            recognizer = [[UITapGestureRecognizer alloc]initWithTarget:viewTarget action:@selector(senderAction:)];
        }
            break;
        case MLCGestureRecognizerTypeLongPress: {
            recognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:viewTarget action:@selector(senderAction:)];
        }
            break;
        case MLCGestureRecognizerTypePan: {
            recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:viewTarget action:@selector(senderAction:)];
        }
            break;
        case MLCGestureRecognizerTypeSwipe: {
            recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:viewTarget action:@selector(senderAction:)];
        }
            break;
        case MLCGestureRecognizerTypeRotation: {
            recognizer = [[UIRotationGestureRecognizer alloc]initWithTarget:viewTarget action:@selector(senderAction:)];
        }
            break;
        case MLCGestureRecognizerTypePinch: {
            recognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:viewTarget action:@selector(senderAction:)];
        }
            break;
        default:
            break;
    }
    if (recognizer) {
        [self addGestureRecognizer:recognizer];
        self.userInteractionEnabled = YES;
    }
    viewTarget.type = type;
    viewTarget.gestureRecognizer = recognizer;
    viewTarget.actionCallback = callback;
    NSMutableArray *viewTargets = [self mlc_viewTargets];
    [viewTargets addObject:viewTarget];
    return recognizer;
}
- (void)mlc_removeGestureRecognizersWithType:(MLCGestureRecognizerType)type {
    NSMutableArray<MLCViewTarget *> *viewTargets = [self mlc_viewTargets];
    NSMutableArray<MLCViewTarget *> *removedViewTargets = [NSMutableArray array];
    for (MLCViewTarget *viewTarget in viewTargets) {
        if (viewTarget.type == type) {
            [removedViewTargets addObject:viewTarget];
        }
    }
    for (MLCViewTarget *viewTarget in removedViewTargets) {
        [self removeGestureRecognizer:viewTarget.gestureRecognizer];
        [viewTargets removeObject:viewTarget];
    }
}
- (void)mlc_removeAllGestureRecognizers {
    NSMutableArray<MLCViewTarget *> *viewTargets = [self mlc_viewTargets];
    for (MLCViewTarget *viewTarget in viewTargets) {
        [self removeGestureRecognizer:viewTarget.gestureRecognizer];
    }
    [viewTargets removeAllObjects];
}
- (void)mlc_removeConstraintsWithFirstItem:(id)firstItem firstAttribute:(NSLayoutAttribute)firstAttribute {//移除自己的某一些约束
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == firstItem && constraint.firstAttribute == firstAttribute) {
            if (@available(iOS 8.0, *)) {
                constraint.active = NO;
            } else {
                [self removeConstraint:constraint];
            }
        }
    }
}
- (void)mlc_removeConstraintsWithFirstAttribute:(NSLayoutAttribute)firstAttribute secondItem:(id)secondItem {//移除firstItem是自己的某一些约束
    BOOL isSizeAttribute = (firstAttribute == NSLayoutAttributeWidth) || (firstAttribute == NSLayoutAttributeHeight);
    UIView *superview = self;
    if (!isSizeAttribute) {
        superview = [self mlc_closestCommonSuperview:secondItem];
    }
    [superview mlc_removeConstraintsWithFirstItem:self firstAttribute:firstAttribute];
}
- (void)mlc_addConstraintWithFirstAttribute:(NSLayoutAttribute)firstAttribute relation:(NSLayoutRelation)relation secondItem:(id)secondItem secondAttribute:(NSLayoutAttribute)secondAttribute multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:firstAttribute relatedBy:relation toItem:secondItem attribute:secondAttribute multiplier:multiplier constant:constant];
    if (@available(iOS 8.0, *)) {
        constraint.active = YES;
    } else {
        BOOL isSizeAttribute = (firstAttribute == NSLayoutAttributeWidth) || (firstAttribute == NSLayoutAttributeHeight);
        if (isSizeAttribute) {
            [self addConstraint:constraint];
        } else {
            UIView *superview = [self mlc_closestCommonSuperview:secondItem];
            [superview addConstraint:constraint];
        }
    }
}
- (instancetype)mlc_closestCommonSuperview:(UIView *)view {
    UIView *closestCommonSuperview = nil;
    
    UIView *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        UIView *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}
#pragma mark - Getter
- (NSMutableArray<MLCViewTarget *> *)mlc_viewTargets {
    NSMutableArray *viewTargets = objc_getAssociatedObject(self, _cmd);
    if (!viewTargets) {
        viewTargets = [NSMutableArray array];
        objc_setAssociatedObject(self, @selector(mlc_viewTargets), viewTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return viewTargets;
}

@end
