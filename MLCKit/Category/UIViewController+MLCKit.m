//
//  UIViewController+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2020/11/17.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "UIViewController+MLCKit.h"

@implementation UIViewController (MLCKit)

- (void)mlc_showAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle handler:(void (^)(void))handler {
    [self mlc_showConfirmWithTitle:title message:message confirmTitle:actionTitle confirmHandler:^{
        if (handler) {
            handler();
        }
    } cancelTitle:nil cancelHandler:nil];
}
- (void)mlc_showConfirmWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmHandler:(void (^)(void))confirmHandler cancelTitle:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler {
    [self mlc_showConfirmWithTitle:title message:message optionTitles:@[confirmTitle] optionsHandler:^(NSInteger index) {
        if (confirmHandler) {
            confirmHandler();
        }
    } cancelTitle:cancelTitle cancelHandler:cancelHandler];
}
- (void)mlc_showConfirmWithTitle:(NSString *)title message:(NSString *)message optionTitles:(NSArray<NSString *> *)optionTitles optionsHandler:(void (^)(NSInteger))optionsHandler cancelTitle:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    for (NSInteger i = 0; i < optionTitles.count; i ++) {
        [alertController addAction:[UIAlertAction actionWithTitle:optionTitles[i] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (optionsHandler) {
                optionsHandler(i);
            }
        }]];
    }
    if (cancelTitle) {
        [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            if (cancelHandler) {
                cancelHandler();
            }
        }]];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)mlc_showPromptWithTitle:(NSString *)title message:(NSString *)message configurationHandler:(void (^)(UITextField *))configurationHandler resultHandler:(void (^)(BOOL, NSString *))resultHandler {
    [self mlc_showPromptWithTitle:title message:message textFieldCount:1 configurationHandler:^(UITextField *textField, NSInteger index) {
        if (configurationHandler) {
            configurationHandler(textField);
        }
    } resultHandler:^(BOOL isCancel, NSArray<NSString *> *results) {
        if (resultHandler) {
            resultHandler(isCancel, results.firstObject);
        }
    }];
}
- (void)mlc_showPromptWithTitle:(NSString *)title message:(NSString *)message textFieldCount:(NSInteger)textFieldCount configurationHandler:(void (^)(UITextField *textField, NSInteger index))configurationHandler resultHandler:(void (^)(BOOL, NSArray<NSString *> *))resultHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (NSInteger i = 0; i < textFieldCount; i ++) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            if (configurationHandler) {
                configurationHandler(textField, i);
            }
        }];
    }
    [alertController addAction:([UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableArray *results = [NSMutableArray array];
        for (NSInteger i = 0; i < textFieldCount; i ++) {
            NSString *text = alertController.textFields[i].text;
            [results addObject:text ? : [NSNull null]];
        }
        resultHandler(NO, results);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        resultHandler(YES, nil);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
