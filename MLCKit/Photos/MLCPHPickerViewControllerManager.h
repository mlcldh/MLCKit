//
//  MLCPHPickerViewControllerManager.h
//  MLCKit
//
//  Created by menglingchao on 2020/12/8.
//

#import <Foundation/Foundation.h>
#import <PhotosUI/PhotosUI.h>

API_AVAILABLE(ios(14))
/**将PHPickerViewController部分协议方法通过block回调出来*/
@interface MLCPHPickerViewControllerManager : NSObject<PHPickerViewControllerDelegate>

/***/
@property (nonatomic, weak, readonly) PHPickerViewController *pickerViewController;
/**选取回调*/
@property (nonatomic, copy) void(^didFinishPickingHandler)(NSArray<PHPickerResult *> *results);

/**初始化方法*/
- (instancetype)initWithPickerViewController:(PHPickerViewController *)pickerViewController;

@end
