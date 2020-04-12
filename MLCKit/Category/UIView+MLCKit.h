//
//  UIView+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface UIView (MLCKit)

/**添加点击回调*/
- (UITapGestureRecognizer *)mlc_addTapGestureRecognizer:(void(^)(UIView *currentView))callback;
/**移除点击手势及其回调*/
- (void)mlc_removeTapGestureRecognizer;
/**添加长按手势*/
- (UILongPressGestureRecognizer *)mlc_addLongPressGestureRecognizer:(void(^)(UIView *currentView, UILongPressGestureRecognizer *recognizer))callback;
/**移除长按手势及其回调*/
- (void)mlc_removeLongPressGestureRecognizer;
/**移除某一些约束*/
- (void)mlc_removeConstraintsWithFirstItem:(id)firstItem firstAttribute:(NSLayoutAttribute)firstAttribute;

@end

//NS_ASSUME_NONNULL_END
