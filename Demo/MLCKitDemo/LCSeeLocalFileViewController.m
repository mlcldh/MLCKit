//
//  LCSeeLocalFileViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCSeeLocalFileViewController.h"
#import "Masonry.h"
#import "UIControl+MLCKit.h"
#import "MLCLocalFolderViewController.h"
#import "MLCMacror.h"

@interface LCSeeLocalFileViewController ()

@end

@implementation LCSeeLocalFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self seeLocalFile];
}
#pragma mark - 
- (void)seeLocalFile {
    UIButton *seeLocalFileButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    seeLocalFileButton.backgroundColor = [UIColor purpleColor];
    [seeLocalFileButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [seeLocalFileButton setTitle:@"查看本地沙盒文件" forState:(UIControlStateNormal)];
    @weakify(self)
    [seeLocalFileButton setMlc_touchUpInsideBlock:^{
        @strongify(self)
        NSString *folderPath = NSHomeDirectory();
        MLCLocalFolderViewController *localFolderVC = [[MLCLocalFolderViewController alloc]initWithFolderPath:folderPath];
        [self.navigationController pushViewController:localFolderVC animated:YES];
    }];
    [self.view addSubview:seeLocalFileButton];
    [seeLocalFileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
}

@end
