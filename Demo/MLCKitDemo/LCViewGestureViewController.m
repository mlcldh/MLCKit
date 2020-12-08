//
//  LCViewGestureViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCViewGestureViewController.h"
#import "Masonry.h"
#import "MLCMacror.h"
#import "UIView+MLCKit.h"
#import "UIControl+MLCKit.h"

@interface LCViewGestureViewController ()

@end

@implementation LCViewGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self useLabelGesture];
    [self useButtonAddAction];
    [self useSwitchAddAction];
}
#pragma mark - Getter
- (void)useLabelGesture {
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor purpleColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    //        _aLabel.font = [UIFont systemFontOfSize:18];
    label.text = @"轻学堂";
    [label mlc_addGestureRecognizerWithType:(MLCGestureRecognizerTypeTap) handler:^(UIGestureRecognizer *recognizer) {
        UILabel *label = (UILabel *)(recognizer.view);
        MLCLog(@"menglc tap %@", label.text);
    }];
    [label mlc_addGestureRecognizerWithType:(MLCGestureRecognizerTypeTap) handler:^(UIGestureRecognizer *recognizer) {
        UILabel *label = (UILabel *)(recognizer.view);
        MLCLog(@"menglc tap2 %@", label.text);
    }];
    [label mlc_removeGestureRecognizersWithType:(MLCGestureRecognizerTypeTap)];
    [label mlc_addGestureRecognizerWithType:(MLCGestureRecognizerTypeTap) handler:^(UIGestureRecognizer *recognizer) {
        UILabel *label = (UILabel *)(recognizer.view);
        MLCLog(@"menglc tap3 %@", label.text);
    }];
    [label mlc_addGestureRecognizerWithType:(MLCGestureRecognizerTypeLongPress) handler:^(UIGestureRecognizer *recognizer) {
        UILongPressGestureRecognizer *longPressGestureRecognizer = (UILongPressGestureRecognizer *)recognizer;
        if (longPressGestureRecognizer.state != UIGestureRecognizerStateBegan) {
            return;
        }
        UILabel *label = (UILabel *)longPressGestureRecognizer.view;
        MLCLog(@"menglc longPress %@", label.text);
    }];
    [label mlc_addGestureRecognizerWithType:(MLCGestureRecognizerTypePan) handler:^(UIGestureRecognizer *recognizer) {
        MLCLog(@"menglc pan");
    }];
//    [label mlc_removeGestureRecognizersWithType:(MLCGestureRecognizerTypePan)];
//    [label mlc_removeAllGestureRecognizers];
    [label mlc_addGestureRecognizerWithType:(MLCGestureRecognizerTypeSwipe) handler:^(UIGestureRecognizer *recognizer) {
        MLCLog(@"menglc swipe");
    }];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
}
- (void)useButtonAddAction {
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitle:@"button" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button mlc_addActionForControlEvents:(UIControlEventTouchUpInside) handler:^(id sender) {
        MLCLog(@"menglc button UIControlEventTouchUpInside");
    }];
    [button mlc_addActionForControlEvents:(UIControlEventTouchUpInside) handler:^(id sender) {
        MLCLog(@"menglc button UIControlEventTouchUpInside 2");
    }];
    [button mlc_removeAllActionsForControlEvents:(UIControlEventTouchUpInside)];
//    [button mlc_removeAllActions];
    [button mlc_addActionForControlEvents:(UIControlEventTouchUpInside) handler:^(id sender) {
        MLCLog(@"menglc button UIControlEventTouchUpInside 3");
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(150);
    }];
}
- (void)useSwitchAddAction {
    UISwitch *aSwitch = [[UISwitch alloc]init];
    [aSwitch mlc_addActionForControlEvents:(UIControlEventValueChanged) handler:^(id sender) {
        UISwitch *switch2 = sender;
        MLCLog(@"menglc switch2.isOn = %@", @(switch2.isOn));
    }];
    //        [_aSwitch mlc_addActionForControlEvents:(UIControlEventValueChanged) handler:^(id sender) {
    //            UISwitch *switch2 = sender;
    //            MLCLog(@"menglc switch2.isOn 2 = %@", @(switch2.isOn));
    //        }];
    [self.view addSubview:aSwitch];
    [aSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(200);
    }];
}

@end
