//
//  MLCShapeLayerView.m
//  Pods
//
//  Created by menglingchao on 2020/10/28.
//  Copyright © 2020 MengLingChao. All rights reserved.
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
