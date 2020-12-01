//
//  MLCDeviceUtility.m
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "MLCDeviceUtility.h"
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <mach/vm_statistics.h>
#include <sys/utsname.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <sys/mount.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>
//@import CoreTelephony.CTTelephonyNetworkInfo;
//@import CoreTelephony.CTCarrier;

static CTTelephonyNetworkInfo *MLCNetworkInfo = nil;

@implementation MLCDeviceUtility

+ (NSString *)appVersion {
    static NSString * string = nil;
    if (!string.length) {
        string = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    }
//    NSAssert(string.length, @"不能为空");
    return string;
}
+ (NSString *)appBuildVersion {
    static NSString * string = nil;
    if (!string.length) {
        string = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    }
//    NSAssert(string.length, @"不能为空");
    return string;
}
+ (NSString *)appName {
    static NSString * string = nil;
    if (!string.length) {
        string = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    }
//    NSAssert(string.length, @"不能为空");
    return string;
}
+ (NSString *)bundleIdentifier {
    static NSString * string = nil;
    if (!string.length) {
        string = [[NSBundle mainBundle] bundleIdentifier];
    }
//    NSAssert(string.length, @"不能为空");
    return string;
}
+ (NSString *)idfa {
    NSString *idfa = [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
    return idfa;
}
+ (BOOL)advertisingTrackingEnabled {
    return [ASIdentifierManager sharedManager].isAdvertisingTrackingEnabled;
}
+ (NSString *)identifierForVendor {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}
+ (NSString *)idfaOrIdfv {
    if ([self advertisingTrackingEnabled]) {
        return [self idfa];
    }
    return [self identifierForVendor];
}
+ (NSString *)machine {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = @(systemInfo.machine);
    return deviceString;
}
+ (BOOL)isJailbroken {
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"] || [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"]) {
        return YES;
    }
    return NO;
}
+ (NSString *)carrierName {
    if (!MLCNetworkInfo) {
        MLCNetworkInfo = CTTelephonyNetworkInfo.new;
    }
    NSString *carrierName = MLCNetworkInfo.subscriberCellularProvider.carrierName;
//    MLCLog(@"menglc carrierName = %@", carrierName);
//    NSAssert(carrierName.length, @"不能为空");
    return carrierName;
}
+ (NSString *)currentRadioAccessTechnology {
    if (!MLCNetworkInfo) {
        MLCNetworkInfo = CTTelephonyNetworkInfo.new;
    }
    NSString *radioAccessTechnology = MLCNetworkInfo.currentRadioAccessTechnology;
    if(radioAccessTechnology == nil) return nil;
    
    NSString *type = nil;
    if([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
        type = @"GPRS";
    }
    else if([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge]) {
        type = @"Edge";
    }
    else if([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
        type = @"CDMA";
    }
    else if([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
        type = @"4G";
    }
    else {
        type = @"3G";
    }
//    NSAssert(type.length, @"不能为空");
    return type;
}
+ (UIDeviceBatteryState)batteryStauts {
    return [UIDevice currentDevice].batteryState;
}
+ (float)batteryLevel {
    return [[UIDevice currentDevice] batteryLevel];
}
+ (unsigned long long)totalMemorySize {
    return [NSProcessInfo processInfo].physicalMemory;
}
+ (unsigned long long)availableMemorySize {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}
+ (unsigned long long)usedMemory {
  task_basic_info_data_t taskInfo;
  mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
  kern_return_t kernReturn = task_info(mach_task_self(),
                                       TASK_BASIC_INFO,
                                       (task_info_t)&taskInfo,
                                       &infoCount);

  if (kernReturn != KERN_SUCCESS
      ) {
    return NSNotFound;
  }
  
  return taskInfo.resident_size;
}
+ (unsigned long long)totalDiskSize {
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}
+ (unsigned long long)availableDiskSize {
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}
+ (NSString *)deviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}
+ (NSString *)wifiName {
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;

            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}
+ (CGFloat)statusBarHeight {
    CGFloat statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        statusBarHeight = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}
+ (UIEdgeInsets)safeAreaInsets {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets insets = window.safeAreaInsets;
        if (insets.top < 20) {
            insets.top = 20;
        }
        return insets;
    }
    return UIEdgeInsetsMake(20, 0, 0, 0);
}

@end
