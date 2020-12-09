//
//  MLCColorPickerViewControllerManager.m
//  MLCKit
//
//  Created by menglingchao on 2020/12/9.
//

#import "MLCColorPickerViewControllerManager.h"
#import <objc/runtime.h>

static char *MLCColorPickerViewControllerManagerKey = "MLCColorPickerViewControllerManager";

@implementation MLCColorPickerViewControllerManager

- (void)dealloc {
//    NSLog(@"menglc MLCColorPickerViewControllerManager dealloc");
}
- (instancetype)initWithPickerViewController:(UIColorPickerViewController *)pickerViewController {
    self = [super init];
    if (self) {
        _pickerViewController = pickerViewController;
        _pickerViewController.delegate = self;
        if (pickerViewController) {
            objc_setAssociatedObject(pickerViewController, MLCColorPickerViewControllerManagerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//防止自己被释放
        }
    }
    return self;
}
- (void)clearSelfFromPickerViewController {//防止自己被释放
    if (!_pickerViewController) {
        return;
    }
    objc_setAssociatedObject(_pickerViewController, MLCColorPickerViewControllerManagerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - UIColorPickerViewControllerDelegate
- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController {
    if (_didSelectColorHandler) {
        _didSelectColorHandler();
    }
}
- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController {
    if (_didFinishHandler) {
        _didFinishHandler();
    }
    [self clearSelfFromPickerViewController];
}

@end
