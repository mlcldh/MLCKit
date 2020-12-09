//
//  MLCDocumentPickerViewControllerManager.m
//  MLCKit
//
//  Created by menglingchao on 2020/12/9.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "MLCDocumentPickerViewControllerManager.h"
#import <objc/runtime.h>

static char *MLCDocumentPickerViewControllerManagerKey = "MLCDocumentPickerViewControllerManager";

@implementation MLCDocumentPickerViewControllerManager

- (void)dealloc {
//    NSLog(@"menglc MLCDocumentPickerViewControllerManager dealloc");
}
- (instancetype)initWithPickerViewController:(UIDocumentPickerViewController *)pickerViewController {
    self = [super init];
    if (self) {
        _pickerViewController = pickerViewController;
        _pickerViewController.delegate = self;
        if (pickerViewController) {
            objc_setAssociatedObject(pickerViewController, MLCDocumentPickerViewControllerManagerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//防止自己被释放
        }
    }
    return self;
}
- (void)clearSelfFromPickerViewController {//防止自己被释放
    if (!_pickerViewController) {
        return;
    }
    objc_setAssociatedObject(_pickerViewController, MLCDocumentPickerViewControllerManagerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - UIDocumentPickerDelegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls API_AVAILABLE(ios(11.0)) {
    if (_didPickDocumentsHandler) {
        _didPickDocumentsHandler(urls);
    }
    [self clearSelfFromPickerViewController];
}
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    if (_wasCancelledHandler) {
        _wasCancelledHandler();
    }
    [self clearSelfFromPickerViewController];
}
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    if (_didPickDocumentsHandler) {
        _didPickDocumentsHandler(url ? @[url] : nil);
    }
    [self clearSelfFromPickerViewController];
}

@end
