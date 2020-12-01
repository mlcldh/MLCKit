//
//  NSDate+MLCKit.m
//  MLCKit
//
//  Created by menglingchao on 2019/10/28.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "NSDate+MLCKit.h"

@implementation NSDate (MLCKit)

- (NSInteger)mlc_year {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self].year;
}
- (NSInteger)mlc_month {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self].month;
}
- (NSInteger)mlc_day {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self].day;
}
- (NSDateComponents *)mlc_components:(NSCalendarUnit)unitFlags {
    return [[NSCalendar currentCalendar] components:unitFlags fromDate:self];
}
- (NSDateComponents *)mlc_chineseComponents:(NSCalendarUnit)unitFlags {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *components =  [calendar components:unitFlags fromDate:self];
    return components;
}
- (BOOL)mlc_isToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return self.mlc_day == [NSDate new].mlc_day;
}
- (BOOL)mlc_isYesterday {
    NSDate *date = [self mlc_dateByAddingDays:1];
    return [date mlc_isToday];
}
- (BOOL)mlc_isSameYearWithDate:(NSDate *)date {
    return date.mlc_year == self.mlc_year;
}
- (NSDate *)mlc_dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *)mlc_dateByAddingMonths:(NSInteger)months {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = months;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}
- (NSDate *)mlc_dateByAddingYears:(NSInteger)years {
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = years;
    return [calendar dateByAddingComponents:components toDate:self options:0];
}
- (NSString *)mlc_stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    formatter.locale = [NSLocale currentLocale];
    return [formatter stringFromDate:self];
}

@end
