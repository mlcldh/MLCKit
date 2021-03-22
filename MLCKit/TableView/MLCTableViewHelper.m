//
//  MLCTableViewHelper.m
//  MLCKit
//
//  Created by menglingchao on 2021/3/19.
//

#import "MLCTableViewHelper.h"

@interface MLCTableViewHelper ()

@property (nonatomic, strong) NSMutableArray<MLCTableViewSection *> *sections;//

@end

@implementation MLCTableViewHelper

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    return self;
}
#pragma mark - Getter
- (NSMutableArray<MLCTableViewSection *> *)sections {
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.sections.count) {
        return 0;
    }
    MLCTableViewSection *section = self.sections[indexPath.section];
    if (indexPath.row >= section.rows.count) {
        return 0;
    }
    MLCTableViewRow *row = section.rows[indexPath.row];
    if (row.cellHeightHandler) {
        CGFloat cellHeight = row.cellHeightHandler();
        return cellHeight;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!self.sections.count && self.canShowEmptyView) {
        return CGRectGetHeight(tableView.frame);
    }
    if (section >= self.sections.count) {
        return 0;
    }
    MLCTableViewSection *aSection = self.sections[section];
    if (aSection.headerHeightHandler) {
        CGFloat headerHeight = aSection.headerHeightHandler();
        return headerHeight;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!self.sections.count && self.canShowEmptyView && self.emptyViewHandler) {
        UIView *emptyView = self.emptyViewHandler();
        return emptyView;
    }
    if (section >= self.sections.count) {
        return nil;
    }
    MLCTableViewSection *aSection = self.sections[section];
    if (aSection.headeViewHandler) {
        UIView *headeView = aSection.headeViewHandler();
        return headeView;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section >= self.sections.count) {
        return;
    }
    MLCTableViewSection *section = self.sections[indexPath.section];
    if (indexPath.row >= section.rows.count) {
        return;
    }
    MLCTableViewRow *row = section.rows[indexPath.row];
    if (row.didSelectHandler) {
        row.didSelectHandler();
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section >= self.sections.count) {
        return 0;
    }
    MLCTableViewSection *aSection = self.sections[section];
    return aSection.rows.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.sections.count) {
        return [[UITableViewCell alloc]init];
    }
    MLCTableViewSection *section = self.sections[indexPath.section];
    if (indexPath.row >= section.rows.count) {
        return [[UITableViewCell alloc]init];
    }
    MLCTableViewRow *row = section.rows[indexPath.row];
    if (row.configCellHandler) {
        UITableViewCell *cell = row.configCellHandler();
        return cell;
    }
    return [[UITableViewCell alloc]init];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

@end
