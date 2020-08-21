//
//  LCPerson.h
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDog.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCPerson : NSObject<NSSecureCoding>

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *gender;
@property(nonatomic,strong) LCDog *dog;
@property(nonatomic) int age;

@end

NS_ASSUME_NONNULL_END
