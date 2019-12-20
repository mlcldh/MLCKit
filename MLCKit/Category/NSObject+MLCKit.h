//
//  NSObject+MLCKit.h
//  Masonry
//
//  Created by menglingchao on 2019/12/20.
//

//#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MLCKit)

/***/
- (void)mlc_setValuesWithCoder:(NSCoder *)aDecoder;
/***/
- (void)mlc_encodeWithCoder:(NSCoder *)aCoder;

@end

//NS_ASSUME_NONNULL_END
