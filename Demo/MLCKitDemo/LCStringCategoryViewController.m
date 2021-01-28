//
//  LCStringCategoryViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCStringCategoryViewController.h"
#import "NSString+MLCKit.h"

@interface LCStringCategoryViewController ()

@end

@implementation LCStringCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self useUrlEncode];
    [self useUrlDecode];
    [self useTrim];
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
- (void)useTrim {
    NSString *string = @"   abc  defgh  \n ijkl \n   ";
    NSLog(@"menglc TrimmingWhitespace %@ end", [string mlc_stringByTrimmingWhitespaceCharacters]);
    NSLog(@"menglc TrimmingNewline %@ end", [string mlc_stringByTrimmingNewlineCharacters]);
    NSLog(@"menglc TrimmingWhitespaceAndNewline %@ end", [string mlc_stringByTrimmingWhitespaceAndNewlineCharacters]);
}

@end
