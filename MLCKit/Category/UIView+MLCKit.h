//
//  UIView+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

/* Values for NSTextAlignment */
typedef NS_ENUM(NSInteger, MLCGestureRecognizerType) {
    MLCGestureRecognizerTypeTap = 0,//
    MLCGestureRecognizerTypeLongPress = 1,//
    MLCGestureRecognizerTypePan = 2,//
    MLCGestureRecognizerTypeSwipe = 3,//
    MLCGestureRecognizerTypeRotation = 4,//
    MLCGestureRecognizerTypePinch = 5,//
};

//NS_ASSUME_NONNULL_BEGIN

@interface UIView (MLCKit)

/**添加手势及其回调*/
- (UIGestureRecognizer *)mlc_addGestureRecognizerWithType:(MLCGestureRecognizerType)type callback:(void(^)(UIGestureRecognizer *recognizer))callback;
/**移除某些类型手势及其回调*/
- (void)mlc_removeGestureRecognizersWithType:(MLCGestureRecognizerType)type;
/**移除所有手势及其回调*/
- (void)mlc_removeAllGestureRecognizers;
/**移除某一些约束*/
- (void)mlc_removeConstraintsWithFirstItem:(id)firstItem firstAttribute:(NSLayoutAttribute)firstAttribute;

@end

//NS_ASSUME_NONNULL_END
