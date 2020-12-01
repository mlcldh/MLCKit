//
//  MLCFileUtility.m
//  MLCKit
//
//  Created by menglingchao on 2020/11/30.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "MLCFileUtility.h"

@implementation MLCFileUtility

+ (NSString*)documentDirectoryPath {
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return documents.firstObject;
}
+ (NSString*)temporaryDirectoryPath {
    NSString *tempPath = NSTemporaryDirectory();
    return tempPath;
}
+ (NSString*)homeDirectoryPath {
    return NSHomeDirectory();
}
+ (NSString*)cachesDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return paths.firstObject;
}
+ (BOOL)creatDirectoryWithPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL exists = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    //目标路径的目录不存在则创建目录
    if (!(isDir == YES && exists == YES)) {
        return [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        return NO;
    }
}
+ (BOOL)removeItemAtPath:(NSString *)path {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:path];
    if (blHave) {
        return [fileManager removeItemAtPath:path error:nil];
    } else {
        return NO;
    }
}
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (srcPath.length < 1) {
        return NO;
    }
    BOOL srcExisted = [fileManager fileExistsAtPath:srcPath isDirectory:nil];
    if (!srcExisted) {
        return NO;
    }
    
    //如果不存在则创建目录
    [self creatDirectoryWithPath:[dstPath stringByDeletingLastPathComponent]];
    
    BOOL moveSuccess = [fileManager moveItemAtPath:srcPath toPath:dstPath error:error];
    return moveSuccess;
}
+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (srcPath.length < 1) {
        return NO;
    }
    BOOL srcExisted = [fileManager fileExistsAtPath:srcPath isDirectory:nil];
    if (!srcExisted) {
        return NO;
    }
    
    //如果不存在则创建目录
    [self creatDirectoryWithPath:[dstPath stringByDeletingLastPathComponent]];
    
    BOOL copySuccess = [fileManager copyItemAtPath:srcPath toPath:dstPath error:error];
    return copySuccess;
}
+ (unsigned long long)sizeAtPath:(NSString *)path {
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if (![fm fileExistsAtPath:path isDirectory:&isDir]) {
        return 0;
    };
    unsigned long long fileSize = 0;
    // directory
    if (isDir) {
        NSDirectoryEnumerator *enumerator = [fm enumeratorAtPath:path];
        while (enumerator.nextObject) {
            fileSize += enumerator.fileAttributes.fileSize;
        }
    } else {
        // file
        fileSize = [fm attributesOfItemAtPath:path error:nil].fileSize;
    }
    return fileSize;
}

@end
