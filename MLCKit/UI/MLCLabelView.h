//
//  MLCLabelView.h
//  MLCKit
//
//  Created by menglingchao on 2017/12/22.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>

/***/
@interface MLCLabelView : UIView

/***/
@property (nonatomic, strong) UILabel *label;
/***/
@property (nonatomic) UIEdgeInsets labelContainerInset;
/**点击回调*/
@property (nonatomic, copy) void(^tapBlock)(void);

@end

