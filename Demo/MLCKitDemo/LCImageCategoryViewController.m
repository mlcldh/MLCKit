//
//  LCImageCategoryViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2021/2/18.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "LCImageCategoryViewController.h"
#import "UIViewController+MLCKit.h"
#import "UIImage+MLCKit.h"

@interface LCImageCategoryViewController ()

@end

@implementation LCImageCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self useFilter];
}
#pragma mark -
- (void)useFilter {
    UIImageView *imageView = [[UIImageView alloc]init];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"onePiece" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    imageView.image = image;
    @weakify(self)
    @weakify(imageView)
    [imageView mlc_addGestureRecognizerWithType:(MLCGestureRecognizerTypeTap) handler:^(UIGestureRecognizer *recognizer) {
        @strongify(self)
        @strongify(imageView)
        NSArray *optionTitles = @[@"CIGaussianBlur", @"CIMaximumComponent", @"CIMinimumComponent"];
        [self mlc_showActionSheetWithTitle:nil message:nil optionTitles:optionTitles optionsHandler:^(NSInteger index) {
            NSLog(@"menglc optionTitle = %@", optionTitles[index]);
            switch (index) {
                case 0:
                    imageView.image = [image mlc_gaussianBlurImageWithRadius:1];
                    break;
                case 1:
                    imageView.image = [image mlc_maximumComponentImage];
                    break;
                case 2:
                    imageView.image = [image mlc_minimumComponentImage];
                    break;
                default:
                    break;
            }
        } cancelTitle:@"取消" cancelHandler:^{
            imageView.image = image;
        }];
    }];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(self.view).offset(-40);
        make.height.equalTo(imageView.mas_width).multipliedBy(image.size.height / image.size.width);
    }];
}

@end
