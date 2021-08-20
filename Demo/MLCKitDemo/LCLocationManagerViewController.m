//
//  LCLocationManagerViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/12/1.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCLocationManagerViewController.h"
#import "Masonry.h"
//#import "MLCMacror.h"
#import "UIControl+MLCKit.h"
#import "MLCLocationManager.h"

@interface LCLocationManagerViewController ()

@end

@implementation LCLocationManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[MLCLocationManager sharedInstance] setDidChangeAuthorizationStatusHandler:^(CLAuthorizationStatus status) {
        NSLog(@"menglc didChangeAuthorizationStatus %@", @([CLLocationManager authorizationStatus]));
    }];
    
    [self addGetLocationButton];
    [self addStopUpdatingLocationButton];
    [self addGetAuthorizationStatusButton];
}
#pragma mark -
- (void)addGetLocationButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"获取定位" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [[MLCLocationManager sharedInstance] startUpdatingLocation];
    }];
    [[MLCLocationManager sharedInstance] setDidUpdateLocationsHandler:^BOOL(NSArray<CLLocation *> *locations) {
//        [[MLCLocationManager sharedInstance] stopUpdatingLocation];
        
        NSLog(@"menglc didUpdateLocationsHandler %@", locations);
        CLLocation *currentLocation = [locations lastObject];
        CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
        NSLog(@"menglc didUpdateLocations %@,%@", @(currentLocation.coordinate.latitude), @(currentLocation.coordinate.longitude));
        
        //反地理编码
        [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (placemarks.count > 0) {
                CLPlacemark *placemark = placemarks[0];
                NSLog(@"menglc reverseGeocodeLocation %@, %@, %@, %@, %@, %@", placemark.country, placemark.locality, placemark.subLocality, placemark.administrativeArea, placemark.subAdministrativeArea, placemark.postalCode);
            }
        }];
        return YES;
    }];
    [[MLCLocationManager sharedInstance] setDidFailHandler:^(NSError *error) {
        NSLog(@"menglc didFailHandler %@", error);
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
}
- (void)addStopUpdatingLocationButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"停止定位" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [[MLCLocationManager sharedInstance] stopUpdatingLocation];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.equalTo(self.view).offset(100);
    }];
}
- (void)addGetAuthorizationStatusButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"authorizationStatus" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        NSLog(@"menglc authorizationStatus %@", @([CLLocationManager authorizationStatus]));
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(180);
        make.top.equalTo(self.view).offset(100);
    }];
}

@end
