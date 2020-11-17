//
//  MLCShapeLayerView.m
//  Pods
//
//  Created by menglingchao on 2020/10/28.
//

#import "MLCShapeLayerView.h"

@implementation MLCShapeLayerView

+ (Class)layerClass {
    return [CAShapeLayer class];
}
- (CAShapeLayer *)shapeLayer {
    return (CAShapeLayer *)self.layer;
}

@end
