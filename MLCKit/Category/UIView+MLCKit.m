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

@property (nonatomic, weak) UIGestureRecognizer *gestureRecognizer;
@property (nonatomic, copy) void (^actionCallback)(id recognizer);

@end

@implementation MLCViewTarget

- (void)senderAction:(id)sender {
    if (_actionCallback) {
        _actionCallback(sender);
    }
}

@end

@implementation UIView (MLCKit)

- (id)mlc_addGestureRecognizerWithType:(MLCGestureRecognizerType)type callback:(void (^)(id))callback {
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
            recognizer = [[UITapGestureRecognizer alloc]initWithTarget:viewTarget action:@selector(senderAction:)];
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
    viewTarget.gestureRecognizer = recognizer;
    viewTarget.actionCallback = callback;
    NSMutableArray *viewTargets = [self mlc_viewTargets];
    [viewTargets addObject:viewTarget];
    return recognizer;
}
- (void)mlc_removeGestureRecognizersWithType:(MLCGestureRecognizerType)type {
    NSMutableArray<MLCViewTarget *> *viewTargets = [self mlc_viewTargets];
    for (MLCViewTarget *viewTarget in viewTargets) {
        BOOL is = NO;
        switch (type) {
            case MLCGestureRecognizerTypeTap: {
                if ([viewTarget.gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
                    is = YES;
                }
            }
                break;
            case MLCGestureRecognizerTypeLongPress: {
                if ([viewTarget.gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
                    is = YES;
                }
            }
                break;
            case MLCGestureRecognizerTypePan: {
                if ([viewTarget.gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
                    is = YES;
                }
            }
                break;
            case MLCGestureRecognizerTypeSwipe: {
                if ([viewTarget.gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
                    is = YES;
                }
            }
                break;
            case MLCGestureRecognizerTypeRotation: {
                if ([viewTarget.gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
                    is = YES;
                }
            }
                break;
            case MLCGestureRecognizerTypePinch: {
                if ([viewTarget.gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
                    is = YES;
                }
            }
                break;
            default:
                break;
        }
        if (is) {
            [self removeGestureRecognizer:viewTarget.gestureRecognizer];
        }
    }
    [viewTargets removeAllObjects];
}
- (void)mlc_removeAllGestureRecognizers {
    NSMutableArray<MLCViewTarget *> *viewTargets = [self mlc_viewTargets];
    for (MLCViewTarget *viewTarget in viewTargets) {
        [self removeGestureRecognizer:viewTarget.gestureRecognizer];
    }
    [viewTargets removeAllObjects];
}
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
