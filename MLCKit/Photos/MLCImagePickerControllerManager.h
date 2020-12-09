//
//  MLCImagePickerControllerManager.h
//  MLCKit
//
//  Created by menglingchao on 2020/12/8.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 将UIImagePickerController部分协议方法通过block回调出来
 * 想扩展到更多部分协议方法的话，可以继承该类
 */
@interface MLCImagePickerControllerManager : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/***/
@property (nonatomic, weak, readonly) UIImagePickerController *pickerViewController;
/**选取回调*/
@property (nonatomic, copy) void(^didFinishPickingMediaHandler)(NSDictionary<UIImagePickerControllerInfoKey,id> *info);
/**点击回调*/
@property (nonatomic, copy) void(^didCancelHandler)(void);

/**初始化方法*/
- (instancetype)initWithPickerViewController:(UIImagePickerController *)pickerViewController;
/**
 *将自己从pickerViewController上移除
 *继承时使用
 */
- (void)clearSelfFromPickerViewController;

@end
