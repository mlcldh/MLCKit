//
//  MLCPHPickerViewControllerManager.m
//  MLCKit
//
//  Created by menglingchao on 2020/12/8.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "MLCPHPickerViewControllerManager.h"
#import <objc/runtime.h>

#if !TARGET_OS_MACCATALYST
static char *MLCPHPickerViewControllerManagerKey = "MLCPHPickerViewControllerManagerKey";

@implementation MLCPHPickerViewControllerManager

- (void)dealloc {
//    NSLog(@"menglc MLCPHPickerViewControllerManager dealloc");
}
- (instancetype)initWithPickerViewController:(PHPickerViewController *)pickerViewController {
    self = [super init];
    if (self) {
        _pickerViewController = pickerViewController;
        _pickerViewController.delegate = self;
        if (pickerViewController) {
            objc_setAssociatedObject(pickerViewController, MLCPHPickerViewControllerManagerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//防止自己被释放
        }
    }
    return self;
}
#pragma mark - PHPickerViewControllerDelegate
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results {
    if (self.didFinishPickingHandler) {
        self.didFinishPickingHandler(results);
    }
    objc_setAssociatedObject(picker, MLCPHPickerViewControllerManagerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//防止自己被释放
}

@end
#endif
