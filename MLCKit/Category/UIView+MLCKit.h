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

/**点击回调*/
@property (nonatomic, copy) void(^mlc_tapBlock)(void);

@end

//NS_ASSUME_NONNULL_END
