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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getIdfaAndIdfv];
}
#pragma mark -
- (void)getIdfaAndIdfv {
    NSString *idfa = [MLCDeviceUtility idfa];
    NSString *idfv = [MLCDeviceUtility identifierForVendor];
    NSLog(@"menglc %@, %@", idfa, idfv);
}

@end
