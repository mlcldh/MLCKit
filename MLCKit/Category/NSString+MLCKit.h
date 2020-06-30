//
//  NSString+MLCKit.h
//  MLCKitDemo
//
//  Created by menglingchao on 2019/12/23.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

@interface NSString (MLCKit)

/**URL编码*/
- (NSString *)mlc_urlEncode;
/**URL解码*/
- (NSString *)mlc_urlDecode;

@end
