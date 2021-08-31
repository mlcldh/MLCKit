//
//  LCUseScanQRCodeViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2021/1/8.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "LCUseScanQRCodeViewController.h"
#import "MLCScanQRCodeViewController.h"

@interface LCUseScanQRCodeViewController ()

@end

@implementation LCUseScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addScanQRCodeButton];
}
#pragma mark -
- (void)addScanQRCodeButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"扫描二维码" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        MLCScanQRCodeViewController *scanQRCodeVC = [[MLCScanQRCodeViewController alloc]init];
        scanQRCodeVC.modalPresentationStyle = UIModalPresentationFullScreen;
        @weakify(scanQRCodeVC)
        [scanQRCodeVC setScanSuccessHandler:^(NSArray<NSString *> *qrCodeStrings) {
            @strongify(scanQRCodeVC)
            NSLog(@"menglc scanSuccessHandler %@", qrCodeStrings);
            [scanQRCodeVC dismissViewControllerAnimated:YES completion:nil];
        }];
        [scanQRCodeVC setTapCloseHandler:^{
            @strongify(scanQRCodeVC)
            [scanQRCodeVC dismissViewControllerAnimated:YES completion:nil];
        }];
        [self presentViewController:scanQRCodeVC animated:YES completion:nil];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
}

@end
