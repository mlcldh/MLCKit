//
//  MLCGradientLayerView.m
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "MLCGradientLayerView.h"

@implementation MLCGradientLayerView

+ (Class)layerClass {
    return [CAGradientLayer class];
}
- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}

@end
