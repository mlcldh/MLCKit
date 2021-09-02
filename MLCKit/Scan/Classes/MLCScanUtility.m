//
//  MLCScanUtility.m
//  MLCKit
//
//  Created by menglingchao on 2021/2/19.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import "MLCScanUtility.h"

@implementation MLCScanUtility

+ (NSArray<NSString *> *)QRCodeStringsWithImage:(UIImage *)image {
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    NSMutableArray *qrCodeStrings = [NSMutableArray array];
    for (CIQRCodeFeature *feature in features) {
        NSString *qrCodeString = feature.messageString;
        [qrCodeStrings addObject:qrCodeString];
    }
    return qrCodeStrings;
}

@end
