//
//  MLCCaptureVideoPreviewLayerView.h
//  MLCKit
//
//  Created by menglingchao on 2021/1/13.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/***/
@interface MLCCaptureVideoPreviewLayerView : UIView

/***/
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

/***/
- (instancetype)initWithFrame:(CGRect)frame session:(AVCaptureSession *)session;

@end
