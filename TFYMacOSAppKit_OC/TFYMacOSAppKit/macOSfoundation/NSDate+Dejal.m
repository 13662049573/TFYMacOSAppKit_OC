//
//  NSDate+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSDate+Dejal.h"
#import "NSString+Dejal.h"


@implementation NSDate (Dejal)

- (NSUInteger)tfy_day {
    return [NSDate tfy_day:self];
}

- (NSUInteger)tfy_month {
    return [NSDate tfy_month:self];
}

- (NSUInteger)tfy_year {
    return [NSDate tfy_year:self];
}

- (NSUInteger)tfy_hour {
    return [NSDate tfy_hour:self];
}

- (NSUInteger)tfy_minute {
    return [NSDate tfy_minute:self];
}

- (NSUInteger)tfy_second {
    return [NSDate tfy_second:self];
}

+ (NSUInteger)tfy_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)tfy_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)tfy_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)tfy_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)tfy_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)tfy_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)tfy_daysInYear {
    return [NSDate tfy_daysInYear:self];
}

+ (NSUInteger)tfy_daysInYear:(NSDate *)date {
    return [self tfy_isLeapYear:date] ? 366 : 365;
}

- (BOOL)tfy_isLeapYear {
    return [NSDate tfy_isLeapYear:self];
}

+ (BOOL)tfy_isLeapYear:(NSDate *)date {
    NSUInteger year = [date tfy_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)tfy_formatYMD {
    return [NSDate tfy_formatYMD:self];
}

+ (NSString *)tfy_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",(unsigned long)[date tfy_year],(unsigned long)[date tfy_month], (unsigned long)[date tfy_day]];
}

- (NSUInteger)tfy_weeksOfMonth {
    return [NSDate tfy_weeksOfMonth:self];
}

+ (NSUInteger)tfy_weeksOfMonth:(NSDate *)date {
    return [[date tfy_lastdayOfMonth] tfy_weekOfYear] - [[date tfy_begindayOfMonth] tfy_weekOfYear] + 1;
}

- (NSUInteger)tfy_weekOfYear {
    return [NSDate tfy_weekOfYear:self];
}

+ (NSUInteger)tfy_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date tfy_year];
    
    NSDate *lastdate = [date tfy_lastdayOfMonth];
    
    for (i = 1;[[lastdate tfy_dateAfterDay:-7 * i] tfy_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)tfy_dateAfterDay:(NSUInteger)day {
    return [NSDate tfy_dateAfterDate:self day:day];
}

+ (NSDate *)tfy_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)tfy_dateAfterMonth:(NSUInteger)month {
    return [NSDate tfy_dateAfterDate:self month:month];
}

+ (NSDate *)tfy_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)tfy_begindayOfMonth {
    return [NSDate tfy_begindayOfMonth:self];
}

+ (NSDate *)tfy_begindayOfMonth:(NSDate *)date {
    return [self tfy_dateAfterDate:date day:-[date tfy_day] + 1];
}

- (NSDate *)tfy_lastdayOfMonth {
    return [NSDate tfy_lastdayOfMonth:self];
}

+ (NSDate *)tfy_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self tfy_begindayOfMonth:date];
    return [[lastDate tfy_dateAfterMonth:1] tfy_dateAfterDay:-1];
}

- (NSUInteger)tfy_daysAgo {
    return [NSDate tfy_daysAgo:self];
}

+ (NSUInteger)tfy_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)tfy_weekday {
    return [NSDate tfy_weekday:self];
}

+ (NSInteger)tfy_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)tfy_dayFromWeekday {
    return [NSDate tfy_dayFromWeekday:self];
}

+ (NSString *)tfy_dayFromWeekday:(NSDate *)date {
    switch([date tfy_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)tfy_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)tfy_isToday {
    return [self tfy_isSameDay:[NSDate date]];
}

+ (NSString *)tfy_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date tfy_stringWithFormat:format];
}

/**
 以指定格式的字符串形式返回接收器。
*/

- (NSString *)tfy_stringWithFormat:(NSString *)format;
{
    NSDateFormatter *formatter = [NSDateFormatter new];

    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    
    if (format)
        [formatter setDateFormat:format];

    return [formatter stringFromDate:self];
}

- (NSUInteger)tfy_daysInMonth:(NSUInteger)month {
    return [NSDate tfy_daysInMonth:self month:month];
}

