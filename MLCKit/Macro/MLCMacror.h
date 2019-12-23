//
//  MLCMacror.h
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#ifndef MLCMacror_h
#define MLCMacror_h

#if DEBUG
#define  MLCLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])
#else
#define MLCLog(...)
#endif

#define MLCSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define MLCSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define MLCSCREEN_WIDTH_Ratio ([UIScreen mainScreen].bounds.size.width / 375.f)
#define MLCSCREEN_HEIGHT_Ratio ([UIScreen mainScreen].bounds.size.height / 667.f)
#define MLCOnePixelsLineHeight (1/[UIScreen mainScreen].scale)

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#endif /* MLCMacror_h */
