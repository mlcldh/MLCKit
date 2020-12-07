//
//  LCPhotoPermissionViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCPhotoPermissionViewController.h"
#import "Masonry.h"
#import "MLCPhotoPermissionManager.h"
#import "MLCMacror.h"
#import "UIControl+MLCKit.h"
#import "MLCOpenUtility.h"

@interface LCPhotoPermissionViewController ()

@end

@implementation LCPhotoPermissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestAlbumPermission];
    [self requestAlbumPermissionAndShowUI];
    [self useRequestCameraPermission];
    [self useRequestCameraPermissionAndShowUI];
    [self addOpenSettingsButton];
}
#pragma mark -
- (void)requestAlbumPermission {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"请求相册权限" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypePhotoLibrary) handler:^(BOOL isSourceTypeAvailable, BOOL success, BOOL isLimited, BOOL isNotDetermined) {
            if (!isSourceTypeAvailable) {
                NSLog(@"当前设备没有相册功能");
                return;
            }
            if (isNotDetermined) {
                NSLog(@"相册权限之前还未处理");
            }
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
- (void)requestAlbumPermissionAndShowUI {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"请求相册权限并且显示UI" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypePhotoLibrary) handler:^{
            NSLog(@"已经获得相册权限");
        } fromViewController:self];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(150);
    }];
}
- (void)useRequestCameraPermission {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"请求相机权限" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypeCamera) handler:^(BOOL isSourceTypeAvailable, BOOL success, BOOL isLimited, BOOL isNotDetermined) {
            if (!isSourceTypeAvailable) {
                NSLog(@"当前设备没有相机功能");
                return;
            }
            if (isNotDetermined) {
                NSLog(@"相机权限之前还未处理");
            }
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
- (void)useRequestCameraPermissionAndShowUI {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"请求相机权限并且显示UI" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypeCamera) handler:^{
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

@end