+ (NSUInteger)tfy_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date tfy_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)tfy_daysInMonth {
    return [NSDate tfy_daysInMonth:self];
}

+ (NSUInteger)tfy_daysInMonth:(NSDate *)date {
    return [self tfy_daysInMonth:date month:[date tfy_month]];
}

- (NSString *)tfy_timeInfo {
    return [NSDate tfy_timeInfoWithDate:self];
}

+ (NSString *)tfy_timeInfoWithDate:(NSDate *)date {
    return [self tfy_timeInfoWithDateString:[self tfy_stringWithDate:date format:[self tfy_ymdHmsFormat]]];
}

+ (NSString *)tfy_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self tfy_dateWithString:dateString format:[self tfy_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate tfy_month] - [date tfy_month]);
    int year = (int)([curDate tfy_year] - [date tfy_year]);
    int day = (int)([curDate tfy_day] - [date tfy_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate tfy_month] == 1 && [date tfy_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self tfy_daysInMonth:date month:[date tfy_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate tfy_day] + (totalDays - (int)[date tfy_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate tfy_month];
            int preMonth = (int)[date tfy_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)tfy_ymdFormat {
    return [NSDate tfy_ymdFormat];
}

- (NSString *)tfy_hmsFormat {
    return [NSDate tfy_hmsFormat];
}

- (NSString *)tfy_ymdHmsFormat {
    return [NSDate tfy_ymdHmsFormat];
}

+ (NSString *)tfy_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)tfy_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)tfy_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self tfy_ymdFormat], [self tfy_hmsFormat]];
}

- (NSDate *)tfy_offsetYears:(int)numYears {
    return [NSDate tfy_offsetYears:numYears fromDate:self];
}

+ (NSDate *)tfy_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)tfy_offsetMonths:(int)numMonths {
    return [NSDate tfy_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)tfy_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)tfy_offsetDays:(int)numDays {
    return [NSDate tfy_offsetDays:numDays fromDate:self];
}

+ (NSDate *)tfy_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)tfy_offsetHours:(int)hours {
    return [NSDate tfy_offsetHours:hours fromDate:self];
}

+ (NSDate *)tfy_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)tfy_dateByAddingYears:(NSInteger)years
{
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}
- (NSDate *)tfy_dateByMinusYears:(NSInteger)years
{
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:-years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}
- (NSDate *)tfy_dateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}
- (NSDate *)tfy_dateByMinusMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:-months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}
- (NSDate *)tfy_dateByAddingWeeks:(NSInteger)weeks
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}
- (NSDate *)tfy_dateByMinusWeeks:(NSInteger)weeks
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:-weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}
- (NSDate *)tfy_dateByAddingDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *)tfy_dateByMinusDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] - 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *)tfy_dateByAddingHours:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 3600 * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *)tfy_dateByMinusHours:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] - 3600 * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *)tfy_dateByAddingMinutes:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 60 * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *)tfy_dateByMinusMinutes:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] - 60 * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *)tfy_dateByAddingSeconds:(NSInteger)seconds
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
- (NSDate *)tfy_dateByMinusSeconds:(NSInteger)seconds
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] - seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSInteger)tfy_yearsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitYear
                                               fromDate:fromDate toDate:toDate options:0];
    return [difference year];
}

+ (NSInteger)tfy_monthsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitMonth
                                               fromDate:fromDate toDate:toDate options:0];
    return [difference month];
}
+ (NSInteger)tfy_daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    
    return [difference day];
}
+ (NSInteger)tfy_minutesBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitMinute
                startDate:&fromDate
                 interval:NULL
                  forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitMinute
                startDate:&toDate
                 interval:NULL
                  forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitMinute
                                               fromDate:fromDate
                                                 toDate:toDate
                                                options:0];
    
    return [difference minute];
}

+ (NSInteger)tfy_secondsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitSecond
                startDate:&fromDate
                 interval:NULL
                  forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitSecond
                startDate:&toDate
                 interval:NULL
                  forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitSecond
                                               fromDate:fromDate
                                                 toDate:toDate
                                                options:0];
    
    return [difference second];
}


- (NSInteger)tfy_dayNumOfCurrentMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

- (NSDate *)tfy_dateWithMonthBegainDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:self];
    return firstDay;
}

