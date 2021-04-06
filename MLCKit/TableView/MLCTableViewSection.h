//
//  MLCTableViewSection.h
//  MLCKit
//
//  Created by menglingchao on 2021/3/19.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLCTableViewSection : NSObject

/***/
@property (nonatomic, readonly) NSMutableArray *models;
/**section头部高度回调*/
@property (nonatomic, copy) CGFloat (^headerHeightHandler)(void);
/**section头部视图回调*/
@property (nonatomic, copy) UIView *(^headerViewHandler)(void);
/**section底部高度回调*/
@property (nonatomic, copy) CGFloat (^footerHeightHandler)(void);
/**section底部视图回调*/
@property (nonatomic, copy) UIView *(^footerViewHandler)(void);

/// cell类回调
@property (nonatomic, copy) Class (^cellClassHandler)(NSIndexPath *indexPath, id model);
/// 配置cell回调
@property (nonatomic, copy) void(^configCellHandler)(UITableViewCell *cell, NSIndexPath *indexPath, id model);
/// cell高度回调
@property (nonatomic, copy) CGFloat (^cellHeightHandler)(NSIndexPath *indexPath, id model);
/// 点击cell回调
@property (nonatomic, copy) void(^didSelectHandler)(NSIndexPath *indexPath, id model);
/// 编辑样式回调
@property (nonatomic, copy) UITableViewCellEditingStyle (^editingStyleHandler)(NSIndexPath *indexPath, id model);
/// 删除样式标题回调
@property (nonatomic, copy) NSString *(^titleForDeleteConfirmationButtonHandler)(NSIndexPath *indexPath, id model);
/// 自定义编辑样式回调
@property (nonatomic, copy) NSArray<UITableViewRowAction *> *(^editActionsHandler)(NSIndexPath *indexPath, id model);
/// 自定义往右划编辑样式回调
@property (nonatomic, copy) UISwipeActionsConfiguration *(^leadingSwipeActionsConfigurationHandler)(NSIndexPath *indexPath, id model)   API_AVAILABLE(ios(11.0));
/// 自定义往左划编辑样式回调
@property (nonatomic, copy) UISwipeActionsConfiguration *(^trailingSwipeActionsConfigurationHandler)(NSIndexPath *indexPath, id model)   API_AVAILABLE(ios(11.0));
/// 提交编辑回调
@property (nonatomic, copy) void(^commitEditingStyleHandler)(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath, id model);

@end
