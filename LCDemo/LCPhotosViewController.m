//
//  LCPhotosViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCPhotosViewController.h"
#import "Masonry.h"
#import "MLCPhotoPermissionManager.h"
#import "MLCPHPickerViewControllerManager.h"
#import "MLCImagePickerControllerManager.h"
#import "MLCMacror.h"
#import "UIControl+MLCKit.h"
#import "MLCOpenUtility.h"

@interface LCPhotosViewController ()

@end

@implementation LCPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addRequestAlbumPermissionButton];
    [self addRequestAlbumPermissionAndShowUIButton];
    [self addUseRequestCameraPermissionButton];
    [self addUseRequestCameraPermissionAndShowUIButton];
    [self addOpenSettingsButton];
    [self addPickButton];
}
#pragma mark -
- (void)addRequestAlbumPermissionButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"请求相册权限" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypePhotoLibrary) sourceTypeUnavailableHandler:^{
            NSLog(@"当前设备没有相册功能");
        } isNotDeterminedHandler:^{
            NSLog(@"相册权限之前还未处理");
        } handler:^(BOOL success, BOOL isLimited) {
            if (success) {
                NSLog(@"已经获得相册权限");
                if (isLimited) {
                    NSLog(@"读取相册受限");
                }
            } else {
                NSLog(@"相册权限被拒绝");
            }
        }];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
}
- (void)addRequestAlbumPermissionAndShowUIButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"请求相册权限并且显示UI" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypePhotoLibrary) handler:^(BOOL isLimited) {
            NSLog(@"已经获得相册权限");
            if (isLimited) {
                NSLog(@"读取相册受限");
            }
        } fromViewController:self];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(150);
    }];
}
- (void)addUseRequestCameraPermissionButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"请求相机权限" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypeCamera) sourceTypeUnavailableHandler:^{
            NSLog(@"当前设备没有相机功能");
        } isNotDeterminedHandler:^{
            NSLog(@"相机权限之前还未处理");
        } handler:^(BOOL success, BOOL isLimited) {
            if (success) {
                NSLog(@"已经获得相机权限");
                if (isLimited) {
                    NSLog(@"读取受限");
                }
            } else {
                NSLog(@"相机权限被拒绝");
            }
        }];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(200);
    }];
}
- (void)addUseRequestCameraPermissionAndShowUIButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"请求相机权限并且显示UI" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypeCamera) handler:^(BOOL isLimited) {
            NSLog(@"已经获得相机权限");
        } fromViewController:self];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(250);
    }];
}
- (void)addOpenSettingsButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"跳转到app设置页面" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [MLCOpenUtility openSettings];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(300);
    }];
}
- (void)addPickButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"选择照片" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
#if !TARGET_OS_MACCATALYST
        if (@available(iOS 14, *)) {
            PHPickerConfiguration *configuration = [[PHPickerConfiguration alloc] init];
//                    configuration.filter = [PHPickerFilter imagesFilter];
//                configuration.filter = [PHPickerFilter videosFilter];
            configuration.selectionLimit = 0; // 默认为1，为0时表示可多选。
            
            PHPickerViewController *pickerVC = [[PHPickerViewController alloc] initWithConfiguration:configuration];
            pickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
            MLCPHPickerViewControllerManager *pickerVCManager = [[MLCPHPickerViewControllerManager alloc]initWithPickerViewController:pickerVC];
            [pickerVCManager setDidFinishPickingHandler:^(NSArray<PHPickerResult *> *results) {
                [pickerVC dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"menglc MLCPHPickerViewControllerManager didFinishPickingHandler %@", results);
            }];
            [self presentViewController:pickerVC animated:YES completion:^{
                
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
            
            UIImage *image = info[UIImagePickerControllerEditedImage];
            NSLog(@"menglc MLCImagePickerControllerManager didFinishPickingMediaHandler %@", image);
        }];
        [pickerVCManager setDidCancelHandler:^{
            [pickerController dismissViewControllerAnimated:YES completion:NULL];
            NSLog(@"menglc MLCImagePickerControllerManager didCancelHandler");
        }];
        [self presentViewController:pickerController animated:YES completion:nil];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(350);
    }];
}

@end
