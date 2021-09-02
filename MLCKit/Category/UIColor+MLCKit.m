//
//  UIColor+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2021/9/1.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "UIColor+MLCKit.h"
#import "NSString+MLCKit.h"

@implementation UIColor (MLCKit)

+ (UIColor *)mlc_colorWithHexString:(NSString *)hexString {
    return [self mlc_colorWithHexString:hexString alpha:1];
}
+ (UIColor *)mlc_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    if (hexString.length != 6) {
        return nil;
    }
    NSString *redString = [hexString substringToIndex:2];
    NSString *greenString = [hexString substringWithRange:NSMakeRange(2, 2)];
    NSString *blueString = [hexString substringFromIndex:4];
    
    __block BOOL ok = YES;
    __block unsigned red = 0;
    [redString lcs_handleHexStringWithValueHandler:^(unsigned int unsignedValue) {
        red = unsignedValue;
    } failureHandler:^{
        ok = NO;
    }];
    if (!ok) {
        return nil;
    }
    __block unsigned green = 0;
    [greenString lcs_handleHexStringWithValueHandler:^(unsigned int unsignedValue) {
        green = unsignedValue;
    } failureHandler:^{
        ok = NO;
    }];
    if (!ok) {
        return nil;
    }
    __block unsigned blue = 0;
    [blueString lcs_handleHexStringWithValueHandler:^(unsigned int unsignedValue) {
        blue = unsignedValue;
    } failureHandler:^{
        ok = NO;
    }];
    if (!ok) {
        return nil;
    }
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

@end
