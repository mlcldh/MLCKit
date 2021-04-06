//
//  UITableView+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2021/4/6.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView (MLCKit)

- (void)mlc_registerCellClass:(Class)cellClass;

- (void)mlc_registerCellClasses:(NSArray<Class> *)cellClasses;

- (void)mlc_registerHeaderFooterViewClass:(Class)headerFooterViewClass;

- (__kindof UITableViewCell *)mlc_dequeueReusableCellWithCellClass:(Class)cellClass;

- (__kindof UIView *)mlc_dequeueReusableHeaderFooterViewWithClass:(Class)aClass;

@end
