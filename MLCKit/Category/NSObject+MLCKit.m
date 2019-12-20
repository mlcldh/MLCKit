//
//  NSObject+MLCKit.m
//  Masonry
//
//  Created by menglingchao on 2019/12/20.
//

#import "NSObject+MLCKit.h"
#import <objc/runtime.h>

//#import <AppKit/AppKit.h>


@implementation NSObject (MLCKit)

- (void)mlc_setValuesWithCoder:(NSCoder *)aDecoder {
    u_int count;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        const char *propertyName =property_getName(properties[i]);
        NSString *propertyString = [NSString stringWithUTF8String: propertyName];
        id value = [aDecoder decodeObjectForKey:propertyString];
        //            KKLog(@"menglc propertyString %@, %@", propertyString, value);
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
//        KKLog(@"menglc propertyString encodeWithCoder %@, %@", propertyString, value);
//        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            [aCoder encodeObject:value forKey:propertyString];
//        }
    }
    free(properties);
}

@end
