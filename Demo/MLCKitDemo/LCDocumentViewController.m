//
//  LCDocumentViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/12/9.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCDocumentViewController.h"
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#import "MLCDocumentPickerViewControllerManager.h"

@interface LCDocumentViewController ()

@end

@implementation LCDocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addPickButton];
}
#pragma mark -
- (void)addPickButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"选择文件" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        NSArray <NSString *>*allowedUTIs = @[@"public.text", @"com.adobe.pdf"];
//        NSArray <NSString *>*allowedUTIs = @[@"public.image"];
        UIDocumentPickerViewController *documentPickerVC = nil;
        if (@available(iOS 14.0, *)) {
            NSMutableArray *contentTypes = [NSMutableArray array];
            [allowedUTIs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UTType *contentType = [UTType typeWithIdentifier:obj];
                [contentTypes addObject:contentType];
            }];
            documentPickerVC = [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:contentTypes.copy];
        } else {
            documentPickerVC = [[UIDocumentPickerViewController alloc]initWithDocumentTypes:allowedUTIs inMode:(UIDocumentPickerModeOpen)];// UIDocumentBrowserViewController
        }
        documentPickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
        MLCDocumentPickerViewControllerManager *pickerVCManager = [[MLCDocumentPickerViewControllerManager alloc] initWithPickerViewController:documentPickerVC];
        [pickerVCManager setDidPickDocumentsHandler:^(NSArray<NSURL *> *urls) {
//            @strongify(self)
            NSLog(@"menglc didPickDocumentsHandler %@", urls);
        }];
        [pickerVCManager setWasCancelledHandler:^{
//            @strongify(self)
            NSLog(@"menglc wasCancelledHandler");
        }];
        [self presentViewController:documentPickerVC animated:YES completion:nil];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
}

@end
