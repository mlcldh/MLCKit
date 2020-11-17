//
//  NSArray+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2020/8/10.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (MLCKit)

/**将数组的view根据先后顺序，根据相同间距连接起来*/
- (void)mlc_combineViewsWithAxis:(UILayoutConstraintAxis)axis withFixedSpacing:(CGFloat)fixedSpacing;
/**将数组的view根据先后顺序，根据数组fixedSpacings的间距连接起来*/
- (void)mlc_combineViewsWithAxis:(UILayoutConstraintAxis)axis withFixedSpacings:(NSArray <NSNumber *>*)fixedSpacings;
/**将数组的view根据先后顺序，数组的view的中心位置等间距*/
- (void)mlc_distributeViewsEqualCenterSpacingWithAxis:(UILayoutConstraintAxis)axis leadCenterSpacing:(CGFloat)leadCenterSpacing tailCenterSpacing:(CGFloat)tailCenterSpacing;

@end
