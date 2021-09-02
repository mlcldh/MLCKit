//
//  UIColor+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2021/9/1.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (MLCKit)

+ (UIColor *)mlc_colorWithHexString:(NSString *)hexString;
+ (UIColor *)mlc_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
