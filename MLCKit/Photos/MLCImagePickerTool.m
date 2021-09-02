//
//  MLCImagePickerTool.m
//  MLCKit
//
//  Created by menglingchao on 2021/1/12.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "MLCImagePickerTool.h"
#import "MLCImagePickerControllerManager.h"
#import "MLCPHPickerViewControllerManager.h"

@implementation MLCImagePickerTool

+ (void)pickSingleImageInViewController:(UIViewController *)viewController didFinishPickingHandler:(void(^)(UIImage *image))didFinishPickingHandler {
#if !TARGET_OS_MACCATALYST
    if (@available(iOS 14, *)) {
        PHPickerConfiguration *configuration = [[PHPickerConfiguration alloc] init];
        configuration.filter = [PHPickerFilter imagesFilter];
        
        PHPickerViewController *pickerVC = [[PHPickerViewController alloc] initWithConfiguration:configuration];
        pickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
        MLCPHPickerViewControllerManager *pickerVCManager = [[MLCPHPickerViewControllerManager alloc]initWithPickerViewController:pickerVC];
        [pickerVCManager setDidFinishPickingHandler:^(NSArray<PHPickerResult *> *results) {
            [pickerVC dismissViewControllerAnimated:YES completion:nil];
            PHPickerResult *obj = results.firstObject;
            if (![obj.itemProvider canLoadObjectOfClass:UIImage.class]) {
                return;
            }
            [obj.itemProvider loadObjectOfClass:UIImage.class completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
                if (error) {
                    return;
                }
                if ([object isKindOfClass:[UIImage class]]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (didFinishPickingHandler) {
                            didFinishPickingHandler(object);
                        }
                    });
                }
            }];
        }];
        [viewController presentViewController:pickerVC animated:YES completion:^{
        }];
        return;
    }
#endif
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.allowsEditing = YES;
    // 3. 设置打开照片相册类型(显示所有相簿)
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    // pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
//             pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.mediaTypes = [NSArray arrayWithObjects: @"public.image", nil];
    pickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    MLCImagePickerControllerManager *pickerVCManager = [[MLCImagePickerControllerManager alloc]initWithPickerViewController:pickerController];
    [pickerVCManager setDidFinishPickingMediaHandler:^(NSDictionary<UIImagePickerControllerInfoKey,id> *info) {
        [pickerController dismissViewControllerAnimated:YES completion:NULL];
        
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        if (didFinishPickingHandler) {
            didFinishPickingHandler(image);
        }
    }];
    [pickerVCManager setDidCancelHandler:^{
        [pickerController dismissViewControllerAnimated:YES completion:NULL];
    }];
    [viewController presentViewController:pickerController animated:YES completion:nil];
}

@end
