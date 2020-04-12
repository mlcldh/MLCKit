//
//  MLCPhotoPermissionManager.h
//  Masonry
//
//  Created by menglingchao on 2020/4/11.
//

#import <Foundation/Foundation.h>

@class MLCPhotoPermissionModel;

//NS_ASSUME_NONNULL_BEGIN

/**相册/相机权限*/
@interface MLCPhotoPermissionManager : NSObject

/**相册*/
@property (nonatomic, copy) MLCPhotoPermissionModel *albumPermissionModel;
/**相机*/
@property (nonatomic, copy) MLCPhotoPermissionModel *cameraPermissionModel;

/**单例*/
+ (instancetype)sharedInstance;
/**判断、获取相册/相机权限*/
+ (void)requestPermissionWithSourceType:(UIImagePickerControllerSourceType)souceType successCallback:(void (^)(BOOL isSourceTypeAvailable, BOOL success, BOOL isNotDetermined))successCallback;
/**判断、获取相册/相机权限，权限不足时，弹出alert*/
+ (void)requestPermissionWithSourceType:(UIImagePickerControllerSourceType)sourceType successCallback:(void (^)(void))successCallback fromViewController:(UIViewController *)viewController;

@end

//NS_ASSUME_NONNULL_END
