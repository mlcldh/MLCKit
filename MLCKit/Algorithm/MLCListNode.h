//
//  MLCListNode.h
//  MLCKit
//
//  Created by menglingchao on 2022/4/13.
//

#import <MLCKit/MLCBaseNode.h>

/// 链表节点
@interface MLCListNode : MLCBaseNode

/// 下一个节点
@property (nonatomic, strong) MLCListNode *next;
/// 上一个节点
@property (nonatomic, strong) MLCListNode *prev;

- (instancetype)initWithVal:(int)val next:(MLCListNode *)next;
- (instancetype)initWithVal:(int)val next:(MLCListNode *)next prev:(MLCListNode *)prev;

@end
