//
//  MLCFontPickerViewControllerManager.m
//  MLCKit
//
//  Created by menglingchao on 2020/12/9.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "MLCFontPickerViewControllerManager.h"
#import <objc/runtime.h>

static char *MLCFontPickerViewControllerManagerKey = "MLCFontPickerViewControllerManager";

@implementation MLCFontPickerViewControllerManager

- (void)dealloc {
//    NSLog(@"menglc MLCFontPickerViewControllerManager dealloc");
}
- (instancetype)initWithPickerViewController:(UIFontPickerViewController *)pickerViewController {
    self = [super init];
    if (self) {
        _pickerViewController = pickerViewController;
        _pickerViewController.delegate = self;
        if (pickerViewController) {
            objc_setAssociatedObject(pickerViewController, MLCFontPickerViewControllerManagerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//防止自己被释放
        }
    }
    return self;
}
- (void)clearSelfFromPickerViewController {//防止自己被释放
    if (!_pickerViewController) {
        return;
    }
    objc_setAssociatedObject(_pickerViewController, MLCFontPickerViewControllerManagerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - UIFontPickerViewControllerDelegate
- (void)fontPickerViewControllerDidCancel:(UIFontPickerViewController *)viewController {
    if (_didCancelHandler) {
        _didCancelHandler();
    }
    [self clearSelfFromPickerViewController];
}
- (void)fontPickerViewControllerDidPickFont:(UIFontPickerViewController *)viewController {
    if (_didPickFontHandler) {
        _didCancelHandler();
    }
    [self clearSelfFromPickerViewController];
}

@end
