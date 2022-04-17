//
//  MLCBaseNode.m
//  MLCKit
//
//  Created by menglingchao on 2022/4/13.
//

#import "MLCBaseNode.h"

@implementation MLCBaseNode

- (instancetype)initWithVal:(int)val {
    if (self = [super init]) {
        _val = val;
    }
    return self;
}

@end
