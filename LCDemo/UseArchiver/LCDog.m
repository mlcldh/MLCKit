//
//  LCDog.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCDog.h"
#import "NSObject+MLCKit.h"

@implementation LCDog

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self mlc_setValuesWithCoder:aDecoder];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self mlc_encodeWithCoder:aCoder];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
