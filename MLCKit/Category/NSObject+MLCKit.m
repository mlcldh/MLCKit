//
//  NSObject+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "NSObject+MLCKit.h"
#import <objc/runtime.h>

//#import <AppKit/AppKit.h>

@implementation NSObject (MLCKit)

#pragma mark -
- (void)mlc_setValuesWithCoder:(NSCoder *)aDecoder {
    u_int count;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        const char *propertyName =property_getName(properties[i]);
        NSString *propertyString = [NSString stringWithUTF8String: propertyName];
        id value = [aDecoder decodeObjectForKey:propertyString];
        //            MLCLog(@"menglc propertyString %@, %@", propertyString, value);
        [self setValue:value forKey:propertyString];
    }
    free(properties);
}
- (void)mlc_encodeWithCoder:(NSCoder *)aCoder {
    u_int count;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        const char *propertyName =property_getName(properties[i]);
        NSString *propertyString = [NSString stringWithUTF8String: propertyName];
        id value = [self valueForKey:propertyString];
//        MLCLog(@"menglc propertyString encodeWithCoder %@, %@", propertyString, value);
//        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            [aCoder encodeObject:value forKey:propertyString];
//        }
    }
    free(properties);
}
- (NSString *)mlc_JSONString {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    if (jsonData.length == 0) return nil;
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
