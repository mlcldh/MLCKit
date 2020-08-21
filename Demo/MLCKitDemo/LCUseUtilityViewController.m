//
//  LCUseUtilityViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCUseUtilityViewController.h"
#import "MLCUtility.h"

@interface LCUseUtilityViewController ()

@end

@implementation LCUseUtilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getIdfaAndIdfv];
}
#pragma mark -
- (void)getIdfaAndIdfv {
    NSString *idfa = [MLCUtility idfa];
    NSString *idfv = [MLCUtility identifierForVendor];
    NSLog(@"menglc %@, %@", idfa, idfv);
}

@end
