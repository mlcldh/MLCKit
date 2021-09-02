//
//  MLCCaptureVideoPreviewLayerView.m
//  MLCKit
//
//  Created by menglingchao on 2021/1/13.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "MLCCaptureVideoPreviewLayerView.h"

@implementation MLCCaptureVideoPreviewLayerView

- (instancetype)initWithFrame:(CGRect)frame session:(AVCaptureSession *)session {
    self = [super initWithFrame:frame];
    if (self) {
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
        [self.layer insertSublayer:self.previewLayer atIndex:0];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.previewLayer.frame = self.bounds;
}

@end
