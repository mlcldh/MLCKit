//
//  MLCScanQRCodeViewController.m
//  MLCKit
//
//  Created by menglingchao on 2021/1/8.
//

#import "MLCScanQRCodeViewController.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"
#import "UIControl+MLCKit.h"
#import "MLCMacror.h"
#import "MLCImagePickerTool.h"
#import "MLCCaptureVideoPreviewLayerView.h"

@interface MLCScanQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;//会话对象
@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) AVCaptureDevice *device;//
@property (nonatomic) BOOL isLightOpen;//
@property (nonatomic, strong) MLCCaptureVideoPreviewLayerView *preview;//图层类
@property (nonatomic, strong) UIButton *closeButton;//
@property (nonatomic, strong) UIView *bottomView;//
@property (nonatomic, strong) UIButton *albumButton;//选取相册图片按钮
@property (nonatomic, strong) UIButton *lightButton;//开灯/关灯按钮
@property (nonatomic, strong) UIView *scanView;
@property (nonatomic) BOOL hasResult;//是否继续回调扫码结果

@end

@implementation MLCScanQRCodeViewController

- (void)dealloc {
    NSLog(@"menglc MLCScanQRCodeViewController dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupScanningQRCode];
    [self closeButton];
    [self bottomView];
}
#pragma mark - Getter
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_closeButton setImage:[self imageNamed:@"mlcScanQRCodeClose"] forState:(UIControlStateNormal)];
        @weakify(self)
        [_closeButton setMlc_touchUpInsideBlock:^{
            @strongify(self)
            if (self.tapCloseHandler) {
                self.tapCloseHandler();
            }
        }];
        [self.view addSubview:_closeButton];
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.view).offset(60);
        }];
    }
    return _closeButton;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(100);
        }];
        
        self.isLightOpen = NO;
        NSArray *buttons = @[self.albumButton, self.lightButton];
        for (UIButton *button in buttons) {
            [self.bottomView addSubview:button];
        }
        [buttons mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedItemLength:65 leadSpacing:100 tailSpacing:100];
        [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bottomView);
        }];
    }
    return _bottomView;
}
- (UIButton *)albumButton {
    if (!_albumButton) {
        _albumButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_albumButton setImage:[self imageNamed:@"mlcScanQRCodePhoto"] forState:(UIControlStateNormal)];
        @weakify(self)
        [_albumButton setMlc_touchUpInsideBlock:^{
            @strongify(self)
            [MLCImagePickerTool pickSingleImageInViewController:self didFinishPickingHandler:^(UIImage *image) {
                @strongify(self)
                [self scanQRCodeFromPhotosInTheAlbum:image];
            }];
        }];
    }
    return _albumButton;
}
- (UIButton *)lightButton {
    if (!_lightButton) {
        _lightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        @weakify(self)
        [_lightButton setMlc_touchUpInsideBlock:^{
            @strongify(self)
            self.isLightOpen = !self.isLightOpen;
        }];
    }
    return _lightButton;
}
- (UIImage *)imageNamed:(NSString *)imageName {
    if (!self.bundle) {
        NSString *filePath = [NSString stringWithFormat:@"%@/MLCKit.bundle", [NSBundle mainBundle].bundlePath];
        self.bundle = [NSBundle bundleWithPath:filePath];
    }
    return [UIImage imageNamed:imageName inBundle:self.bundle compatibleWithTraitCollection:nil];
}
#pragma mark - Setter
- (void)setIsLightOpen:(BOOL)isLightOpen {
    _isLightOpen = isLightOpen;
    [self.lightButton setImage:[self imageNamed:isLightOpen ? @"mlcScanQRCodeOff" : @"mlcScanQRCodeFlash"] forState:(UIControlStateNormal)];
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([_device hasTorch]) {
        [_device lockForConfiguration:nil];
        if (isLightOpen) {
            [_device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [_device setTorchMode: AVCaptureTorchModeOff];
        }
        [_device unlockForConfiguration];
    }
}
#pragma mark -
- (void)continueScanning {
    self.hasResult = NO;
}
- (void)setupScanningQRCode {
    // 初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    // 实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.preview = [[MLCCaptureVideoPreviewLayerView alloc]initWithFrame:CGRectZero session:_session];
    [self scanningQRCodeWithSession:_session];
}
//  扫描二维码 session    AVCaptureSession 对象 previewLayer    AVCaptureVideoPreviewLayer
- (void)scanningQRCodeWithSession:(AVCaptureSession *)session {
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
//    output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 5、初始化链接对象（会话对象）
    // 高质量采集率
    session.sessionPreset = AVCaptureSessionPresetHigh;
    
    // 5.1 添加会话输入
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    
    // 5.2 添加会话输出
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.preview.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    // 8、将图层插入当前视图
    [self.view addSubview:self.preview];
    [self.preview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 9、启动会话
    [session startRunning];
}
- (void)scanQRCodeFromPhotosInTheAlbum:(UIImage *)image {
    // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
    // 声明一个CIDetector，并设定识别类型 CIDetectorTypeQRCode
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    NSMutableArray *qrCodeStrings = [NSMutableArray array];
    for (CIQRCodeFeature *feature in features) {
        NSString *qrCodeString = feature.messageString;
        [qrCodeStrings addObject:qrCodeString];
    }
    if (self.scanSuccessHandler) {
        self.scanSuccessHandler(qrCodeStrings);
    }
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (self.hasResult) {
        return;
    }
//    // 1、如果扫描完成，停止会话
//    [self.session stopRunning];
//
//    // 2、删除预览图层
//    [self.previewLayer removeFromSuperlayer];
//
//    // 3、设置界面显示扫描结果
    if (!metadataObjects.count) {
        return;
    }
    self.hasResult = YES;
    NSMutableArray *qrCodeStrings = [NSMutableArray array];
    for (AVMetadataMachineReadableCodeObject *metadataObject in metadataObjects) {
        NSString *qrCodeString = metadataObject.stringValue;
        [qrCodeStrings addObject:qrCodeString];
    }
    if (self.scanSuccessHandler) {
        self.scanSuccessHandler(qrCodeStrings);
    }
}

@end