- (NSDate *)tfy_dateWithWeekBegainDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSInteger weekday = [dateComponents weekday];
    NSInteger firstDiff;
    if (weekday == 1)
    {
        firstDiff = -6;
    }
    else
    {
        firstDiff =  - weekday + 2;
    }
    NSInteger day = [dateComponents day];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    [firstComponents setDay:day+firstDiff];
    NSDate *firstDay = [calendar dateFromComponents:firstComponents];
    
    return firstDay;
}

- (BOOL)tfy_isSameDayToDate:(NSDate *)date
{
    if (!date) return NO;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:self];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}
/// 获取年
+ (NSInteger)tfy_year_str:(NSString *)dateStr Format:(NSString *)Format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:Format];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *startDate = [dateFormatter dateFromString:dateStr];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    return components.year;
}
//计算一个月的总天数
+ (NSInteger)tfy_daysInthisMonth:(NSDate *)date
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return totaldaysInMonth.length;
}

/// 获取月
+ (NSInteger)tfy_month_str:(NSString *)dateStr Format:(NSString *)Format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:Format];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *startDate = [dateFormatter dateFromString:dateStr];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    return components.month;
}


/// 获取星期
+ (NSInteger)tfy_week:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *startDate = [dateFormatter dateFromString:dateStr];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:startDate];
    return components.weekday - 1;
}

/// 获取星期 中文
+ (NSString *)tfy_getWeekFromDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:date];
    NSInteger week = components.weekday - 1;
    NSDictionary *weekDic = @{@"0":@"日",@"1":@"一",@"2":@"二",@"3":@"三",@"4":@"四",@"5":@"五",@"6":@"六"};
    NSString *key = [NSString stringWithFormat:@"%ld",(long)week];
    return weekDic[key];
}

/// 获取星期中文
+ (NSString *)tfy_getChineseWeekFrom:(NSString *)dateStr {
    NSDictionary *weekDic = @{@"0":@"周日",@"1":@"周一",@"2":@"周二",@"3":@"周三",@"4":@"周四",@"5":@"周五",@"6":@"周六"};
    NSInteger week = [NSDate tfy_week:dateStr];
    NSString *weekKey = [NSString stringWithFormat:@"%ld",(long)week];
    return weekDic[weekKey];
}

/// 获取日
+ (NSInteger)tfy_day_str:(NSString *)dateStr Format:(NSString *)Format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:Format];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *startDate = [dateFormatter dateFromString:dateStr];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    return components.day;
}

/// 获取月共有多少天
+ (NSInteger)tfy_daysInMonth_str:(NSString *)dateStr {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[NSDate tfy_timeIntervalFromDateString:dateStr] / 1000];
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

//获取当前日期
+ (NSString *)tfy_currentDay {
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString * time = [formater stringFromDate:date];
    return time;
}

//获取当前小时
+ (NSString *)tfy_currentHour {
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    NSDate *curDate = [NSDate date];
    [formater setDateFormat:@"H:mm"];
    NSString * curTime = [formater stringFromDate:curDate];
    return curTime;
}

//找到两个月后的第一天~ 然后通过减一天来找到下个月的最后一天，所以，下月最后一天
+ (NSString *)tfy_nextMonthLastDay {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    //设置日为1号
    dateComponents.day =1;
    //设置月份为后延2个月
    dateComponents.month +=2;
    NSDate * endDayOfNextMonth = [calendar dateFromComponents:dateComponents];
    //两个月后的1号往前推1天，即为下个月最后一天
    endDayOfNextMonth = [endDayOfNextMonth dateByAddingTimeInterval:-1];
    //格式化输出
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString * curTime = [formater stringFromDate:endDayOfNextMonth];
    return curTime;
}

///判断是否是今天
+ (BOOL)tfy_isToday:(NSString *)dateStr {
    BOOL isDay = NO;
    NSString *day = [NSDate tfy_timeStringWithInterval:[NSDate date].timeIntervalSince1970];
    if ([dateStr isEqualToString:day]) {
        isDay = YES;
    }
    return isDay;
}

///判断是否是明天
+ (BOOL)tfy_isTomorrow:(NSString *)dateStr {
    BOOL isDay = NO;
    NSTimeInterval time = [NSDate date].timeIntervalSince1970 + 24 * 3600;
    NSString *day = [NSDate tfy_timeStringWithInterval:time];
    if ([dateStr isEqualToString:day]) {
        isDay = YES;
    }
    return isDay;
}

