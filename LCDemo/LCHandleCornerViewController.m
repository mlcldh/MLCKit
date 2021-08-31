//
//  LCHandleCornerViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/10/28.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCHandleCornerViewController.h"
#import "Masonry.h"
#import "UIView+MLCKit.h"

@interface LCHandleCornerViewController ()

@end

@implementation LCHandleCornerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self handleCorner];
}
#pragma mark -
- (void)handleCorner {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"gallery" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(150);
        make.height.equalTo(imageView.mas_width).multipliedBy(image.size.height / image.size.width);
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [imageView mlc_becomeRoundedbyRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadius:10];
    });
    
//    UIView *maskView = [[UIView alloc]init];
////    maskView.frame = CGRectMake(0, 0, 100, 100);
////    maskView.backgroundColor = [UIColor whiteColor];
//    [imageView addSubview:maskView];
//    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(imageView);
//    }];
    
    
//    imageView.maskView = maskView;
}

@end
