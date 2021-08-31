//
//  MLCPhotoPermissionManager.h
//  Masonry
//
//  Created by menglingchao on 2020/4/11.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLCPhotoPermissionModel;

/**相册/相机权限*/
@interface MLCPhotoPermissionManager : NSObject

/**相册*/
@property (nonatomic, copy) MLCPhotoPermissionModel *albumPermissionModel;
/**相机*/
@property (nonatomic, copy) MLCPhotoPermissionModel *cameraPermissionModel;

/**单例，用于自定义权限不足时的提示语*/
+ (instancetype)sharedInstance;

/**判断、获取相册/相机权限*/
+ (void)requestPermissionWithSourceType:(UIImagePickerControllerSourceType)souceType sourceTypeUnavailableHandler:(void (^)(void))sourceTypeUnavailableHandler isNotDeterminedHandler:(void (^)(void))isNotDeterminedHandler handler:(void (^)(BOOL success, BOOL isLimited))handler;
/**判断、获取相册/相机权限，权限不足时，弹出alert*/
+ (void)requestPermissionWithSourceType:(UIImagePickerControllerSourceType)sourceType handler:(void (^)(BOOL isLimited))handler fromViewController:(UIViewController *)viewController;

@end