///判断是否是后天
+ (BOOL)tfy_isAfterTomorrow:(NSString *)dateStr {
    BOOL isDay = NO;
    NSTimeInterval time = [NSDate date].timeIntervalSince1970 + 48 * 3600;
    NSString *day = [NSDate tfy_timeStringWithInterval:time];
    if ([dateStr isEqualToString:day]) {
        isDay = YES;
    }
    return isDay;
}

/// 判断是否是过去的时间
+ (BOOL)tfy_isHistoryTime:(NSString *)dateStr {
    BOOL activity = NO;
    NSTimeInterval timeInterval = [NSDate tfy_timeIntervalFromDateString: dateStr];
    NSTimeInterval currentInterval = [NSDate tfy_timeIntervalFromDateString:[NSDate tfy_currentDay]];
    if (timeInterval < currentInterval) {
        activity = YES;
    }
    return activity;
}

/// 从时间戳获取具体时间 格式:6:00
+ (NSString *)tfy_hourStringWithInterval:(NSTimeInterval)timeInterval {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H:mm"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

/// 从时间戳获取具体小时 格式:6
+ (NSString *)tfy_hourTagWithInterval:(NSTimeInterval)timeInterval {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/// 从毫秒级时间戳获取具体小时 格式:600
+ (NSString *)tfy_hourNumberWithInterval:(NSTimeInterval)timeInterval {
    NSString *hourStr = [self tfy_hourStringWithInterval:timeInterval / 1000];
    NSString *hourNumber = [hourStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    return hourNumber;
}

/// 从时间戳获取具体日期 格式:2018-03-05
+ (NSString *)tfy_timeStringWithInterval:(NSTimeInterval)timeInterval {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/// 根据具体日期获取时间戳(毫秒)
+ (NSTimeInterval)tfy_timeIntervalFromDateString:(NSString *)dateStr {
    //要精确到毫秒2018-01-01 与 2018-01-01 00:00 都要转换成2018-01-01 00:00:00
    if (dateStr.length == 10) {
        dateStr = [dateStr stringByAppendingString:@" 00:00:00"];
    } else if (dateStr.length == 16) {
        dateStr = [dateStr stringByAppendingString:@":00"];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSTimeInterval interval = [date timeIntervalSince1970] * 1000;
    return interval;
}

/// 获取当前天的后几天的星期
+ (NSString *)tfy_getWeekAfterDay:(NSInteger)day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:[NSDate date]];
    NSInteger currentWeek = components.weekday - 1;
    NSDictionary *weekDic = @{@"0":@"日",@"1":@"一",@"2":@"二",@"3":@"三",@"4":@"四",@"5":@"五",@"6":@"六"};
    NSInteger week = currentWeek + day;
    if (week >= 7) {
        week -= 7;
    }
    NSString *key = [NSString stringWithFormat:@"%ld",(long)week];
    return weekDic[key];
}


/// 获取当前天的后几天的日
+ (NSString *)tfy_getDayAfterDay:(NSInteger)day {
    NSTimeInterval time = [NSDate date].timeIntervalSince1970 + 24 * 3600 * day;
    NSString *date = [NSDate tfy_timeStringWithInterval:time];
    NSInteger dayNum = [self tfy_day_str:date Format:NSDate.tfy_ymdFormat];
    NSString *dayStr = [NSString stringWithFormat:@"%ld",(long)dayNum];
    return dayStr;
}

/// 获取当前月的后几月
+ (NSString *)tfy_getMonthAfterMonth:(NSInteger)Month {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:Month];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
    return dateStr;
}

//时间转时间戳的方法:
+ (NSInteger)tfy_timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd HH:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}
///时间戳转时间
+ (NSString *)tfy_timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
///将字符串转成NSDate类型
+ (NSDate *)tfy_dateFromString:(NSString *)dateString {
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:dateString];
    //inputDate或出现相差八小时问题，下面是解决相差八小时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: inputDate];
    NSDate *localeDate = [inputDate dateByAddingTimeInterval:interval];
    return localeDate;
}

+ (NSInteger)tfy_getNowTimestampFormatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    return timeSp;
}

/// 根据出生日期返回年龄的方法
+ (int)dateToOld:(NSDate *)bornDate {
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:bornDate];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return age;
}

