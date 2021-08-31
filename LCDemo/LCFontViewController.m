//
//  LCFontViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/12/9.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCFontViewController.h"
#import "MLCFontPickerViewControllerManager.h"

@interface LCFontViewController ()

@end

@implementation LCFontViewController

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
    [button setTitle:@"选择字体" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        if (@available(iOS 13.0, *)) {
            UIFontPickerViewController *pickerVC = [[UIFontPickerViewController alloc]init];
            pickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
            MLCFontPickerViewControllerManager *pickerVCManager = [[MLCFontPickerViewControllerManager alloc] initWithPickerViewController:pickerVC];
            [pickerVCManager setDidPickFontHandler:^{
                NSLog(@"menglc didPickFontHandler");
            }];
            [pickerVCManager setDidCancelHandler:^{
                NSLog(@"menglc didCancelHandler");
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
