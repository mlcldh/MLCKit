//
//  MLCNotificationUtility.h
//  MLCKit
//
//  Created by menglingchao on 2020/12/1.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface MLCNotificationUtility : NSObject

/**注册通知*/
+ (void)registerNotificationWithDelegate:(id <UNUserNotificationCenterDelegate>)delegate;
/**远程推送设备token字符串*/
+ (NSString *)remoteNotificationDeviceTokenStringWithDeviceToken:(NSData *)deviceToken;

@end