/// 根据出生日期返回详细的年龄(精确到天)
+ (NSString *)dateToDetailOld:(NSDate *)bornDate {
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //创建日历(格里高利历)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置component的组成部分
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    //按照组成部分格式计算出生日期与现在时间的时间间隔
    NSDateComponents *date = [calendar components:unitFlags fromDate:bornDate toDate:currentDate options:0];

    //判断年龄大小,以确定返回格式
    if( [date year] > 0)
    {
        return [NSString stringWithFormat:(@"%ld岁%ld月%ld天"),(long)[date year],(long)[date month],(long)[date day]];
        
    }
    else if([date month] >0)
    {
        return [NSString stringWithFormat:(@"%ld月%ld天"),(long)[date month],(long)[date day]];
        
    }
    else if([date day]>0)
    {
        return [NSString stringWithFormat:(@"%ld天"),(long)[date day]];
        
    }
    else {
        return @"0天";
    }
}


/**
 方法返回公历，必要时创建它。
 */

+ (NSCalendar *)tfy_gregorianCalendar;
{
    static id tfy_gregorianCalendar = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
                  {
                      tfy_gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                  });
    
    return tfy_gregorianCalendar;
}

- (NSCalendar *)tfy_gregorianCalendar;
{
    return [[self class] tfy_gregorianCalendar];
}

/**
 使用公历返回指定年、月和日的日期表示形式，时间设置为午夜。如果localTimeZone为YES，则使用当前本地时区，否则使用GMT。
*/

+ (NSDate *)tfy_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day localTimeZone:(BOOL)localTimeZone;
{
    return [self tfy_dateWithYear:year month:month day:day hour:0 minute:0 second:0 localTimeZone:localTimeZone];
}

/**
 使用公历返回指定的年、月、日、时、分和秒的日期表示形式。如果localTimeZone为YES，则使用当前本地时区，否则使用GMT。
*/

+ (NSDate *)tfy_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second localTimeZone:(BOOL)localTimeZone;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    if (localTimeZone)
        [components setTimeZone:[NSTimeZone defaultTimeZone]];
    else
        [components setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    
    return [gregorian dateFromComponents:components];
}

/**
 给定一个日期为字符串，返回一个新的日期表示，如果字符串为nil或空，则返回nil。
*/

+ (NSDate *)tfy_dateWithString:(NSString *)string;
{
    if (!string.length)
        return nil;

    NSDateFormatter *formatter = [NSDateFormatter new];
    NSDate *date = [formatter dateFromString:string];
    
    return date;
}

/**
 给定一个日期作为字符串，加上一个日期格式字符串，返回一个新的日期表示形式，如果字符串为nil或空，则返回nil。
*/

+ (NSDate *)tfy_dateWithString:(NSString *)string format:(NSString *)format;
{
    if (!string.length)
        return nil;
    
    NSDateFormatter *formatter = [NSDateFormatter new];

    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
	
    if (format)
        [formatter setDateFormat:format];

    NSDate *date = [formatter dateFromString:string];
    
    return date;
}

/**
 返回RFC3339标准互联网日期格式的日期格式化程序。
*/

