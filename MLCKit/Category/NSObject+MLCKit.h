//
//  NSObject+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MLCKit)

/**反序列化*/
- (void)mlc_setValuesWithCoder:(NSCoder *)aDecoder;
/**序列化*/
- (void)mlc_encodeWithCoder:(NSCoder *)aCoder;

@end

//NS_ASSUME_NONNULL_END
