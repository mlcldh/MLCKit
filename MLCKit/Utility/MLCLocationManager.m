//
//  MLCLocationManager.m
//  MLCKit
//
//  Created by menglingchao on 2020/12/1.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "MLCLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface MLCLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationmanager;//

@end

@implementation MLCLocationManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken = 0;
    static id instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
#pragma mark - Getter
- (CLLocationManager *)locationmanager {
    if (!_locationmanager) {
        _locationmanager = [[CLLocationManager alloc]init];
        _locationmanager.delegate = self;
    }
    return _locationmanager;
}
#pragma mark -
- (void)getLocation {
    //判断定位功能是否打开
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }
    [self.locationmanager requestAlwaysAuthorization];
    [self.locationmanager requestWhenInUseAuthorization];
    
    //设置寻址精度
    self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationmanager.distanceFilter = 5.0;
    [self.locationmanager startUpdatingLocation];
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.locationmanager stopUpdatingHeading];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    NSLog(@"menglc didUpdateLocations %@,%@", @(currentLocation.coordinate.latitude), @(currentLocation.coordinate.longitude));
    
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSLog(@"menglc reverseGeocodeLocation %@, %@", placeMark.locality, placeMark.country);
        }
    }];
}

@end
