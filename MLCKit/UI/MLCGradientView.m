//
//  MLCGradientView.m
//  MLCKit
//
//  Created by menglingchao on 2019/12/20.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "MLCGradientView.h"

@implementation MLCGradientView

+ (Class)layerClass {
    return [CAGradientLayer class];
}
- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}

@end
