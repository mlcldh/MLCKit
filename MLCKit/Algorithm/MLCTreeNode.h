//
//  MLCTreeNode.h
//  MLCKit
//
//  Created by menglingchao on 2022/4/13.
//

#import <MLCKit/MLCBaseNode.h>

/// 二叉树节点
@interface MLCTreeNode : MLCBaseNode

/// 左子树
@property (nonatomic, strong) MLCTreeNode *left;
/// 右子树
@property (nonatomic, strong) MLCTreeNode *right;

- (instancetype)initWithVal:(int)val left:(MLCTreeNode *)left right:(MLCTreeNode *)right;

@end
