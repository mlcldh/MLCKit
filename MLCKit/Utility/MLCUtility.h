//
//  MLCUtility.h
//  Masonry
//
//  Created by menglingchao on 2019/12/20.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface MLCUtility : NSObject

/**app版本号*/
+ (NSString *)appVersion;
/**app构建版本号*/
+ (NSString *)appBuildVersion;
/**app名字*/
+ (NSString *)appName;
/**app的bundle ID*/
+ (NSString *)bundleIdentifier;
/**运营商名字*/
+ (NSString *)carrierName;
/**蜂窝网络类型*/
+ (NSString *)currentRadioAccessTechnology;
/**安全区域，iOS 11以下的返回UIEdgeInsetsMake(20, 0, 0, 0)*/
+ (UIEdgeInsets)safeAreaInsets;
/**让UIApplication打开链接*/
+ (void)openURL:(NSURL*)url;

@end

//NS_ASSUME_NONNULL_END
