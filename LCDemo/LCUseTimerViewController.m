//
//  LCUseTimerViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2022/1/20.
//  Copyright © 2022 MengLingchao. All rights reserved.
//

#import "LCUseTimerViewController.h"
#import "MLCTimer.h"

@interface LCUseTimerViewController ()

@property (nonatomic, strong) MLCTimer *timer;//

@end

@implementation LCUseTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self useMLCTimer];
    [self addUseMLCTimerButton];
    [self addInvalidateMLCTimerButton];
}
#pragma mark -
- (void)addUseMLCTimerButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"开启定时器" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [self useMLCTimer];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
    }];
}
- (void)addInvalidateMLCTimerButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button setTitle:@"关闭定时器" forState:(UIControlStateNormal)];
    @weakify(self)
    [button setMlc_touchUpInsideBlock:^{
        @strongify(self)
        [self.timer invalidate];
        NSLog(@"menglc timer invalidate %@", @(self.timer.valid));
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(120);
        make.top.equalTo(self.view).offset(100);
    }];
}
- (void)useMLCTimer {
    NSLog(@"menglc useMLCTimer");
    dispatch_queue_t queue = dispatch_queue_create("LCQueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue = dispatch_queue_create("LCQueue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue = dispatch_get_main_queue();
    @weakify(self)
    self.timer = [[MLCTimer alloc] initWithTimeInterval:1 delay:3 repeats:YES queue:queue handler:^(MLCTimer *timer) {
        @strongify(self)
        NSLog(@"menglc MLCTimer handler %@, %@", [NSThread currentThread], @(self.timer.valid));
    }];
}

@end
