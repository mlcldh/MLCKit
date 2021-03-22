//
//  MLCTableViewSection.h
//  MLCKit
//
//  Created by menglingchao on 2021/3/19.
//

#import <Foundation/Foundation.h>
#import "MLCTableViewRow.h"

@interface MLCTableViewSection : NSObject

/***/
@property (nonatomic, readonly) NSMutableArray<MLCTableViewRow *> *rows;
/**cell高度回调*/
@property (nonatomic, copy) CGFloat (^headerHeightHandler)(void);
/**cell高度回调*/
@property (nonatomic, copy) UIView *(^headeViewHandler)(void);

@end
