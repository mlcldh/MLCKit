//
//  MLCProxy.h
//  MLCKit
//
//  Created by MengLingChao on 2019/9/17.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

/***/
@interface MLCProxy : NSProxy

/***/
@property (nonatomic, weak, readonly) id target;
/***/
+ (instancetype)proxyWithTarget:(id)target;

@end

//NS_ASSUME_NONNULL_END
