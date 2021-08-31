//
//  LCJsonViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/10/9.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCJsonViewController.h"
#import "NSObject+MLCKit.h"
#import "NSString+MLCKit.h"
#import "LCPerson.h"

@interface LCJsonViewController ()

@end

@implementation LCJsonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getJSONString];
    [self getJSONObject];
    [self seeRetainCount];
}
#pragma mark -
- (void)getJSONString {
//    LCPerson *obj = [[LCPerson alloc]init];
//    obj.name = @"Tom";
//    obj.age = 22;
    NSArray *obj = @[@"Tom", @"Jim", @"Jordon"];
//    NSDictionary *obj = @{@"name": @"Tom", @"age": @22, @"height": @1.98};
    NSString *jsonString = [obj mlc_JSONString];
    NSLog(@"menglc getJSONString %@", jsonString);
}
- (void)getJSONObject {
//    NSString *jsonString = @"";
//    NSString *jsonString = @"[\"Tom\",\"Jim\",\"Jordon\"]";
    NSString *jsonString = @"{\"name\": \"Tom\", \"age\": 22, \"height\": 1.98}";
    id jsonObject = [jsonString mlc_JSONObject];
    NSLog(@"menglc getJSONObject %@", jsonObject);
}
- (void)seeRetainCount {
    UIView *view = [[UIView alloc]init];
    NSLog(@"menglc mlc_retainCount 0 %@", @(view.mlc_retainCount));
//    [self.view addSubview:view];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:view];
//    @weakify(view)
//    void (^block)(void) = ^{
////        @strongify(view)
//        NSLog(@"%@",view);
//    };
    NSLog(@"menglc mlc_retainCount 1 %@", @(view.mlc_retainCount));
//    block();
//    block = nil;
//    NSLog(@"menglc mlc_retainCount 2 %@", @(view.mlc_retainCount));
}

@end
