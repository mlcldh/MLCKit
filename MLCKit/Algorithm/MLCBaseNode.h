//
//  MLCBaseNode.h
//  MLCKit
//
//  Created by menglingchao on 2022/4/13.
//

#import <Foundation/Foundation.h>

/// 节点基类
@interface MLCBaseNode : NSObject

/// 值
@property (nonatomic) int val;

- (instancetype)initWithVal:(int)val;

@end
