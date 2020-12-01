//
//  NSString+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2019/12/23.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "NSString+MLCKit.h"
#import <CommonCrypto/CommonCrypto.h>

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
- (NSString *)mlc_sha1String {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
    
}
- (id)mlc_JSONObject {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:kNilOptions error:&err];
    return jsonObject;
}

@end
