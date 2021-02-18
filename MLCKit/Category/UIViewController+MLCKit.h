//
//  UIViewController+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2020/11/17.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (MLCKit)

/**弹出alert*/
- (void)mlc_showAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle handler:(void (^)(void))handler;

/**弹出confirm，一个选项*/
- (void)mlc_showConfirmWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmHandler:(void (^)(void))confirmHandler cancelTitle:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler;

/**弹出confirm，多个选项*/
- (void)mlc_showConfirmWithTitle:(NSString *)title message:(NSString *)message optionTitles:(NSArray<NSString *> *)optionTitles optionsHandler:(void (^)(NSInteger index))optionsHandler cancelTitle:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler;

/**弹出ActionSheet，多个选项*/
- (void)mlc_showActionSheetWithTitle:(NSString *)title message:(NSString *)message optionTitles:(NSArray<NSString *> *)optionTitles optionsHandler:(void (^)(NSInteger index))optionsHandler cancelTitle:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler;

/**弹出prompt，一个输入框*/
- (void)mlc_showPromptWithTitle:(NSString *)title message:(NSString *)message configurationHandler:(void (^)(UITextField *textField))configurationHandler resultHandler:(void (^)(BOOL isCancel, NSString *result))resultHandler;

/// 弹出prompt，多个输入框
/// @param title 标题
/// @param message 描述
/// @param textFieldCount textField数量
/// @param textFieldConfigurationHandler textField配置
/// @param resultHandler 点击回调
- (void)mlc_showPromptWithTitle:(NSString *)title message:(NSString *)message textFieldCount:(NSInteger)textFieldCount textFieldConfigurationHandler:(void (^)(UITextField *textField, NSInteger index))textFieldConfigurationHandler resultHandler:(void (^)(BOOL isCancel, NSArray<NSString *> *results))resultHandler;

@end
