//
//  MLCTableViewSection.m
//  MLCKit
//
//  Created by menglingchao on 2021/3/19.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "MLCTableViewSection.h"

@interface MLCTableViewSection ()

@property (nonatomic, strong) NSMutableArray *models;//

@end

@implementation MLCTableViewSection

- (NSMutableArray *)models {
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end
