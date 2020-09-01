//
//  LCUseConstraintPurelyViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/9/1.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCUseConstraintPurelyViewController.h"
#import "UIView+MLCKit.h"
#import "UIControl+MLCKit.h"
#import "MLCMacror.h"

@interface LCUseConstraintPurelyViewController ()

@end

@implementation LCUseConstraintPurelyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self useConstraintPurely];
}
#pragma mark -
- (void)useConstraintPurely {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitle:@"button" forState:(UIControlStateNormal)];
    @weakify(self)
    @weakify(button)
    [button mlc_addActionForControlEvents:(UIControlEventTouchUpInside) callback:^(id sender) {
        @strongify(self)
        @strongify(button)
        [self.view mlc_removeConstraintsWithFirstItem:button firstAttribute:(NSLayoutAttributeLeft)];
        [button mlc_addConstraintWithFirstAttribute:(NSLayoutAttributeRight) relation:(NSLayoutRelationEqual) secondItem:self.view secondAttribute:(NSLayoutAttributeRight) multiplier:1 constant:-50];
        [UIView animateWithDuration:2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }];
    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button mlc_addConstraintWithFirstAttribute:(NSLayoutAttributeLeft) relation:(NSLayoutRelationEqual) secondItem:self.view secondAttribute:(NSLayoutAttributeLeft) multiplier:1 constant:50];
    [button mlc_addConstraintWithFirstAttribute:(NSLayoutAttributeTop) relation:(NSLayoutRelationEqual) secondItem:self.view secondAttribute:(NSLayoutAttributeTop) multiplier:1 constant:50];
    NSLog(@"menglc constraints %@", self.view.constraints);
}

@end
