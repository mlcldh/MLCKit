//
//  MLCAnnularView.m
//  MLCKit
//
//  Created by menglingchao on 2021/1/29.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "MLCAnnularView.h"
#import "Masonry.h"
#import "MLCShapeLayerView.h"

@interface MLCAnnularView ()

@end

@implementation MLCAnnularView

- (instancetype)initWithStrokeThickness:(CGFloat)strokeThickness width:(CGFloat)width rounded:(BOOL)rounded {
    return [self initWithStrokeThickness:strokeThickness width:width height:width rounded:rounded];
}
- (instancetype)initWithStrokeThickness:(CGFloat)strokeThickness width:(CGFloat)width height:(CGFloat)height rounded:(BOOL)rounded {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _lineBackground = [[MLCShapeLayerView alloc]init];
        _lineBackground.shapeLayer.lineWidth = strokeThickness;
        _lineBackground.shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _lineBackground.shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        UIBezierPath *path = nil;
        if (rounded) {
            path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width - strokeThickness, height - strokeThickness) cornerRadius:MIN(width, height) / 2];
        } else {
            path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, width - strokeThickness, height - strokeThickness)];
        }
        _lineBackground.shapeLayer.path = path.CGPath;
        [self addSubview:_lineBackground];
        [_lineBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.height.equalTo(self).offset(-strokeThickness);
        }];
        
        _line = [[MLCShapeLayerView alloc]init];
        _line.shapeLayer.lineWidth = strokeThickness;
        _line.shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _line.shapeLayer.strokeColor = [UIColor systemBlueColor].CGColor;
        _line.shapeLayer.path = path.CGPath;
        _line.shapeLayer.strokeEnd = 0;
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.lineBackground);
        }];
    }
    return self;
}


@end
