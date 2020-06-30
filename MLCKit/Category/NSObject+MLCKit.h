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

@end
