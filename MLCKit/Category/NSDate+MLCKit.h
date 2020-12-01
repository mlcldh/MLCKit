//
//  NSDate+MLCKit.h
//  MLCKit
//
//  Created by menglingchao on 2019/10/28.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MLCKit)

/**当前日期在当前日历的年*/
- (NSInteger)mlc_year;
/**当前日期在当前日历的月*/
- (NSInteger)mlc_month;
/**当前日期在当前日历的日*/
- (NSInteger)mlc_day;
/**当前日期在当前日历的组成成份，成份有年、月、日、时、分、秒、星期等等*/
- (NSDateComponents *)mlc_components:(NSCalendarUnit)unitFlags;
/**当前日期在农立的组成成份，成份有年、月、日、时、分、秒、星期等等*/
- (NSDateComponents *)mlc_chineseComponents:(NSCalendarUnit)unitFlags;
/**是否是今天*/
- (BOOL)mlc_isToday;
/**是否是昨天*/
- (BOOL)mlc_isYesterday;
/**和日期date是否是同一年*/
- (BOOL)mlc_isSameYearWithDate:(NSDate *)date;
/**当前日期的基础上，增加天数，天数可以是负数*/
- (NSDate *)mlc_dateByAddingDays:(NSInteger)days;
/**当前日期的基础上，增加月数，月数可以是负数*/
- (NSDate *)mlc_dateByAddingMonths:(NSInteger)months;
/**当前日期的基础上，增加年数，年数可以是负数*/
- (NSDate *)mlc_dateByAddingYears:(NSInteger)years;
/***/
- (NSString *)mlc_stringWithFormat:(NSString *)format;

@end