+ (NSDateFormatter *)tfy_internetDateFormatter;
{
    static NSDateFormatter *sRFC3339DateFormatter = nil;
    
    if (!sRFC3339DateFormatter)
    {
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        sRFC3339DateFormatter = [NSDateFormatter new];
        
        [sRFC3339DateFormatter setLocale:enUSPOSIXLocale];
        [sRFC3339DateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];  //@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [sRFC3339DateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [sRFC3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    
    return sRFC3339DateFormatter;
}

/**
 给定一个日期作为JSON格式的字符串(例如。"2008-05-13T17:54:02Z"或"/Date(1210701242578)/")，返回一个日期表示形式。对新格式字符串进行基本清理。如果字符串为空或不是字符串，则返回nil。
*/

+ (NSDate *)tfy_dateWithJSONString:(NSString *)jsonDate;
{
    return [self tfy_dateWithJSONString:jsonDate allowPlaceholder:NO];
}

/**
 给定一个日期作为JSON格式的字符串(例如。"2008-05-13T17:54:02Z"或"/Date(1210701242578)/")，返回一个日期表示形式。对新格式字符串进行基本清理。如果字符串为空或不是字符串，则返回nil。
*/

+ (NSDate *)tfy_dateWithJSONString:(NSString *)jsonDate allowPlaceholder:(BOOL)allowPlaceholder;
{
    if (![jsonDate isKindOfClass:[NSString class]] || !jsonDate.length)
        return nil;
    else if (!allowPlaceholder && ([jsonDate hasPrefix:@"1899-12-30"] || [jsonDate hasPrefix:@"0001-01-01"]))
        return nil;
    else if ([jsonDate hasPrefix:@"/Date("])
    {
        NSString *string = [[jsonDate tfy_substringFromString:@"/Date("] tfy_substringToString:@")/"];
        NSTimeInterval interval = [string longLongValue] / 1000.0;
        
        return [NSDate dateWithTimeIntervalSince1970:interval];
    }
    else
    {
        BOOL isLocalTime = ![jsonDate hasSuffix:@"Z"];
        NSRange position = [jsonDate rangeOfString:@"."];
        
        if (position.location != NSNotFound)
            jsonDate = [jsonDate substringToIndex:position.location];
        
        if (![jsonDate hasSuffix:@"Z"])
            jsonDate = [jsonDate stringByAppendingString:@"Z"];
        
        NSDate *result = [[self tfy_internetDateFormatter] dateFromString:jsonDate];
        
        if (isLocalTime)
            result = [result dateByAddingTimeInterval:[self tfy_localTimeOffset]];
        
        return result;
    }
}

/**
 返回表示为新型json格式日期字符串的接收者。
*/

- (NSString *)tfy_JSONStringValue;
{
    return [[NSDate tfy_internetDateFormatter] stringFromDate:self];
}

/**
 返回以老式json格式日期字符串表示的接收器。
*/

- (NSString *)tfy_oldStyleJSONStringValue;
{
    NSTimeInterval timeZoneOffset = [NSDate tfy_localTimeOffset];
    NSTimeInterval base = [self timeIntervalSince1970] + timeZoneOffset;
    NSTimeInterval interval = base * 1000.0;
    NSString *string = [NSString stringWithFormat:@"/Date(%.0f)/", interval];
    
    return string;
}

/**
 返回要添加到本地日期以将其转换为UTC日期的间隔，即允许当前时区和夏令时。
*/

+ (NSTimeInterval)tfy_localTimeOffset;
{
    return -([[NSTimeZone defaultTimeZone] secondsFromGMT] - [[NSTimeZone defaultTimeZone] daylightSavingTimeOffset]);
}

/**
 返回不带时间组件的当前日期。
*/

+ (NSDate *)tfy_dateWithoutTime;
{
    return [[NSDate date] tfy_dateAsDateWithoutTime];
}

/**
 返回没有时间组件的接收器(使用中午作为占位符时间，因此它是dst防的)。
*/

- (NSDate *)tfy_dateAsDateWithoutTime;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    NSDate *midnight = [calendar dateFromComponents:components];
    
    components = [NSDateComponents new];
    [components setHour:12];
    
    return [calendar dateByAddingComponents:components toDate:midnight options:0];
}

/**
 如果接收者有时间组件，则返回YES;如果接收者只有日期，则返回NO。注意:如果时间恰好是午夜，它将返回NO。
*/

- (BOOL)tfy_includesTime;
{
    return ![self isEqualToDate:[self tfy_dateAsDateWithoutTime]];
}

/**
 确定给定日期是否在当前日期之前到之后的特定天数内。时间会被忽略，例如daysBefore传递-1表示昨天的任何时间。
 */

- (BOOL)tfy_isBetweenDaysBefore:(NSInteger)daysBefore daysAfter:(NSInteger)daysAfter;
{
    NSInteger diff = [[NSDate tfy_dateWithoutTime] tfy_differenceInDaysTo:[self tfy_dateAsDateWithoutTime]];
    BOOL want = NO;
    
    if (diff < 0)
        want = -diff <= daysBefore;
    else
        want = diff <= daysAfter;
    
    return want;
}

/**
 返回接收者与指定日期之间的分钟数。
*/

- (NSInteger)tfy_differenceInMinutesTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitMinute fromDate:self toDate:toDate options:0];
    NSInteger minutes = [components minute];
    
    return minutes;
}

/**
 返回接收者与指定日期之间的小时数。
*/

- (NSInteger)tfy_differenceInHoursTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitHour fromDate:self toDate:toDate options:0];
    NSInteger hours = [components hour];
    
    return hours;
}

/**
 返回接收者与指定日期之间的天数。
*/

