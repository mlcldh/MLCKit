//
//  MLCLocalFolderViewController.m
//  MLCKit
//
//  Created by menglingchao on 2019/12/18.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "MLCLocalFolderViewController.h"
#import "UIViewController+MLCKit.h"
#import "MLCFileUtility.h"
#import "NSDate+MLCKit.h"

@interface MLCLocalFolderViewController ()<UITableViewDelegate, UITableViewDataSource, UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;//
@property (nonatomic, strong) NSMutableArray *subpaths;//
@property (nonatomic, strong) NSMutableArray *files;//

@end

@implementation MLCLocalFolderViewController

//- (void)dealloc {
//    NSLog(@"MLCKit %@ dealloc", self);
//}
- (instancetype)initWithFolderPath:(NSString *)folderPath {
    self = [super init];
    if (self) {
        folderPath = [folderPath stringByStandardizingPath];
        self.title = [folderPath lastPathComponent];
        
        _folderPath = folderPath;
        _subpaths = [NSMutableArray array];
        _files = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    [self refresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Getter
- (UITableView *)tableView {
    if (! _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        _tableView.rowHeight = 44.0f;
        if (@available(iOS 10.0, *)) {
            _tableView.refreshControl = [[UIRefreshControl alloc] init];
            [_tableView.refreshControl addTarget:self action:@selector(refresh) forControlEvents:(UIControlEventValueChanged)];
        }
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
//        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
////            if (@available(iOS 11.0, *)) {
////                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
////            } else {
////                make.top.equalTo(self.mas_topLayoutGuideBottom);
////            }
//        }];
    }
    return _tableView;
}
#pragma mark -
- (void)refresh {
    [_subpaths removeAllObjects];
    [_files removeAllObjects];
    
    NSError *error = nil;
    BOOL isDirectory = NO;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_folderPath error:&error];
    files = [files sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    [_subpaths addObject:@".."];
    
    for (NSString *fileName in files) {
        NSString *fullFileName = [_folderPath stringByAppendingPathComponent:fileName];
        
        [[NSFileManager defaultManager] fileExistsAtPath:fullFileName isDirectory:&isDirectory];
        if (isDirectory) {
            [_subpaths addObject:fileName];
        } else {
            [_files addObject:fileName];
        }
    }
    [self.tableView reloadData];
    if (@available(iOS 10.0, *)) {
        [self.tableView.refreshControl endRefreshing];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return _subpaths.count;
            
        case 1:
            return _files.count;
            
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    switch (indexPath.section) {
        case 0: {
            cell.backgroundColor = [UIColor systemYellowColor];
            cell.textLabel.text = _subpaths[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } break;
        case 1: {
            cell.backgroundColor = [UIColor systemGrayColor];
            cell.textLabel.text = _files[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryNone;
        } break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0: {
            NSString *folderPath = [_folderPath stringByAppendingPathComponent:_subpaths[indexPath.row]];
            MLCLocalFolderViewController *viewController = [[MLCLocalFolderViewController alloc] initWithFolderPath:folderPath];
            viewController.canOpenFileHandler = self.canOpenFileHandler;
            [self.navigationController pushViewController:viewController animated:YES];
        } break;
        case 1: {
            NSString *filePath = [_folderPath stringByAppendingPathComponent:_files[indexPath.row]];
            if (self.canOpenFileHandler && !self.canOpenFileHandler(filePath)) {
                return;
            }
            filePath = [filePath stringByStandardizingPath];
            
            UIDocumentInteractionController *_documentIC = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
            _documentIC.delegate = self;
            BOOL canPresentPreview =   [_documentIC presentPreviewAnimated:YES];
            if (!canPresentPreview) {
                BOOL canOpen = [_documentIC presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
                if(!canOpen) {
                    NSLog(@"沒有程序可以打开选中的文件");
                }
            }
        } break;
        default:
            break;
    }
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section && !indexPath.row) {
        return nil;
    }
    UITableViewRowAction *infoAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"文件信息" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSArray *files = indexPath.section ? self.files : self.subpaths;
        NSString *filePath = [self.folderPath stringByAppendingPathComponent:files[indexPath.row]];
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        NSString *dateFormat = @"yyyy/MM/dd HH:mm";
        [self mlc_showAlertWithTitle:@"" message:[NSString stringWithFormat:@"文件大小：%@B。\n 创建时间：%@。\n 修改时间：%@。", @([MLCFileUtility sizeAtPath:filePath]), [attributes.fileCreationDate mlc_stringWithFormat:dateFormat], [attributes.fileModificationDate mlc_stringWithFormat:dateFormat]] actionTitle:@"确定" handler:nil];
    }];
    infoAction.backgroundColor = [UIColor systemBlueColor];
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSArray *files = indexPath.section ? self.files : self.subpaths;
        NSString *filePath = [self.folderPath stringByAppendingPathComponent:files[indexPath.row]];
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"MLCKit error %@", error);
        }
        [self refresh];
    }];
    UITableViewRowAction *renameRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"重命名" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self mlc_showPromptWithTitle:@"重命名" message:nil configurationHandler:^(UITextField *textField) {
            NSArray *files = indexPath.section ? self.files : self.subpaths;
            textField.placeholder = @"新文件名";
            textField.text = files[indexPath.row];
        } resultHandler:^(BOOL isCancel, NSString *result) {
            if (isCancel) {
                return;
            }
            NSArray *files = indexPath.section ? self.files : self.subpaths;
            NSString *filePath = [self.folderPath stringByAppendingPathComponent:files[indexPath.row]];
            NSString *newFilePath = [self.folderPath stringByAppendingPathComponent:result];
            [MLCFileUtility moveItemAtPath:filePath toPath:newFilePath error:nil];
            [self refresh];
        }];
    }];
    renameRowAction.backgroundColor = [UIColor systemGrayColor];
    return @[infoAction, renameRowAction, deleteRowAction];
}
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    UISwipeActionsConfiguration *swipeActionsConfiguration = nil;
    return swipeActionsConfiguration;
}
#pragma mark - UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}
- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller {
    return self.view;
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller {
    return self.view.frame;
}
//点击预览窗口的“Done”(完成)按钮时调用
- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller {
//    NSLog(@"menglc documentInteractionControllerDidEndPreview");
}
// 文件分享面板弹出的时候调用
- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller {
//    NSLog(@"menglc WillPresentOpenInMenu");
}
// 当选择一个文件分享App的时候调用
- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application {
//    NSLog(@"menglc begin send : %@", application);
}
// 弹框消失的时候走的方法
- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
//    NSLog(@"menglc dissMiss");
}

@end
