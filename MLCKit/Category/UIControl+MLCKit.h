//
//  UIControl+MLCKit.h
//  Masonry
//
//  Created by menglingchao on 2019/12/20.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface UIControl (MLCKit)

/**点击回调*/
@property (nonatomic, copy) void(^mlc_touchUpInsideBlock)(void);

@end

//NS_ASSUME_NONNULL_END