- (NSInteger)tfy_differenceInDaysTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:self toDate:toDate options:0];
    NSInteger days = [components day];
    
    return days;
}

/**
 返回接收者与指定日期之间的周数。
*/

- (NSInteger)tfy_differenceInWeeksTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekOfYear fromDate:self toDate:toDate options:0];
    NSInteger weeks = [components weekOfYear];
    
    return weeks;
}

/**
 返回接收者与指定日期之间的月数。
*/

- (NSInteger)tfy_differenceInMonthsTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth fromDate:self toDate:toDate options:0];
    NSInteger months = [components month];
    
    return months;
}

/**
 返回接收者与指定日期之间的年数。
*/

- (NSInteger)tfy_differenceInYearsTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self toDate:toDate options:0];
    NSInteger years = [components year];
    
    return years;
}


/**
 为接收者返回一年中的日期。注意，这与每月的第一天不同。
 */

- (NSInteger)tfy_dayOfYear;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger dayOfYear = [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self];
    
    return dayOfYear;
}

/**
 为接收者返回请求的日期组件。请参见上面的-weekday等方便方法。
 */

- (NSDateComponents *)tfy_components:(NSCalendarUnit)unitFlags;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar components:unitFlags fromDate:self];
}

/**
 给定NSDate中的时间，返回接收方的时间，而不是接收方的时间。如果接收者的日期不包括时间，而时间不包括日期，则很有用。
*/

- (NSDate *)tfy_dateWithTime:(NSDate *)time;
{
    NSDate *onlyDate = [self tfy_dateAsDateWithoutTime];
    NSDate *timeBase = [time tfy_dateAsDateWithoutTime];
    NSTimeInterval interval = [time timeIntervalSinceDate:timeBase];
    
    return [onlyDate dateByAddingTimeInterval:interval];
}

/**
 返回与最近的分钟增量对齐的接收器。例如，将15传递给一个时间为15:03的日期，将时间对齐为15:00，或者将09:40对齐为09:45。
 */

- (NSDate *)tfy_dateByAligningToMinuteIncrement:(NSInteger)minuteIncrement;
{
    if (minuteIncrement <= 0)
    {
        NSDateComponents *components = [self tfy_components:NSCalendarUnitHour];
        
        return [[NSCalendar currentCalendar] dateBySettingHour:components.hour minute:0 second:0 ofDate:self options:0];
    }
    
    NSInteger incrementSeconds = minuteIncrement * 60;
    NSInteger referenceSeconds = [self timeIntervalSinceReferenceDate];
    NSInteger remainingSeconds = referenceSeconds % incrementSeconds;
    NSInteger roundedToMinuteIncrement = referenceSeconds - remainingSeconds;
    
    if (remainingSeconds > incrementSeconds / 2)
    {
        roundedToMinuteIncrement = referenceSeconds + (incrementSeconds - remainingSeconds);
    }
    
    return [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)roundedToMinuteIncrement];
}

/**
 以短格式的字符串形式返回接收器。
*/

