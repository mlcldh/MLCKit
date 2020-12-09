//
//  LCUseProxyViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCUseProxyViewController.h"
#import "MLCProxy.h"

@interface LCUseProxyViewController ()

@property (nonatomic, strong) NSTimer *timer;//


@end

@implementation LCUseProxyViewController

- (void)dealloc {
    [self.timer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self useProxy];
}
#pragma mark - Event
- (void)timerAction:(NSTimer *)timer {
    NSLog(@"menglc timerAction");
}
#pragma mark -
- (void)useProxy {
    self.timer = [NSTimer timerWithTimeInterval:1 target:[MLCProxy proxyWithTarget:self] selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

@end
