//
//  UITableView+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2021/4/6.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "UITableView+MLCKit.h"

@implementation UITableView (MLCKit)

- (void)mlc_registerCellClass:(Class)cellClass {
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}
- (void)mlc_registerCellClasses:(NSArray<Class> *)cellClasses {
    for (Class cellClass in cellClasses) {
        [self mlc_registerCellClass:cellClass];
    }
}
- (void)mlc_registerHeaderFooterViewClass:(Class)headerFooterViewClass {
    [self registerClass:headerFooterViewClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(headerFooterViewClass)];
}
- (__kindof UITableViewCell *)mlc_dequeueReusableCellWithCellClass:(Class)cellClass {
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    return cell;
}
- (__kindof UIView *)mlc_dequeueReusableHeaderFooterViewWithClass:(Class)aClass {
    UIView *headerFooterView = [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(aClass)];
    return headerFooterView;
}

@end
