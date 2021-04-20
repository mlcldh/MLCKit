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
    [self getIPInfo];
    [self compareSystemVersion];
}
#pragma mark -
- (void)getIdfaAndIdfv {
    NSString *idfa = [MLCDeviceUtility idfa];
    NSString *idfv = [MLCDeviceUtility identifierForVendor];
    NSLog(@"menglc getIdfaAndIdfv %@, %@", idfa, idfv);
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
