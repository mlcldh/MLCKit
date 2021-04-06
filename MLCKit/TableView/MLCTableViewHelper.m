//
//  MLCTableViewHelper.m
//  MLCKit
//
//  Created by menglingchao on 2021/3/19.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "MLCTableViewHelper.h"
#import "MLCTableViewDelegate.h"

@interface MLCTableViewHelper ()

@property (nonatomic, strong) MLCTableViewDelegate *tableViewDelegate;//

@end

@implementation MLCTableViewHelper

- (instancetype)initWithTableView:(UITableView *)tableView cellClasses:(NSArray<Class> *)cellClasses refreshHeaderClass:(Class)refreshHeaderClass refreshFooterClass:(Class)refreshFooterClass {
    self = [super init];
    if (self) {
        _tableViewDelegate = [[MLCTableViewDelegate alloc]initWithTableView:tableView cellClasses:cellClasses];
        
        __weak __typeof__(self) weak_self = self;
        tableView.mj_header = [refreshHeaderClass headerWithRefreshingBlock:^{
            if (weak_self.refreshHandler) {
                weak_self.refreshHandler();
            }
        }];
        tableView.mj_footer = [refreshFooterClass footerWithRefreshingBlock:^{
            if (weak_self.loadMoreHandler) {
                weak_self.loadMoreHandler();
            }
        }];
        tableView.mj_footer.hidden = YES;
    }
    return self;
}
#pragma mark - Getter
- (UIView *(^)(void))emptyViewHandler {
    return self.tableViewDelegate.emptyViewHandler;
}
- (UIView *(^)(NSError *))errorViewHandler {
    return self.tableViewDelegate.errorViewHandler;
}
#pragma mark - Setter
- (void)setEmptyViewHandler:(UIView *(^)(void))emptyViewHandler {
    self.tableViewDelegate.emptyViewHandler = emptyViewHandler;
}
- (void)setErrorViewHandler:(UIView *(^)(NSError *))errorViewHandler {
    self.tableViewDelegate.errorViewHandler = errorViewHandler;
}
#pragma mark -
- (void)handleRequestSuccessWithModels:(NSArray *)models totalCount:(NSInteger)totalCount isRefresh:(BOOL)isRefresh {
    if (isRefresh) {
        [self handleRefreshSuccessWithModels:models totalCount:totalCount];
    } else {
        [self handleLoadMoreSuccessWithModels:models totalCount:totalCount];
    }
}
- (void)handleRefreshSuccessWithModels:(NSArray *)models totalCount:(NSInteger)totalCount {
    if (totalCount <= 0) {
        [self handleEmpty];
        return;
    }
    [self.tableViewDelegate.tableView.mj_header endRefreshing];
    self.tableViewDelegate.tableView.mj_footer.hidden = YES;
    
    [self.tableViewDelegate.sections removeAllObjects];
    self.tableViewDelegate.error = nil;
    
    MLCTableViewSection *section = [[MLCTableViewSection alloc]init];
    if (self.configSectionHandler) {
        self.configSectionHandler(section);
    }
    if (models) {
        [section.models addObjectsFromArray:models];
    }
    if (section.models.count >= totalCount) {
        [self.tableViewDelegate.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableViewDelegate.tableView.mj_footer endRefreshing];
    }
    
    self.tableViewDelegate.tableView.mj_footer.hidden = NO;
    [self.tableViewDelegate.sections addObject:section];
    [self.tableViewDelegate.tableView reloadData];
}
- (void)handleEmpty {
    [self.tableViewDelegate.tableView.mj_header endRefreshing];
    self.tableViewDelegate.tableView.mj_footer.hidden = YES;
    
    self.tableViewDelegate.canShowEmptyView = YES;
    [self.tableViewDelegate.sections removeAllObjects];
    self.tableViewDelegate.error = nil;
    [self.tableViewDelegate.tableView reloadData];
}
- (void)handleLoadMoreSuccessWithModels:(NSArray *)models totalCount:(NSInteger)totalCount {
    self.tableViewDelegate.error = nil;
    
    MLCTableViewSection *section = self.tableViewDelegate.sections.firstObject;
    if (models) {
        [section.models addObjectsFromArray:models];
    }
    if (section.models.count >= totalCount) {
        [self.tableViewDelegate.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableViewDelegate.tableView.mj_footer endRefreshing];
    }
    [self.tableViewDelegate.tableView reloadData];
}
- (void)handleLoadError:(NSError *)error {
    [self.tableViewDelegate.tableView.mj_header endRefreshing];
    self.tableViewDelegate.tableView.mj_footer.hidden = YES;
    
    [self.tableViewDelegate.sections removeAllObjects];
    self.tableViewDelegate.error = error;
    [self.tableViewDelegate.tableView reloadData];
}
- (void)removeModelAtIndex:(NSInteger)index {
    [self.tableViewDelegate.sections.firstObject.models removeObjectAtIndex:index];
}
- (void)deleteRowAtIndex:(NSInteger)index totalCount:(NSInteger)totalCount {
    [self removeModelAtIndex:index];
    if (totalCount <= 0) {
        [self.tableViewDelegate.tableView reloadData];
    } else {
        [self.tableViewDelegate.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    }
}

@end
