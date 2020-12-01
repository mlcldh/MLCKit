//
//  LCOpenUtilityViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/12/1.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCOpenUtilityViewController.h"
#import "Masonry.h"
//#import "MLCMacror.h"
#import "UIControl+MLCKit.h"
#import "NSString+MLCKit.h"
#import "MLCOpenUtility.h"

@interface LCOpenUtilityViewController ()

@end

@implementation LCOpenUtilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addCallButton];
    [self addSendShortMessagingButton];
    [self addSendEmailButton];
    [self addOpenSettingsButton];
}
#pragma mark -
- (void)addCallButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"打电话" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [MLCOpenUtility callWithTelephoneNumber:@"13813813813"];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
}
- (void)addSendShortMessagingButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"发短信" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [MLCOpenUtility sendShortMessage:[@"13813813813&body=短信内容" mlc_urlEncode]];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(80);
        make.top.equalTo(self.view).offset(100);
    }];
}
- (void)addSendEmailButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"发邮件" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [MLCOpenUtility sendEmail:@"13813813813@qq.com"];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(140);
        make.top.equalTo(self.view).offset(100);
    }];
}
- (void)addOpenSettingsButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"跳转到app设置页面" forState:(UIControlStateNormal)];
    [button setMlc_touchUpInsideBlock:^{
        [MLCOpenUtility openSettings];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(200);
        make.top.equalTo(self.view).offset(100);
    }];
}

@end
