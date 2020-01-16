//
//  MLCCache.h
//  MLCKit
//
//  Created by MengLingChao on 2019/1/27.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**缓存*/
@interface MLCCache : NSObject

/**单例，存放在Documents文件夹内，app设置里面清理缓存不可以删除的缓存*/
+ (instancetype)coreCache;

/**单例，存放在Library文件夹内，app设置里面清理缓存可以删除的缓存*/
+ (instancetype)simpleCache;

/**非单例，普通实例，自定义缓存路径，当path路径和coreCache、simpleCache重复时，返回nil*/
+ (instancetype)cacheWithPath:(NSString *)path;

/**缓存中是否有该key的缓存，同步操作*/
- (BOOL)containsObjectForKey:(NSString *)key;

/**缓存中是否有该key的缓存，异步操作*/
- (void)containsObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, BOOL contains))block;

/**获取该key的值，同步操作*/
- (nullable id)objectForKey:(NSString *)key;

/**获取该key的布尔值，同步操作*/
- (BOOL)boolForKey:(NSString *)key;
/**获取该key的NSInteger，同步操作*/
- (NSInteger)integerForKey:(NSString *)key;
/**获取该key的long long，同步操作*/
- (long long)longLongForKey:(NSString *)key;
/**获取该key的float，同步操作*/
- (float)floatForKey:(NSString *)key;
/**获取该key的double，同步操作*/
- (double)doubleForKey:(NSString *)key;
/**获取该key的字符串，同步操作*/
- (nullable NSString *)stringForKey:(NSString *)key;

/**获取该key的值，异步操作*/
- (void)objectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, id<NSCoding> object))block;

/*缓存该key的值，不存到内存缓存里，同步操作**/
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key;

/*缓存该key的值，可设置存到内存缓存里，同步操作**/
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key alsoSaveInMemory:(BOOL)alsoSaveInMemory;

/**缓存该key的值，不存到内存缓存里，异步操作*/
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(nullable void(^)(void))block;

/*缓存该key的值，可设置存到内存缓存里，异步操作**/
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key alsoSaveInMemory:(BOOL)alsoSaveInMemory withBlock:(nullable void(^)(void))block;

/**移除该key的缓存，同步操作*/
- (void)removeObjectForKey:(NSString *)key;

/**移除该key的缓存，异步操作*/
- (void)removeObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key))block;

/**移除所有缓存，同步操作*/
- (void)removeAllObjects;

/**移除所有缓存，异步操作*/
- (void)removeAllObjectsWithBlock:(void(^)(void))block;

/**移除所有缓存，并且获取移除进度，异步操作*/
- (void)removeAllObjectsWithProgressBlock:(nullable void(^)(int removedCount, int totalCount))progress
                                 endBlock:(nullable void(^)(BOOL error))end;

@end

NS_ASSUME_NONNULL_END

