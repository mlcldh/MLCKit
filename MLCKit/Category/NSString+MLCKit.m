//
//  NSString+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2019/12/23.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "NSString+MLCKit.h"

//#import <AppKit/AppKit.h>


@implementation NSString (MLCKit)

- (NSString *)mlc_urlEncode {
    NSString *encodeString = nil;
    if (@available(iOS 7.0, *)) {
        encodeString = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    } else {
        encodeString = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return encodeString;
}
- (NSString *)mlc_urlDecode {
    NSString *decodeString = nil;
    if (@available(iOS 7.0, *)) {
        decodeString = self.stringByRemovingPercentEncoding;
    } else {
        decodeString = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return decodeString;
}
- (id)mlc_JSONObject {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:kNilOptions error:&err];
    return jsonObject;
}

@end
