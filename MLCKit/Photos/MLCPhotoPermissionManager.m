//
//  MLCPhotoPermissionManager.m
//  MLCKit
//
//  Created by menglingchao on 2020/4/11.
//

#import "MLCPhotoPermissionManager.h"
#import <AVFoundation/AVFoundation.h>
//#import <PhotosUI/PhotosUI.h>
#import <Photos/Photos.h>
#import "MLCOpenUtility.h"
#import "MLCPhotoPermissionModel.h"

@implementation MLCPhotoPermissionManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken = 0;
    static id instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
#pragma mark - Getter
- (MLCPhotoPermissionModel *)albumPermissionModel {
    if (!_albumPermissionModel) {
        _albumPermissionModel = [[MLCPhotoPermissionModel alloc]init];
        _albumPermissionModel.unavailableTitle = @"";
        _albumPermissionModel.unavailableMessage = @"当前设备没有相册功能";
        _albumPermissionModel.openPermissionTitle = @"";
        _albumPermissionModel.openPermissionMessage = @"请在手机的“设置-隐私-照片”选项中，允许访问您的手机相册";
    }
    return _albumPermissionModel;
}
- (MLCPhotoPermissionModel *)cameraPermissionModel {
    if (!_cameraPermissionModel) {
        _cameraPermissionModel = [[MLCPhotoPermissionModel alloc]init];
        _cameraPermissionModel.unavailableTitle = @"";
        _cameraPermissionModel.unavailableMessage = @"当前设备没有相机功能";
        _cameraPermissionModel.openPermissionTitle = @"";
        _cameraPermissionModel.openPermissionMessage = @"请在手机的“设置-隐私-相机”选项中，允许访问您的摄像头";
    }
    return _cameraPermissionModel;
}
#pragma mark -
+ (void)requestPermissionWithSourceType:(UIImagePickerControllerSourceType)souceType handler:(void (^)(BOOL, BOOL, BOOL, BOOL))handler {
    
    if (![UIImagePickerController isSourceTypeAvailable:souceType]) {
        if (handler) {
            handler(NO, NO, NO, NO);
        }
        return;
    }
    if (souceType == UIImagePickerControllerSourceTypeCamera) {
        AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (authorizationStatus) {
            case AVAuthorizationStatusAuthorized:
                if (handler) {
                    handler(YES, YES, NO, NO);
                }
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                if (handler) {
                    handler(YES, NO, NO, NO);
                }
                break;
            case AVAuthorizationStatusNotDetermined:
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                         completionHandler:^(BOOL granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (handler) {
                            handler(YES, granted, NO, YES);
                        }
                    });
                }];
                break;
        }
    } else {
        if (@available(iOS 14, *)) {
            PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelReadWrite];
            switch (authorizationStatus) {
                case PHAuthorizationStatusNotDetermined: {
                    [PHPhotoLibrary requestAuthorizationForAccessLevel:PHAccessLevelReadWrite handler:^(PHAuthorizationStatus status2) {
                        [self handleStatus:status2 isNotDetermined:YES handler:handler];
                    }];
                }
                    break;
                default:
                    [self handleStatus:authorizationStatus isNotDetermined:NO handler:handler];
                    break;
            }
        } else {
            PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
            switch (authorizationStatus) {
                case PHAuthorizationStatusNotDetermined: {
                    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status2) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (handler) {
                                handler(YES, (status2 == PHAuthorizationStatusAuthorized), NO, YES);
                            }
                        });
                    }];
                }
                    break;
                default:
                    [self handleStatus:authorizationStatus isNotDetermined:NO handler:handler];
                    break;
            }
        }
    }
}
+ (void)handleStatus:(PHAuthorizationStatus)status isNotDetermined:(BOOL)isNotDetermined handler:(void (^)(BOOL, BOOL, BOOL, BOOL))handler {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self handleStatus:status isNotDetermined:isNotDetermined handler:handler];
        });
        return;
    }
    switch (status) {
        case PHAuthorizationStatusAuthorized:
            if (handler) {
                handler(YES, YES, NO, isNotDetermined);
            }
            break;
        case PHAuthorizationStatusLimited:
            if (handler) {
                handler(YES, YES, YES, isNotDetermined);
            }
            break;
        case PHAuthorizationStatusRestricted:
            if (handler) {
                handler(YES, NO, NO, isNotDetermined);
            }
            break;
        case PHAuthorizationStatusDenied:
            if (handler) {
                handler(YES, NO, NO, isNotDetermined);
            }
            break;
        default:
            break;
    }
}
+ (void)requestPermissionWithSourceType:(UIImagePickerControllerSourceType)sourceType handler:(void (^)(void))handler fromViewController:(UIViewController *)viewController {
    if (!viewController) {
        return;
    }
    void(^aCallback)(BOOL, BOOL, BOOL, BOOL) = ^(BOOL isSourceTypeAvailable, BOOL success, BOOL isLimited, BOOL isNotDetermined) {
        if (!isSourceTypeAvailable) {
            NSString *title = (sourceType == UIImagePickerControllerSourceTypeCamera) ? [MLCPhotoPermissionManager sharedInstance].cameraPermissionModel.unavailableTitle : [MLCPhotoPermissionManager sharedInstance].albumPermissionModel.unavailableTitle;
            NSString *message = (sourceType == UIImagePickerControllerSourceTypeCamera) ? [MLCPhotoPermissionManager sharedInstance].cameraPermissionModel.unavailableMessage : [MLCPhotoPermissionManager sharedInstance].albumPermissionModel.unavailableMessage;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                     message:message
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                                style:UIAlertActionStyleDefault
                                                              handler:nil]];
            [viewController presentViewController:alertController
                                         animated:YES
                                       completion:nil];
            return;
        }
        if (success) {
            handler();
            return;
        }
        NSString *title = (sourceType == UIImagePickerControllerSourceTypeCamera) ? [MLCPhotoPermissionManager sharedInstance].cameraPermissionModel.openPermissionTitle : [MLCPhotoPermissionManager sharedInstance].albumPermissionModel.openPermissionTitle;
        NSString *message = (sourceType == UIImagePickerControllerSourceTypeCamera) ? [MLCPhotoPermissionManager sharedInstance].cameraPermissionModel.openPermissionMessage : [MLCPhotoPermissionManager sharedInstance].albumPermissionModel.openPermissionMessage;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
            NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        //                UIApplication *application = [UIApplication sharedApplication];
            [MLCOpenUtility openURL:URL completionHandler:nil];
        //                if (@available(iOS 10.0, *)) {
        //                    [application openURL:URL options:@{} completionHandler:nil];
        //                } else {
        //                    [application openURL:URL];
        //                }
        }]];
        [viewController presentViewController:alertController
                                     animated:YES
                                   completion:nil];
    };
    
    [self requestPermissionWithSourceType:sourceType handler:aCallback];
}

@end
