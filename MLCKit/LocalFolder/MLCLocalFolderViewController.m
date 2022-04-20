//
//  MLCLocalFolderViewController.m
//  MLCKit
//
//  Created by menglingchao on 2019/12/18.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "MLCLocalFolderViewController.h"
//#import "MLCMacror.h"
//#import "Masonry.h"

@interface MLCLocalFolderViewController ()<UITableViewDelegate, UITableViewDataSource, UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;//
@property (nonatomic, strong) NSMutableArray *subpaths;//
@property (nonatomic, strong) NSMutableArray *files;//
@property (nonatomic,strong) UIDocumentInteractionController * documentIC;

@end

@implementation MLCLocalFolderViewController

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
    [self tableView];
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
            cell.backgroundColor = [UIColor yellowColor];
            cell.textLabel.text = _subpaths[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } break;
        case 1: {
            cell.backgroundColor = [UIColor lightGrayColor];
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
            NSString *fileName = [_folderPath stringByAppendingPathComponent:_subpaths[indexPath.row]];
            MLCLocalFolderViewController *viewController = [[MLCLocalFolderViewController alloc] initWithFolderPath:fileName];
            viewController.canOpenFileHandler = self.canOpenFileHandler;
            [self.navigationController pushViewController:viewController animated:YES];
        } break;
        case 1: {
            NSString *fileName = [_folderPath stringByAppendingPathComponent:_files[indexPath.row]];
            if (self.canOpenFileHandler && !self.canOpenFileHandler(fileName)) {
                return;
            }
            fileName = [fileName stringByStandardizingPath];
            
            _documentIC = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:fileName]];
            _documentIC.delegate = self;
            BOOL canPresentPreview =   [_documentIC presentPreviewAnimated:YES];
            if (!canPresentPreview) {
                BOOL canOpen = [self.documentIC presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
                if(!canOpen) {
                    NSLog(@"沒有程序可以打开选中的文件");
                }
            }
        } break;
        default:
            break;
    }
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
