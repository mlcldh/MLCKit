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
#pragma mark - Getter
- (CLLocationManager *)locationmanager {
    if (!_locationmanager) {
        _locationmanager = [[CLLocationManager alloc]init];
        //设置寻址精度
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationmanager.distanceFilter = 5.0;
        _locationmanager.delegate = self;
        [self.locationmanager requestAlwaysAuthorization];
        [self.locationmanager requestWhenInUseAuthorization];
    }
    return _locationmanager;
}
#pragma mark -
- (void)startUpdatingLocation {
    //判断定位功能是否打开
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }
    [self.locationmanager startUpdatingLocation];
}
- (void)stopUpdatingLocation {
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }
    [self.locationmanager stopUpdatingLocation];
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

@end
