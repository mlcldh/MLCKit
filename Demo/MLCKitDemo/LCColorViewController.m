//
//  LCColorViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/12/9.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCColorViewController.h"
#import "MLCColorPickerViewControllerManager.h"

@interface LCColorViewController ()

@end

@implementation LCColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addPickButton];
}
#pragma mark -
- (void)addPickButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"选择颜色" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        if (@available(iOS 14.0, *)) {
            UIColorPickerViewController *pickerVC = [[UIColorPickerViewController alloc]init];
            pickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
            MLCColorPickerViewControllerManager *pickerVCManager = [[MLCColorPickerViewControllerManager alloc] initWithPickerViewController:pickerVC];
            [pickerVCManager setDidSelectColorHandler:^{
                NSLog(@"menglc didSelectColorHandler");
            }];
            [pickerVCManager setDidFinishHandler:^{
                NSLog(@"menglc didFinishHandler");
                [pickerVC dismissViewControllerAnimated:YES completion:nil];
            }];
            [self presentViewController:pickerVC animated:YES completion:nil];
        }
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
}

@end
