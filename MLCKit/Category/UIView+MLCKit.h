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

/**点击手势*/
@property (nonatomic, strong) UITapGestureRecognizer *mlc_tapGestureRecognizer;
/**长按手势*/
@property (nonatomic, strong) UILongPressGestureRecognizer *mlc_longPressGestureRecognizer;
/**点击回调*/
@property (nonatomic, copy) void(^mlc_tapBlock)(UIView *currentView);
/**长按手势回调*/
@property (nonatomic, copy) void(^mlc_longPressBlock)(UIView *currentView, UILongPressGestureRecognizer *recognizer);
/**移除某一些约束*/
- (void)mlc_removeConstraintsWithFirstItem:(id)firstItem firstAttribute:(NSLayoutAttribute)firstAttribute;

@end

//NS_ASSUME_NONNULL_END
