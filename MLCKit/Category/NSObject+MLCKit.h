//
//  NSObject+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

@interface NSObject (MLCKit)

/**反序列化*/
- (void)mlc_setValuesWithCoder:(NSCoder *)aDecoder;
/**序列化*/
- (void)mlc_encodeWithCoder:(NSCoder *)aCoder;
/**转换成json字符串*/
- (NSString *)mlc_JSONString;
/// 引用计数
- (NSUInteger)mlc_retainCount;

@end
