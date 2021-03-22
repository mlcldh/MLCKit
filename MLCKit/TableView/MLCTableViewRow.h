//
//  MLCTableViewRow.h
//  MLCKit
//
//  Created by menglingchao on 2021/3/19.
//

#import <Foundation/Foundation.h>


@interface MLCTableViewRow : NSObject

/**回调*/
@property (nonatomic, copy) UITableViewCell *(^configCellHandler)(void);
/**cell高度回调*/
@property (nonatomic, copy) CGFloat (^cellHeightHandler)(void);
/**点击回调*/
@property (nonatomic, copy) void(^didSelectHandler)(void);

@end
