//
//  MLCColorPickerViewControllerManager.h
//  MLCKit
//
//  Created by menglingchao on 2020/12/9.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>

#if !TARGET_OS_MACCATALYST
/**将UIColorPickerViewController协议方法通过block回调出来*/
API_AVAILABLE(ios(14.0))
@interface MLCColorPickerViewControllerManager : NSObject<UIColorPickerViewControllerDelegate>

/***/
@property (nonatomic, weak, readonly) UIColorPickerViewController *pickerViewController;
/**选取回调*/
@property (nonatomic, copy) void(^didSelectColorHandler)(void);
/**完成回调*/
@property (nonatomic, copy) void(^didFinishHandler)(void);

/**初始化方法*/
- (instancetype)initWithPickerViewController:(UIColorPickerViewController *)pickerViewController;

@end
#endif
