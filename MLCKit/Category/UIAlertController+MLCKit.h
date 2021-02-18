//
//  UIAlertController+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2021/2/18.
//

#import <UIKit/UIKit.h>


@interface UIAlertController (MLCKit)


+ (instancetype)mlc_alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle optionTitles:(NSArray<NSString *> *)optionTitles optionsHandler:(void (^)(NSInteger))optionsHandler cancelTitle:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler;

/// 初始化方法
/// @param title 标题
/// @param message 描述
/// @param textFieldCount textField数量
/// @param textFieldConfigurationHandler textField配置
/// @param resultHandler 点击回调
+ (instancetype)mlc_alertControllerWithTitle:(NSString *)title message:(NSString *)message textFieldCount:(NSInteger)textFieldCount textFieldConfigurationHandler:(void (^)(UITextField *textField, NSInteger index))textFieldConfigurationHandler resultHandler:(void (^)(BOOL, NSArray<NSString *> *))resultHandler;

@end
