//
//  MLCTimer.m
//  MLCKit
//
//  Created by menglingchao on 2022/1/19.
//  Copyright © 2022 MengLingchao. All rights reserved.
//

#import "MLCTimer.h"

@interface MLCTimer () {
    dispatch_source_t _timer;//定时器
    NSTimeInterval _timeInterval;//定时器间隔，单位是秒
    BOOL _invalidated;//是否失效
    BOOL _repeats;//是否重复
    void(^_handler)(MLCTimer *);
}

@end

@implementation MLCTimer

- (void)dealloc {
    [self invalidate];
}
+ (instancetype)timerWithTimeInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeats:(BOOL)repeats queue:(dispatch_queue_t)queue handler:(void (^)(MLCTimer *))handler {
    MLCTimer *timer = [[self alloc] initWithTimeInterval:interval delay:delay repeats:repeats queue:queue handler:handler];
    return timer;
}
- (instancetype)initWithTimeInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeats:(BOOL)repeats queue:(dispatch_queue_t)queue handler:(void (^)(MLCTimer *))handler {
    self = [super init];
    if (self && handler) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        _timeInterval = interval;
        _repeats = repeats;
        _handler = handler;
        dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0); //每秒执行
        __weak typeof(self) weakSelf = self;
        dispatch_source_set_event_handler(_timer, ^{
            [weakSelf _fire];
        });
        dispatch_resume(_timer);
    }
    return self;
}
- (void)fire {
    [self _fire];
}
- (void)_fire {
    if (_invalidated) {
        return;
    }
    _handler(self);
    if (!_repeats) {
        [self invalidate];
    }
}
- (void)invalidate {
    _invalidated = YES;
    dispatch_source_cancel(_timer);
}
- (NSTimeInterval)timeInterval {
    return _timeInterval;
}
- (BOOL)isValid {
    return !_invalidated;
}

@end
