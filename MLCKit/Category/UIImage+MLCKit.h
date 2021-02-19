//
//  UIImage+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2021/2/18.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (MLCKit)

/**高斯模糊*/
- (UIImage *)mlc_gaussianBlurImageWithRadius:(float)radius;
/***/
- (UIImage *)mlc_maximumComponentImage;
/***/
- (UIImage *)mlc_minimumComponentImage;
/***/
- (UIImage *)mlc_imageWithName:(NSString *)name filterHandler:(void(^)(CIFilter *filter))filterHandler;
/**二维码图片*/
+ (UIImage *)mlc_imageWithQRCode:(NSString *)QRCode imageWidth:(CGFloat)imageWidth;
/**修改图片大小*/
+ (UIImage *)mlc_imageWithCIImage:(CIImage *)image imageWidth:(CGFloat) imageWidth;
/**改变图片颜色*/
- (UIImage *)mlc_specialColorImageWithColor:(UIColor *)color;

@end
