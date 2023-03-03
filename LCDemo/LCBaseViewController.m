//
//  LCBaseViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/12/9.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCBaseViewController.h"

@interface LCBaseViewController ()

@end

@implementation LCBaseViewController

- (void)dealloc {
    NSLog(@"menglc dealloc %@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
