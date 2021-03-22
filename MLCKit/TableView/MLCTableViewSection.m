//
//  MLCTableViewSection.m
//  MLCKit
//
//  Created by menglingchao on 2021/3/19.
//

#import "MLCTableViewSection.h"

@interface MLCTableViewSection ()

@property (nonatomic, strong) NSMutableArray<MLCTableViewRow *> *rows;//

@end

@implementation MLCTableViewSection

- (NSMutableArray<MLCTableViewRow *> *)rows {
    if (!_rows) {
        _rows = [NSMutableArray array];
    }
    return _rows;
}

@end