- (NSString *)tfy_formattedShortDateString;
{
    return [self tfy_formattedStringUsingDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

/**
 以长格式的字符串形式返回接收器。
*/

- (NSString *)tfy_formattedDateString;
{
    return [self tfy_formattedStringUsingDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
}

/**
 将接收器作为具有指定日期和时间样式的字符串返回。
*/

- (NSString *)tfy_formattedStringUsingDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
{
    return [self tfy_formattedStringUsingDateStyle:dateStyle timeStyle:timeStyle allowRelative:NO];
}

/**
 将接收者作为具有指定日期和时间样式的字符串返回，可选地使用相对日期(例如。“昨天”)。
 */

- (NSString *)tfy_formattedStringUsingDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle allowRelative:(BOOL)allowRelative;
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    formatter.doesRelativeDateFormatting = allowRelative;
    
    return [formatter stringFromDate:self];
}

/**
 以相对时间的字符串形式返回接收器，例如。"5 minutes"，可选后缀，例如。“9个月前”。如果接收者是遥远的过去或未来，则使用默认值。
 */

- (NSString *)tfy_relativeStringWithStyle:(NSDateComponentsFormatterUnitsStyle)unitsStyle maximumUnits:(NSInteger)maximumUnits keepZero:(BOOL)keepZero defaultValue:(NSString *)defaultValue;
{
    NSTimeInterval timeInterval = fabs([self timeIntervalSinceNow]);
    
    return [[self class] tfy_relativeStringForTimeInterval:timeInterval style:unitsStyle maximumUnits:maximumUnits keepZero:keepZero defaultValue:defaultValue];
}

/**
 以相对时间的字符串形式返回接收器，例如。"5 minutes"，可选后缀，例如。“9个月前”。如果接收者是遥远的过去或未来，则使用默认值。
 */

+ (NSString *)tfy_relativeStringForTimeInterval:(NSTimeInterval)timeInterval style:(NSDateComponentsFormatterUnitsStyle)unitsStyle maximumUnits:(NSInteger)maximumUnits keepZero:(BOOL)keepZero defaultValue:(NSString *)defaultValue;
{
    // If more than 10 years, assume distant past or future:
    if (fabs(timeInterval) > 60 * 60 * 24 * 365 * 10)
    {
        return defaultValue;
    }
    
    NSDateComponentsFormatter *formatter = [NSDateComponentsFormatter new];
    
    formatter.unitsStyle = unitsStyle;
    formatter.maximumUnitCount = maximumUnits;
    
    if (keepZero)
    {
        formatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDropLeading | NSDateComponentsFormatterZeroFormattingBehaviorDropMiddle;
    }
    else
    {
        formatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDropAll;
    }
    
    NSString *result = [formatter stringFromTimeInterval:timeInterval];
    
    // Workaround for bug; Apple Feedback FB8881141:
    if ([result hasPrefix:@"0"] && timeInterval < 24 * 60 * 60)
    {
        formatter.allowedUnits = NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour;
        
        result = [formatter stringFromTimeInterval:timeInterval];
    }
    
    return result;
}

/**
 从接收方返回该月的开始日期，并偏移指定的量。例如-3表示三个月前，oe 6表示六个月后。
*/

- (NSDate *)tfy_dateOfMonthStartWithOffset:(NSInteger)monthOffset;
{
    NSDate *beginningOfMonth = nil;
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&beginningOfMonth interval:NULL forDate:self];
    NSDateComponents *month = [NSDateComponents new];
    [month setMonth:monthOffset];
    NSDate *monthStartDateWithOffset = [[NSCalendar currentCalendar] dateByAddingComponents:month toDate:beginningOfMonth options:0];
    
    return monthStartDateWithOffset;
}

/**
 返回来自接收者的月底日期，偏移量为指定的值。
*/

- (NSDate *)tfy_dateOfMonthEndWithOffset:(NSInteger)monthOffset;
{
    NSDate *beginningOfMonth = nil;
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&beginningOfMonth interval:NULL forDate:self];
    
    // 在当月月初加上1个月+月的偏移量:
    NSDateComponents *oneMonth = [NSDateComponents new];
    [oneMonth setMonth:(1 + monthOffset)];
    NSDate *beginningOfNextMonthWithOffset = [[NSCalendar currentCalendar] dateByAddingComponents:oneMonth toDate:beginningOfMonth options:0];
    
    // 从下个月的开始减去1秒，就得到了这个月的结束:
    NSDateComponents *negativeOneSecond = [NSDateComponents new];
    [negativeOneSecond setSecond:-1]; 
    NSDate *monthEndDateWithOffset = [[NSCalendar currentCalendar] dateByAddingComponents:negativeOneSecond toDate:beginningOfNextMonthWithOffset options:0];
    
    return monthEndDateWithOffset;
}

// Note: see also -formattedStringUsingDateStyle:timeStyle:, equivalent to a -descriptionWithDateFormat:timeFormat: method.

/**
 返回使用用户首选的短日期和时间格式表示为字符串的接收者。这个方法兼容NSDate和NSCalendarDate。
*/

- (NSString *)tfy_descriptionWithShortDateTime;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    return [dateFormatter stringFromDate:self];
}

/**
 返回使用用户首选短日期格式表示为字符串的接收者。这个方法兼容NSDate和NSCalendarDate。
*/

- (NSString *)tfy_descriptionWithShortDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    return [dateFormatter stringFromDate:self];
}

/**
 返回使用用户首选的短时间格式表示为字符串的接收者。这个方法兼容NSDate和NSCalendarDate。
*/

- (NSString *)tfy_descriptionWithTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    return [dateFormatter stringFromDate:self];
}

@end

