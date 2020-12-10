//
//  MLCLocationManager.h
//  MLCKit
//
//  Created by menglingchao on 2020/12/1.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**定位管理*/
@interface MLCLocationManager : NSObject

/**单例*/
+ (instancetype)sharedInstance;
/**更新位置回调*/
@property (nonatomic, copy) BOOL(^didUpdateLocationsHandler)(NSArray<CLLocation *> *locations);
/**失败回调*/
@property (nonatomic, copy) void(^didFailHandler)(NSError *error);

/**开始更新位置*/
- (void)startUpdatingLocation;
/**停止更新位置*/
- (void)stopUpdatingLocation;

@end
