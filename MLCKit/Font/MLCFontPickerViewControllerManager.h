//
//  MLCFontPickerViewControllerManager.h
//  MLCKit
//
//  Created by menglingchao on 2020/12/9.
//

#import <UIKit/UIKit.h>

/**将UIDocumentPickerViewController协议方法通过block回调出来*/
API_AVAILABLE(ios(13.0))
@interface MLCFontPickerViewControllerManager : NSObject<UIFontPickerViewControllerDelegate>

/***/
@property (nonatomic, weak, readonly) UIFontPickerViewController *pickerViewController;
/**选取回调*/
@property (nonatomic, copy) void(^didPickFontHandler)(void);
/**取消回调*/
@property (nonatomic, copy) void(^didCancelHandler)(void);

/**初始化方法*/
- (instancetype)initWithPickerViewController:(UIFontPickerViewController *)pickerViewController;

@end
