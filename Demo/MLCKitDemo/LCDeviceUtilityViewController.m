//
//  LCDeviceUtilityViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCDeviceUtilityViewController.h"
#import "MLCDeviceUtility.h"

@interface LCDeviceUtilityViewController ()

@end

@implementation LCDeviceUtilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getIdfaAndIdfv];
    [self getIsJailbroken];
    [self getIPInfo];
    [self compareSystemVersion];
}
#pragma mark -
- (void)getIdfaAndIdfv {
    NSString *idfa = [MLCDeviceUtility idfa];
    NSLog(@"menglc idfa %@", idfa);
    NSLog(@"menglc advertisingTrackingEnabled %@", @([MLCDeviceUtility advertisingTrackingEnabled]));
    NSString *idfv = [MLCDeviceUtility identifierForVendor];
    NSLog(@"menglc identifierForVendor %@", idfv);
}
- (void)getIsJailbroken {
    NSLog(@"menglc isJailbroken %@", @([MLCDeviceUtility isJailbroken]));
}
- (void)getIPInfo {
    NSString *deviceIP = [MLCDeviceUtility deviceIPAdress];
    NSString *wifiName = [MLCDeviceUtility wifiName];
    NSLog(@"menglc getIPInfo %@, %@", deviceIP, wifiName);
}
- (void)compareSystemVersion {
    NSLog(@"menglc compareSystemVersion %@, %@", [UIDevice currentDevice].systemVersion, @([MLCDeviceUtility isSystemVersionGreaterThanOrEqualToVersion:@"11.4.1"]));
}

@end
