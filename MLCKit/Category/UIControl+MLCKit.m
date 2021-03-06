//
//  UIControl+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "UIControl+MLCKit.h"
#import <objc/runtime.h>

//#import <AppKit/AppKit.h>

@interface MLCControlTarget : NSObject

@property (nonatomic, copy) void (^actionHandler)(id sender);
@property (nonatomic) UIControlEvents controlEvents;

@end

@implementation MLCControlTarget

- (instancetype)initWithActionHandler:(void (^)(id))actionHandler controlEvents:(UIControlEvents)controlEvents {
    if (self = [super init]) {
        _actionHandler   = actionHandler;
        _controlEvents = controlEvents;
    }
    return self;
}
- (void)senderAction:(id)sender {
    if (_actionHandler) {
        _actionHandler(sender);
    }
}

@end

@implementation UIControl (MLCKit)

@dynamic mlc_touchUpInsideBlock;

- (void)mlc_addActionForControlEvents:(UIControlEvents)controlEvents handler:(void (^)(id))handler {
    if (!controlEvents) return;
    MLCControlTarget *controlTarget = [[MLCControlTarget alloc] initWithActionHandler:handler controlEvents:controlEvents];
    [self addTarget:controlTarget action:@selector(senderAction:) forControlEvents:controlEvents];
    NSMutableArray *controlTargets = [self mlc_controlTargets];
    [controlTargets addObject:controlTarget];
}
- (void)mlc_removeAllActionsForControlEvents:(UIControlEvents)controlEvents {
    if (!controlEvents) return;
    NSMutableArray *controlTargets = [self mlc_controlTargets];
    NSMutableArray *removedTargets = [NSMutableArray array];
    for (MLCControlTarget *controlTarget in controlTargets) {
        if (controlTarget.controlEvents == controlEvents) {
            [removedTargets addObject:controlTarget];
        }
    }
    for (MLCControlTarget *controlTarget in removedTargets) {
        [self removeTarget:controlTarget action:@selector(senderAction:) forControlEvents:controlEvents];
        [controlTargets removeObject:controlTarget];
    }
}
- (void)mlc_removeAllActions {
    NSMutableArray *controlTargets = [self mlc_controlTargets];
    for (MLCControlTarget *controlTarget in controlTargets) {
        [self removeTarget:controlTarget action:@selector(senderAction:) forControlEvents:controlTarget.controlEvents];
    }
    [controlTargets removeAllObjects];
}
#pragma mark - Getter
- (NSMutableArray *)mlc_controlTargets {
    NSMutableArray *controlTargets = objc_getAssociatedObject(self, _cmd);
    if (!controlTargets) {
        controlTargets = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, controlTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return controlTargets;
}
#pragma mark - Setter
- (void)setMlc_touchUpInsideBlock:(void (^)(void))mlc_touchUpInsideBlock {
    [self mlc_removeAllActionsForControlEvents:(UIControlEventTouchUpInside)];
    [self mlc_addActionForControlEvents:(UIControlEventTouchUpInside) handler:^(UIControl *sender) {
        if (mlc_touchUpInsideBlock) {
            mlc_touchUpInsideBlock();
        }
    }];
}

@end
