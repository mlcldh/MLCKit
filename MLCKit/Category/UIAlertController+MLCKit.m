//
//  UIAlertController+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2021/2/18.
//

#import "UIAlertController+MLCKit.h"

@implementation UIAlertController (MLCKit)

+ (instancetype)mlc_alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle optionTitles:(NSArray<NSString *> *)optionTitles optionsHandler:(void (^)(NSInteger))optionsHandler cancelTitle:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
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
    return alertController;
}
+ (instancetype)mlc_alertControllerWithTitle:(NSString *)title message:(NSString *)message textFieldCount:(NSInteger)textFieldCount textFieldConfigurationHandler:(void (^)(UITextField *, NSInteger))textFieldConfigurationHandler resultHandler:(void (^)(BOOL, NSArray<NSString *> *))resultHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (NSInteger i = 0; i < textFieldCount; i ++) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            if (textFieldConfigurationHandler) {
                textFieldConfigurationHandler(textField, i);
            }
        }];
    }
    return alertController;
}
@end
