//
//  LCPerson.m
//  MLCKitDemo
//
//  Created by menglingchao on 2020/8/21.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

#import "LCPerson.h"
#import "NSObject+MLCKit.h"

@implementation LCPerson

//反归档(反序列化)
//对person对象进行反归档时,该方法执行
//创建一个新的person对象,所有属性都是通过反序列化得到
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self mlc_setValuesWithCoder:aDecoder];
    }
    
    return self;
}
//归档(序列化)
//对person对象进行归档时,此方法执行
//对person中想要进行归档的所有属性,进行序列化操作
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self mlc_encodeWithCoder:aCoder];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
