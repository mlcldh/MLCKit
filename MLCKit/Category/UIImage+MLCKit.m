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
    if (!filter) {
        return nil;
    }
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
+ (UIImage *)mlc_imageWithQRCode:(NSString *)QRCode imageWidth:(CGFloat)imageWidth {
    if (!QRCode.length || imageWidth <= 0) {
        return nil;
    }
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3. 给过滤器添加数据
    NSData *data = [QRCode dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    
    // 6.因为生成的二维码模糊，所以通过createNonInterpolatedUIImageFormCIImage:outputImage来获得高清的二维码图片
    UIImage *image = [self mlc_imageWithCIImage:outputImage imageWidth:imageWidth];
    return image;
}
+ (UIImage *)mlc_imageWithCIImage:(CIImage *)image imageWidth:(CGFloat) imageWidth {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat extentWidth = CGRectGetWidth(extent);
    CGFloat extentHeight = CGRectGetHeight(extent);
    if (!extentWidth || !extentHeight) {//保护下
        return nil;
    }
    CGFloat scale = MIN(imageWidth/extentWidth, imageWidth/extentHeight);
    
    // 1.创建bitmap;
    size_t width = extentWidth * scale;
    size_t height = extentHeight * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
- (UIImage *)mlc_specialColorImageWithColor:(UIColor *)color {
    CGFloat red ,green,blue,alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    const int imageWidth = self.size.width;
    const int imageHeight = self.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    //Create context
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, imageWidth, imageHeight), self.CGImage);
    
    //Traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            //Change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red * 255; //0~255
            ptr[2] = green * 255;
            ptr[1] = blue * 255;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    CGDataProviderRef dataProviderRef = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, MLCProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProviderRef,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProviderRef);
    UIImage* img = [UIImage imageWithCGImage:imageRef];
    
    //Release
    CGImageRelease(imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    return img;
}
void MLCProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

@end
