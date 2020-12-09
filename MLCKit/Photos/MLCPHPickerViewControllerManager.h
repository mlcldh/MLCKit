//
//  MLCPHPickerViewControllerManager.h
//  MLCKit
//
//  Created by menglingchao on 2020/12/8.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <PhotosUI/PhotosUI.h>

/**将PHPickerViewController协议方法通过block回调出来*/
API_AVAILABLE(ios(14))
@interface MLCPHPickerViewControllerManager : NSObject<PHPickerViewControllerDelegate>

/***/
@property (nonatomic, weak, readonly) PHPickerViewController *pickerViewController;
/**选取回调*/
@property (nonatomic, copy) void(^didFinishPickingHandler)(NSArray<PHPickerResult *> *results);

/**初始化方法*/
- (instancetype)initWithPickerViewController:(PHPickerViewController *)pickerViewController;

@end
