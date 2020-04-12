//
//  UIControl+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface UIControl (MLCKit)

/**点击回调*/
@property (nonatomic, copy) void(^mlc_touchUpInsideBlock)(void);
/**添加事件*/
- (void)mlc_addActionForControlEvents:(UIControlEvents)controlEvents callback:(void(^)(id sender))callback;
/**移除某些类型的所有事件*/
- (void)mlc_removeAllActionsForControlEvents:(UIControlEvents)controlEvents;
/**移除所有事件*/
- (void)mlc_removeAllActions;

@end

//NS_ASSUME_NONNULL_END
