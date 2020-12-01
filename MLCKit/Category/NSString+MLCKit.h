//
//  NSString+MLCKit.h
//  MLCKit
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
/**使用SHA1计算hash*/
- (NSString *)mlc_sha1String;
/**将json字符串转换成字典或数组等*/
- (id)mlc_JSONObject;

@end
