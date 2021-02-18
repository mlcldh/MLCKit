//
//  UIImage+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2021/2/18.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "UIImage+MLCKit.h"

@implementation UIImage (MLCKit)

- (UIImage *)mlc_gaussianBlurImageWithRadius:(float)radius {
    return [self mlc_imageWithName:@"CIGaussianBlur" filterHandler:^(CIFilter *filter) {
        [filter setValue:@(radius) forKey:kCIInputRadiusKey];
    }];
}
- (UIImage *)mlc_maximumComponentImage {
    return [self mlc_imageWithName:@"CIMaximumComponent" filterHandler:nil];
}
- (UIImage *)mlc_minimumComponentImage {
    return [self mlc_imageWithName:@"CIMinimumComponent" filterHandler:nil];
}
- (UIImage *)mlc_imageWithName:(NSString *)name filterHandler:(void(^)(CIFilter *filter))filterHandler {
    CIImage *image = [CIImage imageWithCGImage:self.CGImage];
    //创建CIFilter
    CIFilter *filter = [CIFilter filterWithName:name];
    //设置滤镜输入参数
    [filter setValue:image forKey:kCIInputImageKey];
    //进行默认设置
    [filter setDefaults];
    
    if (filterHandler) {
        filterHandler(filter);
    }
    
    //创建处理后的图片
    CIImage *resultImage = filter.outputImage;
    //创建CIContext对象
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:resultImage fromRect:CGRectMake(0, 0, self.size.width,self.size.height)];
    if (!imageRef) {
        return nil;
    }
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    return newImage;
}

@end
