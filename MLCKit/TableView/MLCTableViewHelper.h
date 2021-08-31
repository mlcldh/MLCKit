//
//  MLCTableViewHelper.h
//  MLCKit
//
//  Created by menglingchao on 2021/3/19.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import "MLCTableViewSection.h"

/// TableView助手
@interface MLCTableViewHelper : NSObject

/// 下拉刷新回调
@property (nonatomic, copy) void(^refreshHandler)(void);
/// 加载更多回调
@property (nonatomic, copy) void(^loadMoreHandler)(void);
/// 配置Section回调
@property (nonatomic, copy) void(^configSectionHandler)(MLCTableViewSection *section);
/// 空白页回调
@property (nonatomic, copy) UIView *(^emptyViewHandler)(void);
/// 错误页回调
@property (nonatomic, copy) UIView *(^errorViewHandler)(NSError *error);

- (instancetype)initWithTableView:(UITableView *)tableView cellClasses:(NSArray<Class> *)cellClasses refreshHeaderClass:(Class)refreshHeaderClass refreshFooterClass:(Class)refreshFooterClass;

- (NSArray *)models;
- (void)handleRequestSuccessWithModels:(NSArray *)models totalCount:(NSInteger)totalCount isRefresh:(BOOL)isRefresh;
- (void)handleRefreshSuccessWithModels:(NSArray *)models totalCount:(NSInteger)totalCount;
- (void)handleEmpty;
- (void)handleLoadMoreSuccessWithModels:(NSArray *)models totalCount:(NSInteger)totalCount;
- (void)handleLoadError:(NSError *)error;
- (void)removeModelAtIndex:(NSInteger)index;
- (void)deleteRowAtIndex:(NSInteger)index totalCount:(NSInteger)totalCount;

@end
