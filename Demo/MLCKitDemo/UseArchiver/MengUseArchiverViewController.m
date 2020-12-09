//
//  MengUseArchiverViewController.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "MengUseArchiverViewController.h"
#import "LCPerson.h"

@interface MengUseArchiverViewController ()

@end

@implementation MengUseArchiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self useArchiver];
    [self useUnarchiver];
}
#pragma mark - Getter
- (NSString *)filepath {
    NSString *path = NSHomeDirectory();
    NSLog(@"menglc path %@",path);
    path = [path stringByAppendingPathComponent:@"aPerson"];
    return path;
}
#pragma mark -
-(void)useArchiver {
    LCPerson *per = [[LCPerson alloc]init];
    per.name = @"Jordon";
    per.gender = @"男";
    per.age = 22;
    
    LCDog *dog = [[LCDog alloc]init];
    dog.name = @"Bingo";
    dog.gender = @"male";
    dog.age = 3;
    
    per.dog = dog;
    
    //准备路径:
    NSString *path = [self filepath];
    
    //1:准备存储数据的对象
    NSMutableData *data = [NSMutableData data];
    //2:创建归档对象
    NSKeyedArchiver *archiver = nil;
//    if (@available(iOS 11.0, *)) {
//        archiver = [[NSKeyedArchiver alloc] initRequiringSecureCoding:YES];
//    } else {
        archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//    }
    //3:开始归档
    [archiver encodeObject:per forKey:@"person"];
    //4:完成归档
    [archiver finishEncoding];
    //5:写入文件当中
    BOOL result = [data writeToFile:path atomically:YES];
    if (result) {
        NSLog(@"menglc 归档成功");
    } else {
        NSLog(@"menglc 归档不成功");
    }
}
-(void)useUnarchiver {
    //准备路径:
    NSString *path = [self filepath];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *archiver = nil;
//    if (@available(iOS 11.0, *)) {
//        NSError *error = nil;
//        archiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:&error];
//        archiver.decodingFailurePolicy = NSDecodingFailurePolicySetErrorAndReturn;
//        NSLog(@"menglc initForReadingFromData error %@", error);
//    } else {
        archiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    }
    LCPerson *per = [archiver decodeObjectForKey:@"person"];
    NSLog(@"menglc 反归档 person %@, %@, %@", per.name, per.gender, @(per.age));
    NSLog(@"menglc 反归档 dog %@, %@, %@", per.dog.name, per.dog.gender, @(per.dog.age));
}

@end
