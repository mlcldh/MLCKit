//
//  MLCUIImagePickerControllerManager.m
//  MLCKit
//
//  Created by menglingchao on 2020/12/8.
//

#import "MLCUIImagePickerControllerManager.h"
#import <objc/runtime.h>

static char *MLCUIImagePickerControllerManagerKey = "MLCUIImagePickerControllerManagerKey";

@implementation MLCUIImagePickerControllerManager

- (void)dealloc {
//    NSLog(@"menglc MLCUIImagePickerControllerManager dealloc");
}
- (instancetype)initWithPickerViewController:(UIImagePickerController *)pickerViewController {
    self = [super init];
    if (self) {
        _pickerViewController = pickerViewController;
        _pickerViewController.delegate = self;
        if (pickerViewController) {
            objc_setAssociatedObject(pickerViewController, MLCUIImagePickerControllerManagerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//防止自己被释放
        }
    }
    return self;
}
- (void)clearSelfFromPickerViewController {//防止自己被释放
    if (!_pickerViewController) {
        return;
    }
    objc_setAssociatedObject(_pickerViewController, MLCUIImagePickerControllerManagerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    if (self.didFinishPickingMediaHandler) {
        self.didFinishPickingMediaHandler(info);
    }
    [self clearSelfFromPickerViewController];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (self.didCancelHandler) {
        self.didCancelHandler();
    }
    [self clearSelfFromPickerViewController];
}

@end
