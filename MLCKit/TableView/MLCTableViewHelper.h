//
//  MLCTableViewHelper.h
//  MLCKit
//
//  Created by menglingchao on 2021/3/19.
//

#import <Foundation/Foundation.h>
#import "MLCTableViewSection.h"

/***/
@interface MLCTableViewHelper : NSObject<UITableViewDelegate, UITableViewDataSource>

/***/
@property (nonatomic, weak, readonly) UITableView *tableView;
/***/
@property (nonatomic, readonly) NSMutableArray<MLCTableViewSection *> *sections;
/**空白页回调*/
@property (nonatomic, copy) UIView *(^emptyViewHandler)(void);
/**是否在数据为空时显示空白页，默认是NO，即不显示*/
@property (nonatomic) BOOL canShowEmptyView;
/***/
- (instancetype)initWithTableView:(UITableView *)tableView;

@end
