//
//  MLCOpenUtility.h
//  MLCKit
//
//  Created by menglingchao on 2020/11/30.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**打开相关工具类*/
@interface MLCOpenUtility : NSObject

/**让UIApplication打开链接*/
+ (void)openURL:(NSURL*)url completionHandler:(void (^)(BOOL success))completionHandler;
/**打电话*/
+ (void)callWithTelephoneNumber:(NSString*)telephoneNumber;
/**发邮件*/
+ (void)sendEmail:(NSString*)email;
/**发短信*/
+ (void)sendShortMessage:(NSString*)shortMessage;
/**跳转到app设置页面*/
+ (void)openSettings;

@end
