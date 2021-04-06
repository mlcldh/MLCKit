//
//  LCUseTableViewHelperViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2021/3/19.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "LCUseTableViewHelperViewController.h"
#import <MJRefresh/MJRefresh.h>
//#import <MLCKit/MLCTableViewHelper.h>
#import "MLCTableViewHelper.h"
#import "LCATableViewCell.h"
#import "LCLearnRecordModel.h"

typedef NS_ENUM(NSInteger, LCRefreshType) {
    LCRefreshTypeEmpty = 0,//
    LCRefreshTypeSuccess = 1,//
    LCRefreshTypeError = 2,//
};

@interface LCUseTableViewHelperViewController ()

@property (nonatomic, strong) UIButton *refreshSuccessButton;//刷新成功按钮
@property (nonatomic, strong) UIButton *refreshErrorButton;//刷新失败按钮
@property (nonatomic, strong) UIButton *refreshEmptyButton;//空列表按钮
@property (nonatomic, strong) UITableView *tableView;//
@property (nonatomic, strong) MLCTableViewHelper *helper;//
@property (nonatomic) LCRefreshType refreshType;//
@property (nonatomic) NSInteger totalCount;//

@end

@implementation LCUseTableViewHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self refreshSuccessButton];
    [self refreshErrorButton];
    [self refreshEmptyButton];
    
    [self tableView];
    [self helper];
    
    [self configHelper];
    
    self.totalCount = 40;
    
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - Getter
- (UIButton *)refreshSuccessButton {
    if (!_refreshSuccessButton) {
        _refreshSuccessButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _refreshSuccessButton.backgroundColor = [UIColor purpleColor];
        [_refreshSuccessButton setTitle:@"刷新成功" forState:(UIControlStateNormal)];
        @weakify(self)
        [_refreshSuccessButton setMlc_touchUpInsideBlock:^{
            @strongify(self)
            self.refreshType = LCRefreshTypeSuccess;
            [self.tableView.mj_header beginRefreshing];
        }];
        [self.view addSubview:_refreshSuccessButton];
        [_refreshSuccessButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.top.equalTo(self.view).offset(100);
        }];
    }
    return _refreshSuccessButton;
}
- (UIButton *)refreshErrorButton {
    if (!_refreshErrorButton) {
        _refreshErrorButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _refreshErrorButton.backgroundColor = [UIColor purpleColor];
        [_refreshErrorButton setTitle:@"刷新失败" forState:(UIControlStateNormal)];
        @weakify(self)
        [_refreshErrorButton setMlc_touchUpInsideBlock:^{
            @strongify(self)
            self.refreshType = LCRefreshTypeError;
            [self.tableView.mj_header beginRefreshing];
        }];
        [self.view addSubview:_refreshErrorButton];
        [_refreshErrorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(120);
            make.top.equalTo(self.view).offset(100);
        }];
    }
    return _refreshErrorButton;
}
- (UIButton *)refreshEmptyButton {
    if (!_refreshEmptyButton) {
        _refreshEmptyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _refreshEmptyButton.backgroundColor = [UIColor purpleColor];
        [_refreshEmptyButton setTitle:@"空列表" forState:(UIControlStateNormal)];
        @weakify(self)
        [_refreshEmptyButton setMlc_touchUpInsideBlock:^{
            @strongify(self)
            self.refreshType = LCRefreshTypeEmpty;
            [self.tableView.mj_header beginRefreshing];
        }];
        [self.view addSubview:_refreshEmptyButton];
        [_refreshEmptyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(220);
            make.top.equalTo(self.view).offset(100);
        }];
    }
    return _refreshEmptyButton;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view).offset(150);
        }];
    }
    return _tableView;
}
- (MLCTableViewHelper *)helper {
    if (!_helper) {
        _helper = [[MLCTableViewHelper alloc] initWithTableView:self.tableView cellClasses:@[[LCATableViewCell class]] refreshHeaderClass:[MJRefreshGifHeader class] refreshFooterClass:[MJRefreshAutoGifFooter class]];
        @weakify(self)
        [_helper setEmptyViewHandler:^UIView *{
            UILabel *label = [[UILabel alloc]init];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"空页面";
            return label;
        }];
        [_helper setErrorViewHandler:^UIView *(NSError *error) {
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [button setTitleColor:[UIColor systemBlueColor] forState:(UIControlStateNormal)];
            [button setTitle:error.localizedFailureReason forState:(UIControlStateNormal)];
            [button setMlc_touchUpInsideBlock:^{
                @strongify(self)
                [self.tableView.mj_header beginRefreshing];
            }];
            return button;
        }];
        
        [self.tableView reloadData];
    }
    return _helper;
}
#pragma mark -
- (void)configHelper {
    @weakify(self)
    [self.helper setRefreshHandler:^{
        @strongify(self)
        [self refresh];
    }];
    [self.helper setLoadMoreHandler:^{
        @strongify(self)
        [self loadMore];
    }];
    [self.helper setConfigSectionHandler:^(MLCTableViewSection *section) {
        [section setCellClassHandler:^Class(NSIndexPath *indexPath, id model) {
            return [LCATableViewCell class];
        }];
        [section setConfigCellHandler:^(UITableViewCell *cell, NSIndexPath *indexPath, id model) {
            if (![model isKindOfClass:[LCLearnRecordModel class]]) {
                return;
            }
            LCLearnRecordModel *learnRecordModel = model;
            cell.textLabel.text = learnRecordModel.title;
        }];
        [section setCellHeightHandler:^CGFloat(NSIndexPath *indexPath, id model) {
            return 80;
        }];
        [section setDidSelectHandler:^(NSIndexPath *indexPath, id model) {
            NSLog(@"menglc row DidSelect %@, %@", @(indexPath.section), @(indexPath.row));
        }];
        [section setTitleForDeleteConfirmationButtonHandler:^NSString *(NSIndexPath *indexPath, id model) {
            return @"删除";
        }];
        [section setEditActionsHandler:^NSArray<UITableViewRowAction *> *(NSIndexPath *indexPath, id model) {
            NSMutableArray *editActions = [NSMutableArray array];
            
            UITableViewRowAction *unreadAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"标位未读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                NSLog(@"menglc 标位未读");
            }];
            unreadAction.backgroundColor = [UIColor darkGrayColor];
            [editActions addObject:unreadAction];
            
            UITableViewRowAction *notShowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"不显示" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                NSLog(@"menglc 不显示");
            }];
            notShowAction.backgroundColor = [UIColor systemOrangeColor];
            [editActions insertObject:notShowAction atIndex:0];
            
            UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                @strongify(self)
                self.totalCount --;
                [self.helper deleteRowAtIndex:indexPath.row totalCount:self.totalCount];
            }];
            [editActions insertObject:deleteAction atIndex:0];
            
            return editActions;
        }];
        [section setTrailingSwipeActionsConfigurationHandler:^UISwipeActionsConfiguration *(NSIndexPath *indexPath, id model) {
            UISwipeActionsConfiguration *configuration = ;
        }];
        [section setEditingStyleHandler:^UITableViewCellEditingStyle(NSIndexPath *indexPath, id model) {
            return UITableViewCellEditingStyleDelete;
        }];
        [section setCommitEditingStyleHandler:^(UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath, id model) {
            @strongify(self)
            self.totalCount --;
            [self.helper deleteRowAtIndex:indexPath.row totalCount:self.totalCount];
        }];
    }];
    [self.helper setEmptyViewHandler:^UIView *{
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"空页面";
        return label;
    }];
    [self.helper setErrorViewHandler:^UIView *(NSError *error) {
        UIButton *errorButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [errorButton setTitle:error.localizedFailureReason forState:(UIControlStateNormal)];
        [errorButton setMlc_touchUpInsideBlock:^{
            @strongify(self)
            [self.tableView.mj_header beginRefreshing];
        }];
        return errorButton;
    }];
}
- (void)refresh {
    @weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self)
        switch (self.refreshType) {
            case LCRefreshTypeEmpty:
                [self.helper handleRefreshSuccessWithModels:@[] totalCount:0];
                break;
            case LCRefreshTypeSuccess:
                [self refreshSuccess];
                break;
            case LCRefreshTypeError:
                [self refreshError];
                break;
            default:
                break;
        }
    });
    
}
- (void)refreshSuccess {
    NSMutableArray *models = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i ++) {
        LCLearnRecordModel *model = [[LCLearnRecordModel alloc]init];
        model.title = [NSString stringWithFormat:@"文字%@", @(models.count)];
        [models addObject:model];
    }
    [self.helper handleRefreshSuccessWithModels:models totalCount:self.totalCount];
}
- (void)refreshError {
    [self.helper handleLoadError:[NSError errorWithDomain:@"com.mlc.networkError" code:-1 userInfo:@{NSLocalizedFailureReasonErrorKey: @"网络错误，请稍后重试."}]];
}
- (void)loadMore {
    @weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self)
        NSMutableArray *models = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i ++) {
            LCLearnRecordModel *model = [[LCLearnRecordModel alloc]init];
            model.title = [NSString stringWithFormat:@"文字%@", @(models.count)];
            [models addObject:model];
        }
        [self.helper handleLoadMoreSuccessWithModels:models totalCount:self.totalCount];
    });
}

@end
