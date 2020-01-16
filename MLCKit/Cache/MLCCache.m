//
//  MLCCache.m
//  MLCKit
//
//  Created by MengLingChao on 2019/1/27.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "MLCCache.h"
#import "YYCache.h"

@interface MLCCache ()

@property (nonatomic, strong) YYCache *yyCache;//

@end

@implementation MLCCache

+ (instancetype)coreCache {
    static dispatch_once_t onceToken;
    static MLCCache *cache = nil;
    dispatch_once(&onceToken, ^{
        cache = [[MLCCache alloc]init];
        NSString *documentFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *path = [documentFolder stringByAppendingPathComponent:@"mlc_core_cache"];
        cache.yyCache = [[YYCache alloc]initWithPath:path];
    });
    return cache;
}
+ (instancetype)simpleCache {
    static dispatch_once_t onceToken;
    static MLCCache *cache = nil;
    dispatch_once(&onceToken, ^{
        cache = [[self alloc]init];
        NSString *libraryFolder = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        NSString *path = [libraryFolder stringByAppendingPathComponent:@"mlc_simple_cache"];
        cache.yyCache = [[YYCache alloc]initWithPath:path];
    });
    return cache;
}
+ (instancetype)cacheWithPath:(NSString *)path {
    if ([path isEqualToString:[MLCCache coreCache].yyCache.diskCache.path] || [path isEqualToString:[MLCCache simpleCache].yyCache.diskCache.path]) {
        return nil;
    }
    MLCCache *cache = [[self alloc]init];
    cache.yyCache = [[self alloc]initWithPath:path];
    return cache;
}
- (BOOL)containsObjectForKey:(NSString *)key {
    return [self.yyCache containsObjectForKey:key];
}
- (void)containsObjectForKey:(NSString *)key withBlock:(void (^)(NSString *, BOOL))block {
    [self.yyCache containsObjectForKey:key withBlock:block];
}
- (id)objectForKey:(NSString *)key {
    return [self.yyCache objectForKey:key];
}
- (BOOL)boolForKey:(NSString *)key {
    NSNumber *number = (NSNumber *)[self.yyCache objectForKey:key];
    return [number boolValue];
}
- (NSInteger)integerForKey:(NSString *)key {
    NSNumber *number = (NSNumber *)[self.yyCache objectForKey:key];
    return [number integerValue];
}
- (long long)longLongForKey:(NSString *)key {
    NSNumber *number = (NSNumber *)[self.yyCache objectForKey:key];
    return [number longLongValue];
}
- (float)floatForKey:(NSString *)key {
    NSNumber *number = (NSNumber *)[self.yyCache objectForKey:key];
    return [number floatValue];
}
- (double)doubleForKey:(NSString *)key {
    NSNumber *number = (NSNumber *)[self.yyCache objectForKey:key];
    return [number doubleValue];
}
- (NSString *)stringForKey:(NSString *)key {
    NSString *string = (NSString *)[self.yyCache objectForKey:key];
    if (string && ![string isKindOfClass:[NSString class]]) {//保护下
        string = [NSString stringWithFormat:@"%@",string];
    }
    return string;
}
- (void)objectForKey:(NSString *)key withBlock:(void (^)(NSString *, id<NSCoding>))block {
    [self.yyCache objectForKey:key withBlock:block];
}
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [self setObject:object forKey:key alsoSaveInMemory:NO];
}
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key alsoSaveInMemory:(BOOL)alsoSaveInMemory {
    if (alsoSaveInMemory) {
        [self.yyCache setObject:object forKey:key];
    } else {
        [self.yyCache.memoryCache removeObjectForKey:key];//保证下次读取不会有问题
        [self.yyCache.diskCache setObject:object forKey:key];
    }
}
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void (^)(void))block {
    [self setObject:object forKey:key alsoSaveInMemory:NO withBlock:block];
}
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key alsoSaveInMemory:(BOOL)alsoSaveInMemory withBlock:(void (^)(void))block {
    if (alsoSaveInMemory) {
        [self.yyCache setObject:object forKey:key withBlock:block];
    } else {
        [self.yyCache.diskCache setObject:object forKey:key withBlock:block];
    }
}
- (void)removeObjectForKey:(NSString *)key {
    [self.yyCache removeObjectForKey:key];
}
- (void)removeObjectForKey:(NSString *)key withBlock:(void (^)(NSString *))block {
    [self.yyCache removeObjectForKey:key withBlock:block];
}
- (void)removeAllObjects {
    [self.yyCache removeAllObjects];
}
- (void)removeAllObjectsWithBlock:(void(^)(void))block {
    [self.yyCache removeAllObjectsWithBlock:block];
}
- (void)removeAllObjectsWithProgressBlock:(void (^)(int, int))progress endBlock:(void (^)(BOOL))end {
    [self.yyCache removeAllObjectsWithProgressBlock:progress endBlock:end];
}

@end
