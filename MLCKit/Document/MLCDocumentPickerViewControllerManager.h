//
//  MLCDocumentPickerViewControllerManager.h
//  MLCKit
//
//  Created by menglingchao on 2020/12/9.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**将UIDocumentPickerViewController协议方法通过block回调出来*/
@interface MLCDocumentPickerViewControllerManager : NSObject<UIDocumentPickerDelegate>

/***/
@property (nonatomic, weak, readonly) UIDocumentPickerViewController *pickerViewController;
/**选取回调*/
@property (nonatomic, copy) void(^didPickDocumentsHandler)(NSArray<NSURL *> *urls);
/**取消回调*/
@property (nonatomic, copy) void(^wasCancelledHandler)(void);

/**初始化方法*/
- (instancetype)initWithPickerViewController:(UIDocumentPickerViewController *)pickerViewController;

@end
