//
//  MLCListNode.m
//  MLCKit
//
//  Created by menglingchao on 2022/4/13.
//

#import "MLCListNode.h"

@implementation MLCListNode

- (instancetype)initWithVal:(int)val next:(MLCListNode *)next {
    return [self initWithVal:val next:next prev:nil];
}
- (instancetype)initWithVal:(int)val next:(MLCListNode *)next prev:(MLCListNode *)prev {
    if (self = [super initWithVal:val]) {
        _prev = prev;
        _next = next;
    }
    return self;
}

@end
