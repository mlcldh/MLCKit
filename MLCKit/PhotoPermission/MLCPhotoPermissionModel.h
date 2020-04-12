//
//  MLCPhotoPermissionModel.h
//  Masonry
//
//  Created by menglingchao on 2020/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLCPhotoPermissionModel : NSObject

/**没有相册/相机功能*/
@property (nonatomic, copy) NSString *unavailableTitle;
/**没有相册/相机功能*/
@property (nonatomic, copy) NSString *unavailableMessage;
/***/
@property (nonatomic, copy) NSString *openPermissionTitle;
/***/
@property (nonatomic, copy) NSString *openPermissionMessage;

@end

NS_ASSUME_NONNULL_END
