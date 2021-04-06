//
//  MLCTableViewDelegate.h
//  MLCKit
//
//  Created by menglingchao on 2021/4/6.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLCTableViewSection.h"


@interface MLCTableViewDelegate : NSObject<UITableViewDelegate, UITableViewDataSource>

/***/
@property (nonatomic, weak, readonly) UITableView *tableView;
/***/
@property (nonatomic, readonly) NSMutableArray<MLCTableViewSection *> *sections;
/***/
@property (nonatomic, copy) NSError *error;
/**空白页回调*/
@property (nonatomic, copy) UIView *(^emptyViewHandler)(void);
/**错误页回调*/
@property (nonatomic, copy) UIView *(^errorViewHandler)(NSError *error);
/**是否在数据为空时显示空白页，默认是NO，即不显示*/
@property (nonatomic) BOOL canShowEmptyView;
/***/
- (instancetype)initWithTableView:(UITableView *)tableView cellClasses:(NSArray<Class> *)cellClasses;



@end
