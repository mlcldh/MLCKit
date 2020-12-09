//
//  LCShowAlertViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/11/17.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCShowAlertViewController.h"
#import "UIViewController+MLCKit.h"
#import "Masonry.h"
#import "UIControl+MLCKit.h"
#import "MLCMacror.h"

@interface LCShowAlertViewController ()

@end

@implementation LCShowAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showAlert];
    [self showConfirm];
    [self showConfirm2];
    [self showPrompt];
    [self showPrompt2];
}
#pragma mark -
- (void)showAlert {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"弹出alert" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [self mlc_showAlertWithTitle:@"title" message:@"message" actionTitle:@"确定" handler:^{
            NSLog(@"menglc showAlert 确定");
        }];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
}
- (void)showConfirm {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"弹出confirm" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [self mlc_showConfirmWithTitle:@"title" message:@"message" confirmTitle:@"确定" confirmHandler:^{
            NSLog(@"menglc showConfirm 确定");
        } cancelTitle:@"取消" cancelHandler:^{
            NSLog(@"menglc showConfirm 取消");
        }];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(150);
    }];
}
- (void)showConfirm2 {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"弹出多个选项" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [self mlc_showConfirmWithTitle:@"title" message:@"message" optionTitles:@[@"选项1", @"选项2"] optionsHandler:^(NSInteger index) {
            NSLog(@"menglc showConfirm2 选项%@", @(index + 1));
        } cancelTitle:@"取消" cancelHandler:^{
            NSLog(@"menglc showConfirm 取消");
        }];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(150);
        make.top.equalTo(self.view).offset(150);
    }];
}
- (void)showPrompt {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"弹出1个输入框的prompt" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [self mlc_showPromptWithTitle:@"title" message:@"message" configurationHandler:^(UITextField *textField) {
            textField.placeholder = @"用户昵称";
            textField.text = @"meng";
        } resultHandler:^(BOOL isCancel, NSString *result) {
            NSLog(@"menglc isCancel = %@, result = %@", @(isCancel), result);
        }];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(200);
    }];
}
- (void)showPrompt2 {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"弹出多个输入框的prompt" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [self mlc_showPromptWithTitle:@"title" message:@"message" textFieldCount:2 configurationHandler:^(UITextField *textField, NSInteger index) {
            switch (index) {
                case 0: {
                    textField.placeholder = @"用户名";
                    textField.text = @"mlc";
                }
                    break;
                case 1: {
                    textField.secureTextEntry = YES;
                    textField.placeholder = @"密码";
                    textField.text = @"123456";
                }
                    break;
                default:
                    break;
            }
            
        } resultHandler:^(BOOL isCancel, NSArray<NSString *> *results) {
            NSLog(@"menglc isCancel = %@, results = %@", @(isCancel), results);
        }];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(250);
    }];
}

@end
