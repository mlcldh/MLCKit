//
//  MLCDeviceUtility.h
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**设备相关工具类*/
@interface MLCDeviceUtility : NSObject

/**app版本号*/
+ (NSString *)appVersion;
/**app构建版本号*/
+ (NSString *)appBuildVersion;
/**app名字*/
+ (NSString *)appName;
/**app的bundle ID*/
+ (NSString *)bundleIdentifier;
/**IDFA，广告标示符*/
+ (NSString *)idfa;
/**广告跟踪是否开启*/
+ (BOOL)advertisingTrackingEnabled;
/**IDFV*/
+ (NSString *)identifierForVendor;
/**IDFA或IDFV，IDFA能获取到就返回IDFA*/
+ (NSString *)idfaOrIdfv;
/***/
+ (NSString *)machine;
/**是否越狱*/
+ (BOOL)isJailbroken;

/**运营商名字*/
+ (NSString *)carrierName;
/**蜂窝网络类型*/
+ (NSString *)currentRadioAccessTechnology;
/**电池状态*/
+ (UIDeviceBatteryState)batteryStauts;

/**电池电量*/
+ (float)batteryLevel;
/**总内存大小*/
+ (unsigned long long)totalMemorySize;

/**当前可用内存大小*/
+ (unsigned long long)availableMemorySize;
/**已使用内存大小*/
+ (unsigned long long)usedMemory;
/**总磁盘容量*/
+ (unsigned long long)totalDiskSize;
/**可用磁盘容量*/
+ (unsigned long long)availableDiskSize;

/**IP地址*/
+ (NSString *)deviceIPAdress;
/**连接的WIFI名称(SSID)*/
+ (NSString *)wifiName;
/**状态栏高度*/
+ (CGFloat)statusBarHeight;
/**安全区域，iOS 11以下的返回UIEdgeInsetsMake(20, 0, 0, 0)*/
+ (UIEdgeInsets)safeAreaInsets;

@end
