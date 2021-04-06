//
//  MLCFileUtility.h
//  MLCKit
//
//  Created by menglingchao on 2020/11/30.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**文件相关工具类*/
@interface MLCFileUtility : NSObject

/**获取Document文件目录*/
+ (NSString*)documentDirectoryPath;
/**获取Temp文件目录*/
+ (NSString*)temporaryDirectoryPath;
/**获取Home文件目录*/
+ (NSString*)homeDirectoryPath;
/**获取Cache文件目录*/
+ (NSString*)cachesDirectoryPath;
/**创建文件夹*/
+ (BOOL)creatDirectoryWithPath:(NSString *)path;
/**删除文件夹或文件*/
+ (BOOL)removeItemAtPath:(NSString *)path;
/**移动文件*/
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;
/**拷贝文件*/
+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;
/** 获取文件或者文件夹大小(单位：B) */
+ (unsigned long long)sizeAtPath:(NSString *)path;

@end
