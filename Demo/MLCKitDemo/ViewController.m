//
//  ViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "ViewController.h"
#import "MLCLocalFolderViewController.h"
#import "MLCMacror.h"
#import "UIView+MLCKit.h"
#import "UIControl+MLCKit.h"
#import "NSObject+MLCKit.h"
#import "NSString+MLCKit.h"
#import "MLCUtility.h"
#import "MLCPhotoPermissionManager.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *aLabel;//
@property (nonatomic, strong) UIButton *button;//
@property (nonatomic, strong) UISwitch *aSwitch;//
@property (nonatomic, strong) UIButton *seeLocalFileButton;//
@property (nonatomic, strong) UIButton *requestAlbumPermissionButton;//
@property (nonatomic, strong) UIButton *requestCameraPermissionButton;//

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self aLabel];
//    [self button];
//    [self aSwitch];
//    [self seeLocalFileButton];
//    [self requestAlbumPermissionButton];
//    [self requestCameraPermissionButton];
//    [MLCUtility idfa];
//    [self useUrlEncode];
//    [self useUrlDecode];
}
#pragma mark - Getter
- (UILabel *)aLabel {
    if (!_aLabel) {
        _aLabel = [[UILabel alloc]init];
        _aLabel.backgroundColor = [UIColor purpleColor];
        _aLabel.textColor = [UIColor blackColor];
        _aLabel.textAlignment = NSTextAlignmentCenter;
//        _aLabel.font = [UIFont systemFontOfSize:18];
        _aLabel.text = @"轻学堂";
        [_aLabel mlc_addGestureRecognizerWithType:(MLCGestureRecognizerTypeTap) callback:^(UIGestureRecognizer *recognizer) {
            UILabel *label = (UILabel *)(recognizer.view);
            MLCLog(@"tap %@", label.text);
        }];
        [_aLabel mlc_addGestureRecognizerWithType:(MLCGestureRecognizerTypeLongPress) callback:^(UIGestureRecognizer *recognizer) {
            UILongPressGestureRecognizer *longPressGestureRecognizer = (UILongPressGestureRecognizer *)recognizer;
            if (longPressGestureRecognizer.state != UIGestureRecognizerStateBegan) {
                return;
            }
            UILabel *label = (UILabel *)longPressGestureRecognizer.view;
            MLCLog(@"longPress %@", label.text);
        }];
        [_aLabel mlc_addGestureRecognizerWithType:(MLCGestureRecognizerTypePan) callback:^(UIGestureRecognizer *recognizer) {
            MLCLog(@"menglc pan");
        }];
        [_aLabel mlc_removeGestureRecognizersWithType:(MLCGestureRecognizerTypePan)];
        [_aLabel mlc_removeAllGestureRecognizers];
        [_aLabel mlc_addGestureRecognizerWithType:(MLCGestureRecognizerTypeSwipe) callback:^(UIGestureRecognizer *recognizer) {
            MLCLog(@"menglc swipe");
        }];
        [self.view addSubview:_aLabel];
        [_aLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.top.equalTo(self.view).offset(100);
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
    }
    return _aLabel;
}
- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc]init];
        _button.backgroundColor = [UIColor purpleColor];
        [_button setTitle:@"button" forState:(UIControlStateNormal)];
        [_button mlc_addActionForControlEvents:(UIControlEventTouchUpInside) callback:^(id sender) {
            MLCLog(@"menglc button UIControlEventTouchUpInside");
        }];
        [_button mlc_addActionForControlEvents:(UIControlEventTouchUpInside) callback:^(id sender) {
            MLCLog(@"menglc button UIControlEventTouchUpInside 2");
        }];
