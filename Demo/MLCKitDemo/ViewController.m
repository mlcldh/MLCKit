//
//  ViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+MLCKit.h"
#import "NSString+MLCKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self useUrlEncode];
    [self useUrlDecode];
}
#pragma mark -
- (void)useUrlEncode {
//    NSString *string = @"汉字666";
    NSString *string = @"https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊";
    NSString *encodeString = [string mlc_urlEncode];
    NSLog(@"%@, %@",string, encodeString);
}
- (void)useUrlDecode {
//    NSString *string = @"汉字666";
    NSString *string = @"https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊";
    NSString *encodeString = [string mlc_urlEncode];
    NSString *decodeString = [encodeString mlc_urlDecode];
    NSLog(@"string = %@,\n encodeString = %@,\n decodeString = %@",string, encodeString, decodeString);
}

@end
