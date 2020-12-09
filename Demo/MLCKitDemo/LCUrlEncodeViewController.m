//
//  LCUrlEncodeViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCUrlEncodeViewController.h"
#import "NSString+MLCKit.h"

@interface LCUrlEncodeViewController ()

@end

@implementation LCUrlEncodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self useUrlEncode];
    [self useUrlDecode];
}
#pragma mark -
- (void)useUrlEncode {//URL编码
//    NSString *string = @"汉字666";
    NSString *string = @"https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊";
    NSString *encodeString = [string mlc_urlEncode];
    NSLog(@"menglc %@, encodeString = %@",string, encodeString);
}
- (void)useUrlDecode {//URL解码
//    NSString *string = @"汉字666";
    NSString *string = @"https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊";
    NSString *encodeString = [string mlc_urlEncode];
    NSString *decodeString = [encodeString mlc_urlDecode];
    NSLog(@"menglc string = %@,\n encodeString = %@,\n decodeString = %@",string, encodeString, decodeString);
}

@end
