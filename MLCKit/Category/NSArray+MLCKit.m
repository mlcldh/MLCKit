//
//  NSArray+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2020/8/10.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "NSArray+MLCKit.h"
#import "UIView+MLCKit.h"

@implementation NSArray (MLCKit)

- (void)mlc_combineViewsWithAxis:(UILayoutConstraintAxis)axis withFixedSpacing:(CGFloat)fixedSpacing {
    if (self.count < 2) {
        return;
    }
    UIView *lastView = self.firstObject;
    for (NSInteger i = 1; i < self.count; i ++) {
        UIView *view = self[i];
        [self mlc_combineView:view lastView:lastView withAxis:axis fixedSpacing:fixedSpacing];
        lastView = view;
    }
}
- (void)mlc_combineViewsWithAxis:(UILayoutConstraintAxis)axis withFixedSpacings:(NSArray<NSNumber *> *)fixedSpacings {
    if ((self.count < 2) || ((fixedSpacings.count + 1) != self.count)) {
        return;
    }
    UIView *lastView = self.firstObject;
    for (NSInteger i = 1; i < self.count; i ++) {
        UIView *view = self[i];
        CGFloat fixedSpacing = [fixedSpacings[i - 1] doubleValue];
        [self mlc_combineView:view lastView:lastView withAxis:axis fixedSpacing:fixedSpacing];
        lastView = view;
    }
}
- (void)mlc_combineView:(UIView *)view lastView:(UIView *)lastView withAxis:(UILayoutConstraintAxis)axis fixedSpacing:(CGFloat)fixedSpacing  {
    NSLayoutConstraint *constraint = nil;
    if (axis == UILayoutConstraintAxisHorizontal) {
        constraint = [NSLayoutConstraint constraintWithItem:view attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:lastView attribute:(NSLayoutAttributeRight) multiplier:1 constant:fixedSpacing];
    } else {
        constraint = [NSLayoutConstraint constraintWithItem:view attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:lastView attribute:(NSLayoutAttributeBottom) multiplier:1 constant:fixedSpacing];
    }
    if (@available(iOS 8.0, *)) {
        constraint.active = YES;
    } else {
        UIView *closestCommonSuperview = [view mlc_closestCommonSuperview:lastView];
        [closestCommonSuperview addConstraint:constraint];
    }
}

@end
