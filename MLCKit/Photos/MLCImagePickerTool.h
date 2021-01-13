//
//  MLCImagePickerTool.h
//  MLCKit
//
//  Created by menglingchao on 2021/1/12.
//

#import <UIKit/UIKit.h>

/**图片选择工具类*/
@interface MLCImagePickerTool : NSObject

/**选取图片*/
+ (void)pickSingleImageInViewController:(UIViewController *)viewController didFinishPickingHandler:(void(^)(UIImage *image))didFinishPickingHandler;

@end
