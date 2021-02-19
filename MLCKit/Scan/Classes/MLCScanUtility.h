//
//  MLCScanUtility.h
//  MLCKit
//
//  Created by menglingchao on 2021/2/19.
//

#import <Foundation/Foundation.h>


@interface MLCScanUtility : NSObject

/**获取图片上的二维码字符串*/
+ (NSArray<NSString *> *)QRCodeStringsWithImage:(UIImage *)image;

@end

