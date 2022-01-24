//
//  MLCTimer.h
//  MLCKit
//
//  Created by menglingchao on 2022/1/19.
//  Copyright © 2022 MengLingchao. All rights reserved.
//

#import <Foundation/Foundation.h>


/// 基于GCD的定时器
@interface MLCTimer : NSObject

/// 生成实例
/// @param interval 定时器间隔，单位是秒
/// @param delay 让定时器延迟多久执行，单位是秒
/// @param repeats 是否重复
/// @param queue 定时器运行的队列
/// @param handler 定时器回调
+ (instancetype)timerWithTimeInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeats:(BOOL)repeats queue:(dispatch_queue_t)queue handler:(void (^)(MLCTimer *timer))handler;
- (instancetype)initWithTimeInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeats:(BOOL)repeats queue:(dispatch_queue_t)queue handler:(void (^)(MLCTimer *timer))handler;

/// 触发定时器回调
- (void)fire;
/// 使定时器无效
- (void)invalidate;
/// 定时器间隔，单位是秒
@property (readonly) NSTimeInterval timeInterval;
/// 定时器是否有效
@property (readonly, getter=isValid) BOOL valid;

@end
