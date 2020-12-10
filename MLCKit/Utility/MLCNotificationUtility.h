//
//  MLCNotificationUtility.h
//  MLCKit
//
//  Created by menglingchao on 2020/12/1.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**通知工具类*/
@interface MLCNotificationUtility : NSObject

/**
 注册通知
 
 @param delegate UNUserNotificationCenterDelegate
 **/
+ (void)registerNotificationWithDelegate:(id)delegate;

/**远程推送设备token字符串*/
+ (NSString *)remoteNotificationDeviceTokenStringWithDeviceToken:(NSData *)deviceToken;

@end
