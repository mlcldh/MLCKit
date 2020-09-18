//
//  MLCLabelView.m
//  MLCKit
//
//  Created by menglingchao on 2017/12/22.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "MLCLabelView.h"
#import "Masonry.h"

@implementation MLCLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self label];
    }
    return self;
}
#pragma mark - Getter
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _label;
}
#pragma mark - Setter
- (void)setLabelContainerInset:(UIEdgeInsets)labelContainerInset {
    _labelContainerInset = labelContainerInset;
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(labelContainerInset);
    }];
}

@end
