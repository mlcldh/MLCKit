//
//  MLCOpenUtility.m
//  MLCKit
//
//  Created by menglingchao on 2020/11/30.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "MLCOpenUtility.h"

@implementation MLCOpenUtility

+ (void)openURL:(NSURL*)url completionHandler:(void (^)(BOOL))completion {
    UIApplication *app = [UIApplication sharedApplication];
    if (![app canOpenURL:url]) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    if (@available(iOS 10.0, *)) {
        [app openURL:url options:@{} completionHandler:completion];
    } else {
        BOOL ok = [app openURL:url];
        if (completion) {
            completion(ok);
        }
    }
}
+ (void)callWithTelephoneNumber:(NSString*)telephoneNumber {
    [self openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:telephoneNumber]] completionHandler:nil];
}
+ (void)sendEmail:(NSString*)email {
    [self openURL:[NSURL URLWithString:[@"mailto://" stringByAppendingString:email]] completionHandler:nil];
}
+ (void)sendShortMessage:(NSString *)shortMessage {
    [self openURL:[NSURL URLWithString:[@"sms://" stringByAppendingString:shortMessage]] completionHandler:nil];
}
+ (void)openSettings {
    [self openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] completionHandler:nil];
}

@end