//        [_button mlc_removeAllActionsForControlEvents:(UIControlEventTouchUpInside)];
        [_button mlc_removeAllActions];
        [_button mlc_addActionForControlEvents:(UIControlEventTouchUpInside) callback:^(id sender) {
            MLCLog(@"menglc button UIControlEventTouchUpInside 3");
        }];
        [self.view addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.top.equalTo(self.view).offset(100);
        }];
    }
    return _button;
}
- (UISwitch *)aSwitch {
    if (!_aSwitch) {
        _aSwitch = [[UISwitch alloc]init];
        [_aSwitch mlc_addActionForControlEvents:(UIControlEventValueChanged) callback:^(id sender) {
            UISwitch *switch2 = sender;
            MLCLog(@"menglc switch2.isOn = %@", @(switch2.isOn));
        }];
//        [_aSwitch mlc_addActionForControlEvents:(UIControlEventValueChanged) callback:^(id sender) {
//            UISwitch *switch2 = sender;
//            MLCLog(@"menglc switch2.isOn 2 = %@", @(switch2.isOn));
//        }];
        [self.view addSubview:_aSwitch];
        [_aSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.top.equalTo(self.view).offset(100);
        }];
    }
    return _aSwitch;
}
- (UIButton *)seeLocalFileButton {
    if (!_seeLocalFileButton) {
        _seeLocalFileButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _seeLocalFileButton.backgroundColor = [UIColor purpleColor];
        [_seeLocalFileButton setTitle:@"seeLocalFile" forState:(UIControlStateNormal)];
        @weakify(self)
        [_seeLocalFileButton setMlc_touchUpInsideBlock:^{
            @strongify(self)
            NSString *folderPath = NSHomeDirectory();
            MLCLocalFolderViewController *localFolderVC = [[MLCLocalFolderViewController alloc]initWithFolderPath:folderPath];
            [self.navigationController pushViewController:localFolderVC animated:YES];
        }];
        [self.view addSubview:_seeLocalFileButton];
        [_seeLocalFileButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(100);
            make.top.equalTo(self.view).offset(100);
        }];
    }
    return _seeLocalFileButton;
}
- (UIButton *)requestAlbumPermissionButton {
    if (!_requestAlbumPermissionButton) {
        _requestAlbumPermissionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _requestAlbumPermissionButton.backgroundColor = [UIColor purpleColor];
        [_requestAlbumPermissionButton setTitle:@"请求相册权限" forState:(UIControlStateNormal)];
        @weakify(self)
        [_requestAlbumPermissionButton setMlc_touchUpInsideBlock:^{
            @strongify(self)
            [MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypePhotoLibrary) successCallback:^{
                NSLog(@"已经获得权限");
            } fromViewController:self];
        }];
        [self.view addSubview:_requestAlbumPermissionButton];
        [_requestAlbumPermissionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.top.equalTo(self.view).offset(100);
        }];
    }
    return _requestAlbumPermissionButton;
}
- (UIButton *)requestCameraPermissionButton {
    if (!_requestCameraPermissionButton) {
        _requestCameraPermissionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _requestCameraPermissionButton.backgroundColor = [UIColor purpleColor];
        [_requestCameraPermissionButton setTitle:@"请求相机权限" forState:(UIControlStateNormal)];
        @weakify(self)
        [_requestCameraPermissionButton setMlc_touchUpInsideBlock:^{
            @strongify(self)
            [MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypeCamera) successCallback:^{
                NSLog(@"已经获得权限");
            } fromViewController:self];
        }];
        [self.view addSubview:_requestCameraPermissionButton];
        [_requestCameraPermissionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.requestAlbumPermissionButton.mas_right).offset(20);
            make.top.equalTo(self.view).offset(100);
        }];
    }
    return _requestCameraPermissionButton;
}
#pragma mark -
- (void)useUrlEncode {//URL编码
//    NSString *string = @"汉字666";
    NSString *string = @"https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊";
    NSString *encodeString = [string mlc_urlEncode];
    NSLog(@"%@, %@",string, encodeString);
}
- (void)useUrlDecode {//URL解码
//    NSString *string = @"汉字666";
    NSString *string = @"https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊";
    NSString *encodeString = [string mlc_urlEncode];
    NSString *decodeString = [encodeString mlc_urlDecode];
    NSLog(@"string = %@,\n encodeString = %@,\n decodeString = %@",string, encodeString, decodeString);
}

@end
