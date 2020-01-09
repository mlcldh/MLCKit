//
//  MLCLocalFolderViewController.h
//  MLCKit
//
//  Created by menglingchao on 2019/12/18.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLCLocalFolderViewController : UIViewController

/***/
@property (nonatomic, copy, readonly) NSString *folderPath;
- (instancetype)initWithFolderPath:(NSString *)folderPath;

@end
