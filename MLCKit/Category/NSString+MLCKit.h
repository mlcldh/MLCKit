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
/**去掉前后空格*/
- (NSString *)mlc_stringByTrimmingWhitespaceCharacters;
/**去掉前后回车符*/
- (NSString *)mlc_stringByTrimmingNewlineCharacters;
/**去掉前后空格和回车符*/
- (NSString *)mlc_stringByTrimmingWhitespaceAndNewlineCharacters;
/**将json字符串转换成字典或数组等*/
- (id)mlc_JSONObject;

@end
