//
//  MLCLocalFolderViewController.h
//  MLCKit
//
//  Created by menglingchao on 2019/12/18.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 本地文件查看
@interface MLCLocalFolderViewController : UIViewController

/// 初始化文件夹
@property (nonatomic, copy, readonly) NSString *folderPath;
/// 是否能够打开文件的回调
@property (nonatomic, copy) BOOL(^canOpenFileHandler)(NSString *filePath);

- (instancetype)initWithFolderPath:(NSString *)folderPath;

@end
