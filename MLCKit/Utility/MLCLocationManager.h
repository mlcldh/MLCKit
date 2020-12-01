//
//  MLCLocationManager.h
//  MLCKit
//
//  Created by menglingchao on 2020/12/1.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**定位*/
@interface MLCLocationManager : NSObject

/**单例*/
+ (instancetype)sharedInstance;
/**获取定位*/
- (void)getLocation;

@end
