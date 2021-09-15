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
    [self showQRCodeImage];
}
#pragma mark -
- (void)useFilter {//使用图片滤镜
    UIImageView *imageView = [[UIImageView alloc]init];
    NSString *name = @"onePiece";
//    NSString *name = @"girl";
//    NSString *name = @"gallery";
    NSString *filePath = [[NSBundle mainBundle]pathForResource:name ofType:@"jpg"];
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
                    imageView.image = [image mlc_gaussianBlurImageWithRadius:10];
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
- (void)showQRCodeImage {//显示二维码
    UIImage *image = [UIImage mlc_imageWithQRCode:@"https://www.baidu.com/" imageWidth:100];
    image = [image mlc_specialColorImageWithColor:[UIColor redColor]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
//    imageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(500);
    }];
}

@end
