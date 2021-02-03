//
//  MLCAnnularView.h
//  MLCKit
//
//  Created by menglingchao on 2021/1/29.
//

#import <UIKit/UIKit.h>
#import "MLCShapeLayerView.h"

/**环形视图*/
@interface MLCAnnularView : UIView

/**环背景*/
@property (nonatomic, strong) MLCShapeLayerView *lineBackground;
/**环*/
@property (nonatomic, strong) MLCShapeLayerView *line;


- (instancetype)initWithStrokeThickness:(CGFloat)strokeThickness width:(CGFloat)width rounded:(BOOL)rounded;

- (instancetype)initWithStrokeThickness:(CGFloat)strokeThickness width:(CGFloat)width height:(CGFloat)height rounded:(BOOL)rounded;

@end
