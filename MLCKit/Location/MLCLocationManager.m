//
//  MLCLocationManager.m
//  MLCKit
//
//  Created by menglingchao on 2020/12/1.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "MLCLocationManager.h"

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
- (instancetype)init {
    self = [super init];
    if (self) {
        [self locationmanager];
    }
    return self;
}
#pragma mark - Getter
- (CLLocationManager *)locationmanager {
    if (!_locationmanager) {
        _locationmanager = [[CLLocationManager alloc]init];
        //设置寻址精度
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationmanager.distanceFilter = 5.0;
        _locationmanager.delegate = self;
    }
    return _locationmanager;
}
- (CLAuthorizationStatus)authorizationStatus {
    if (@available(iOS 14.0, *)) {
        return self.locationmanager.authorizationStatus;
    }
    return [CLLocationManager authorizationStatus];
}
#pragma mark -
- (void)startUpdatingLocation {
    //判断定位功能是否打开
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }
    [self.locationmanager requestAlwaysAuthorization];
    [self.locationmanager requestWhenInUseAuthorization];
    [self.locationmanager startUpdatingLocation];
}
- (void)stopUpdatingLocation {
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }
    [self.locationmanager stopUpdatingLocation];
}
- (void)handleDidChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (self.didChangeAuthorizationStatusHandler) {
        self.didChangeAuthorizationStatusHandler(status);
    }
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self startUpdatingLocation];
            break;
        default:
            break;
    }
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    BOOL stop = YES;
    if (_didUpdateLocationsHandler) {
        stop = _didUpdateLocationsHandler(locations);
    }
    if (stop) {
        [self.locationmanager stopUpdatingLocation];
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (_didFailHandler) {
        _didFailHandler(error);
    }
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
//    NSLog(@"MLCKit didChangeAuthorizationStatus %@", @(status));
    [self handleDidChangeAuthorizationStatus:status];
}
- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
//    NSLog(@"MLCKit didChangeAuthorizationStatus %@", @([CLLocationManager authorizationStatus]));
    [self handleDidChangeAuthorizationStatus:[CLLocationManager authorizationStatus]];
}

@end
