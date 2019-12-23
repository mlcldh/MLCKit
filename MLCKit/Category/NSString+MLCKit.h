//
//  NSString+MLCKit.h
//  MLCKitDemo
//
//  Created by menglingchao on 2019/12/23.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface NSString (MLCKit)

/**URL编码*/
- (NSString *)mlc_urlEncode;
/**URL解码*/
- (NSString *)mlc_urlDecode;

@end

//NS_ASSUME_NONNULL_END
