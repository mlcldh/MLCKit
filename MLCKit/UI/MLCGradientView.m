//
//  MLCGradientView.m
//  Masonry
//
//  Created by menglingchao on 2019/12/20.
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
