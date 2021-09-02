//
//  MLCScanQRCodeViewController.h
//  MLCKit
//
//  Created by menglingchao on 2021/1/8.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**扫描二维码*/
@interface MLCScanQRCodeViewController : UIViewController

/**扫码成功回调*/
@property (nonatomic, copy) void(^scanSuccessHandler)(NSArray<NSString *> *qrCodeStrings);
/**点击关闭回调*/
@property (nonatomic, copy) void(^tapCloseHandler)(void);
/***/
- (void)continueScanning;

@end
