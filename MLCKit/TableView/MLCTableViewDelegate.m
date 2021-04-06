//
//  MLCTableViewDelegate.m
//  MLCKit
//
//  Created by menglingchao on 2021/4/6.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "MLCTableViewDelegate.h"
#import "UITableView+MLCKit.h"

@interface MLCTableViewDelegate ()

@property (nonatomic, strong) NSMutableArray<MLCTableViewSection *> *sections;//
@property (nonatomic, strong) UIView *emptyView;//
@property (nonatomic, strong) UIView *errorView;//

@end

@implementation MLCTableViewDelegate

- (instancetype)initWithTableView:(UITableView *)tableView cellClasses:(NSArray<Class> *)cellClasses {
    self = [super init];
    if (self) {
        _tableView = tableView;
        [tableView mlc_registerCellClasses:cellClasses];
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
    if ((indexPath.row < section.models.count) && section.cellHeightHandler) {
        id model = section.models[indexPath.row];
        CGFloat cellHeight = section.cellHeightHandler(indexPath, model);
        return cellHeight;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.error) {
        return CGRectGetHeight(tableView.frame);
    }
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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section >= self.sections.count) {
        return 0;
    }
    MLCTableViewSection *aSection = self.sections[section];
    if (aSection.footerHeightHandler) {
        CGFloat footerHeight = aSection.footerHeightHandler();
        return footerHeight;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.error && self.errorViewHandler) {
        return self.errorViewHandler(self.error);
    }
    if (!self.sections.count && self.canShowEmptyView && self.emptyViewHandler) {
        UIView *emptyView = self.emptyViewHandler();
        return emptyView;
    }
    if (section >= self.sections.count) {
        return nil;
    }
    MLCTableViewSection *aSection = self.sections[section];
    if (aSection.headerViewHandler) {
        UIView *headeView = aSection.headerViewHandler();
        return headeView;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section >= self.sections.count) {
        return nil;
    }
    MLCTableViewSection *aSection = self.sections[section];
    if (aSection.footerViewHandler) {
        UIView *footerView = aSection.footerViewHandler();
        return footerView;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section >= self.sections.count) {
        return;
    }
    MLCTableViewSection *section = self.sections[indexPath.section];
    if ((indexPath.row < section.models.count) && section.didSelectHandler) {
        id model = section.models[indexPath.row];
        section.didSelectHandler(indexPath, model);
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.sections.count) {
        return UITableViewCellEditingStyleNone;
    }
    MLCTableViewSection *section = self.sections[indexPath.section];
    if (indexPath.row >= section.models.count) {
        return UITableViewCellEditingStyleNone;
    }
    id model = section.models[indexPath.row];
    if (section.editingStyleHandler) {
        return section.editingStyleHandler(indexPath, model);
    }
    return UITableViewCellEditingStyleNone;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.sections.count) {
        return nil;
    }
    MLCTableViewSection *section = self.sections[indexPath.section];
    if (indexPath.row >= section.models.count) {
        return nil;
    }
    id model = section.models[indexPath.row];
    if (section.editingStyleHandler) {
        return section.titleForDeleteConfirmationButtonHandler(indexPath, model);
    }
    return nil;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.sections.count) {
        return nil;
    }
    MLCTableViewSection *section = self.sections[indexPath.section];
    if (indexPath.row >= section.models.count) {
        return nil;
    }
    id model = section.models[indexPath.row];
    if (section.editActionsHandler) {
        return section.editActionsHandler(indexPath, model);
    }
    return nil;
}
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    if (indexPath.section >= self.sections.count) {
        return nil;
    }
    MLCTableViewSection *section = self.sections[indexPath.section];
    if (indexPath.row >= section.models.count) {
        return nil;
    }
    id model = section.models[indexPath.row];
    if (section.leadingSwipeActionsConfigurationHandler) {
        return section.leadingSwipeActionsConfigurationHandler(indexPath, model);
    }
    return nil;
}
//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
//    if (indexPath.section >= self.sections.count) {
//        return nil;
//    }
//    MLCTableViewSection *section = self.sections[indexPath.section];
//    if (indexPath.row >= section.models.count) {
//        return nil;
//    }
//    id model = section.models[indexPath.row];
//    if (section.trailingSwipeActionsConfigurationHandler) {
//        return section.trailingSwipeActionsConfigurationHandler(indexPath, model);
//    }
//    return nil;
//}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section >= self.sections.count) {
        return 0;
    }
    MLCTableViewSection *aSection = self.sections[section];
    return aSection.models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.sections.count) {
        return [[UITableViewCell alloc]init];
    }
    MLCTableViewSection *section = self.sections[indexPath.section];
    if (indexPath.row >= section.models.count) {
        return [[UITableViewCell alloc]init];
    }
    id model = section.models[indexPath.row];
    Class cellClass = nil;
    if (section.cellClassHandler) {
        cellClass = section.cellClassHandler(indexPath, model);
    } else {
        cellClass = [UITableViewCell class];
    }
    UITableViewCell *cell = [tableView mlc_dequeueReusableCellWithCellClass:cellClass];
    if (section.configCellHandler) {
        section.configCellHandler(cell, indexPath, model);
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count ? : 1;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.sections.count) {
        return;
    }
    MLCTableViewSection *section = self.sections[indexPath.section];
    if (indexPath.row >= section.models.count) {
        return;
    }
    id model = section.models[indexPath.row];
    if (section.commitEditingStyleHandler) {
        section.commitEditingStyleHandler(editingStyle, indexPath, model);
    }
}

@end
