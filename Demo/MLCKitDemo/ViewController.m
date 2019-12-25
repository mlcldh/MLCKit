//
//  ViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "ViewController.h"
#import "MLCMacror.h"
#import "UIView+MLCKit.h"
#import "NSObject+MLCKit.h"
#import "NSString+MLCKit.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *aLabel;//

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self aLabel];
//    [self useUrlEncode];
    [self useUrlDecode];
}
#pragma mark - Getter
- (UILabel *)aLabel {
    if (!_aLabel) {
        _aLabel = [[UILabel alloc]init];
        _aLabel.backgroundColor = [UIColor purpleColor];
        _aLabel.textColor = [UIColor blackColor];
        _aLabel.textAlignment = NSTextAlignmentCenter;
//        _aLabel.font = [UIFont systemFontOfSize:18];
        _aLabel.text = @"轻学堂";
        [_aLabel setMlc_tapBlock:^(UIView *currentView) {
            UILabel *label = (UILabel *)currentView;
            MLCLog(@"tapBlock %@", label.text);
        }];
        [_aLabel setMlc_longPressBlock:^(UIView *currentView, UILongPressGestureRecognizer *recognizer) {
            if (recognizer.state == UIGestureRecognizerStateBegan) {
                UILabel *label = (UILabel *)currentView;
                MLCLog(@"longPressBlock %@", label.text);
            }
        }];
        [self.view addSubview:_aLabel];
        [_aLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.top.equalTo(self.view).offset(100);
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
    }
    return _aLabel;
}
#pragma mark -
- (void)useUrlEncode {//URL编码
//    NSString *string = @"汉字666";
    NSString *string = @"https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊";
    NSString *encodeString = [string mlc_urlEncode];
    NSLog(@"%@, %@",string, encodeString);
}
- (void)useUrlDecode {//URL解码
//    NSString *string = @"汉字666";
    NSString *string = @"https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊";
    NSString *encodeString = [string mlc_urlEncode];
    NSString *decodeString = [encodeString mlc_urlDecode];
    NSLog(@"string = %@,\n encodeString = %@,\n decodeString = %@",string, encodeString, decodeString);
}

@end
