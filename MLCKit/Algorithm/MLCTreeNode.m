//
//  MLCTreeNode.m
//  MLCKit
//
//  Created by menglingchao on 2022/4/13.
//

#import "MLCTreeNode.h"

@implementation MLCTreeNode

- (instancetype)initWithVal:(int)val left:(MLCTreeNode *)left right:(MLCTreeNode *)right {
    if (self = [super initWithVal:val]) {
        _left = left;
        _right = right;
    }
    return self;
}

@end
