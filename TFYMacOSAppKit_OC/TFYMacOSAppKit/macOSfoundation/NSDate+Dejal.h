//
//  NSDate+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

@import Foundation;


@interface NSDate (Dejal)

@property (nonatomic, readonly) BOOL tfy_includesTime;
@property (nonatomic, readonly) NSInteger tfy_dayOfYear;

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)tfy_day;
- (NSUInteger)tfy_month;
- (NSUInteger)tfy_year;
- (NSUInteger)tfy_hour;
- (NSUInteger)tfy_minute;
- (NSUInteger)tfy_second;
+ (NSUInteger)tfy_day:(NSDate *)date;
+ (NSUInteger)tfy_month:(NSDate *)date;
+ (NSUInteger)tfy_year:(NSDate *)date;
+ (NSUInteger)tfy_hour:(NSDate *)date;
+ (NSUInteger)tfy_minute:(NSDate *)date;
+ (NSUInteger)tfy_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)tfy_daysInYear;
+ (NSUInteger)tfy_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)tfy_isLeapYear;
+ (BOOL)tfy_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)tfy_weekOfYear;
+ (NSUInteger)tfy_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)tfy_formatYMD;
+ (NSString *)tfy_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)tfy_weeksOfMonth;
+ (NSUInteger)tfy_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)tfy_begindayOfMonth;
+ (NSDate *)tfy_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)tfy_lastdayOfMonth;
+ (NSDate *)tfy_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)tfy_dateAfterDay:(NSUInteger)day;
+ (NSDate *)tfy_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)tfy_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)tfy_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)tfy_offsetYears:(int)numYears;
+ (NSDate *)tfy_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)tfy_offsetMonths:(int)numMonths;
+ (NSDate *)tfy_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)tfy_offsetDays:(int)numDays;
+ (NSDate *)tfy_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)tfy_offsetHours:(int)hours;
+ (NSDate *)tfy_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)tfy_daysAgo;
+ (NSUInteger)tfy_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 */
- (NSInteger)tfy_weekday;
+ (NSInteger)tfy_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 */
- (NSString *)tfy_dayFromWeekday;
+ (NSString *)tfy_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 */
- (BOOL)tfy_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 */
- (BOOL)tfy_isToday;
/**
 * 根据日期返回字符串
 */
+ (NSString *)tfy_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)tfy_stringWithFormat:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)tfy_daysInMonth:(NSUInteger)month;
+ (NSUInteger)tfy_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)tfy_daysInMonth;
+ (NSUInteger)tfy_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)tfy_timeInfo;
+ (NSString *)tfy_timeInfoWithDate:(NSDate *)date;
+ (NSString *)tfy_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)tfy_ymdFormat;
- (NSString *)tfy_hmsFormat;
- (NSString *)tfy_ymdHmsFormat;
+ (NSString *)tfy_ymdFormat;
+ (NSString *)tfy_hmsFormat;
+ (NSString *)tfy_ymdHmsFormat;

/**当前日期加几年*/
- (NSDate *)tfy_dateByAddingYears:(NSInteger)years;
/**当前日期减几年*/
- (NSDate *)tfy_dateByMinusYears:(NSInteger)years;
/**当前日期加几月*/
- (NSDate *)tfy_dateByAddingMonths:(NSInteger)months;
/**当前日期减几月*/
- (NSDate *)tfy_dateByMinusMonths:(NSInteger)months;
/**当前日期加几周*/
- (NSDate *)tfy_dateByAddingWeeks:(NSInteger)weeks;
/**当前日期减几周*/
- (NSDate *)tfy_dateByMinusWeeks:(NSInteger)weeks;
/**当前日期加几天*/
- (NSDate *)tfy_dateByAddingDays:(NSInteger)days;
/**当前日期减几天*/
- (NSDate *)tfy_dateByMinusDays:(NSInteger)days;
/**当前日期加几小时*/
- (NSDate *)tfy_dateByAddingHours:(NSInteger)hours;
/**当前日期减几小时*/
- (NSDate *)tfy_dateByMinusHours:(NSInteger)hours;
/**当前日期加几分钟*/
- (NSDate *)tfy_dateByAddingMinutes:(NSInteger)minutes;
/**当前日期减几分钟*/
- (NSDate *)tfy_dateByMinusMinutes:(NSInteger)minutes;
/**当前日期加几秒*/
- (NSDate *)tfy_dateByAddingSeconds:(NSInteger)seconds;
/***当前日期减几秒*/
- (NSDate *)tfy_dateByMinusSeconds:(NSInteger)seconds;

- (NSInteger)tfy_differenceInMinutesTo:(NSDate *)toDate;
- (NSInteger)tfy_differenceInHoursTo:(NSDate *)toDate;
- (NSInteger)tfy_differenceInDaysTo:(NSDate *)toDate;
- (NSInteger)tfy_differenceInWeeksTo:(NSDate *)toDate;
- (NSInteger)tfy_differenceInMonthsTo:(NSDate *)toDate;
- (NSInteger)tfy_differenceInYearsTo:(NSDate *)toDate;

/**
 *  两个日期之间相差的年数
 *  fromDateTime 开始日期
 *  toDateTime   结束日期
 *  天数
 */
+ (NSInteger)tfy_yearsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

/**
 *  两个日期之间相差的月数
 *  fromDateTime 开始日期
 *  toDateTime   结束日期
 *   天数
 */
+ (NSInteger)tfy_monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

/**
 *  两个日期之间相差的天数
 *  fromDateTime 开始日期
 *  toDateTime   结束日期
 *  天数
 */
+ (NSInteger)tfy_daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

/**
 *  两个日期之间相差的分钟
 *  fromDateTime 开始日期
 *  toDateTime   结束日期
 *  分钟
 */
+ (NSInteger)tfy_minutesBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

/**
 *  两个日期之间相差的秒数
 *  fromDateTime 开始日期
 *  toDateTime   结束日期
 *  秒数
 */
+ (NSInteger)tfy_secondsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
//日历需要的
- (NSInteger)tfy_dayNumOfCurrentMonth;

- (NSDate *)tfy_dateWithMonthBegainDate;

- (NSDate *)tfy_dateWithWeekBegainDate;

- (BOOL)tfy_isSameDayToDate:(NSDate *)date;

/// 获取年
+ (NSInteger)tfy_year_str:(NSString *)dateStr Format:(NSString *)Format;;
//计算一个月的总天数
+ (NSInteger)tfy_daysInthisMonth:(NSDate *)date;
/// 获取月
+ (NSInteger)tfy_month_str:(NSString *)dateStr Format:(NSString *)Format;;
/// 获取星期
+ (NSInteger)tfy_week:(NSString *)dateStr;
/// 获取星期 中文 日
+ (NSString *)tfy_getWeekFromDate:(NSDate *)date;
/// 获取星期 中文 周日
+ (NSString *)tfy_getChineseWeekFrom:(NSString *)dateStr;
/// 获取日
+ (NSInteger)tfy_day_str:(NSString *)dateStr Format:(NSString *)Format;;
/// 获取月共有多少天
+ (NSInteger)tfy_daysInMonth_str:(NSString *)dateStr;

/// 获取当前日期 2018-01-01
+ (NSString *)tfy_currentDay;
/// 获取当前小时 00:00
+ (NSString *)tfy_currentHour;
/// 获取下月最后一天
+ (NSString *)tfy_nextMonthLastDay;

/// 判断是否是今天
+ (BOOL)tfy_isToday:(NSString *)dateStr;
/// 判断是否是明天
+ (BOOL)tfy_isTomorrow:(NSString *)dateStr;
/// 判断是否是后天
+ (BOOL)tfy_isAfterTomorrow:(NSString *)dateStr;
/// 判断是否是过去的时间
+ (BOOL)tfy_isHistoryTime:(NSString *)dateStr;

/// 从时间戳获取具体时间 格式:6:00
+ (NSString *)tfy_hourStringWithInterval:(NSTimeInterval)timeInterval;
/// 从时间戳获取具体小时 格式:6
+ (NSString *)tfy_hourTagWithInterval:(NSTimeInterval)timeInterval;
/// 从毫秒级时间戳获取具体小时 格式:600
+ (NSString *)tfy_hourNumberWithInterval:(NSTimeInterval)timeInterval;
/// 从时间戳获取具体日期 格式:2018-03-05
+ (NSString *)tfy_timeStringWithInterval:(NSTimeInterval)timeInterval;
/// 从具体日期获取时间戳 毫秒
+ (NSTimeInterval)tfy_timeIntervalFromDateString:(NSString *)dateStr;

/// 获取当前天的后几天的星期
+ (NSString *)tfy_getWeekAfterDay:(NSInteger)day;
/// 获取当前天的后几天的日
+ (NSString *)tfy_getDayAfterDay:(NSInteger)day;
/// 获取当前月的后几月
+ (NSString *)tfy_getMonthAfterMonth:(NSInteger)Month;

///当前时间戳
+ (NSInteger)tfy_getNowTimestampFormatter:(NSString *)format;

///将字符串转成NSDate类型
+ (NSDate *)tfy_dateFromString:(NSString *)dateString;

///时间转时间戳的方法: 这里没有*1000 按照需求可以自己*
+ (NSInteger)tfy_timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

///时间戳转时间
+(NSString *)tfy_timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

/// 根据出生日期返回年龄的方法
+ (int)dateToOld:(NSDate *)bornDate;

/// 根据出生日期返回详细的年龄(精确到天)
+ (NSString *)dateToDetailOld:(NSDate *)bornDate;

+ (NSCalendar *)tfy_gregorianCalendar;

+ (NSDate *)tfy_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day localTimeZone:(BOOL)localTimeZone;
+ (NSDate *)tfy_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second localTimeZone:(BOOL)localTimeZone;

+ (NSDate *)tfy_dateWithString:(NSString *)string;
+ (NSDate *)tfy_dateWithString:(NSString *)string format:(NSString *)format;

+ (NSDateFormatter *)tfy_internetDateFormatter;

+ (NSDate *)tfy_dateWithJSONString:(NSString *)jsonDate;
+ (NSDate *)tfy_dateWithJSONString:(NSString *)jsonDate allowPlaceholder:(BOOL)allowPlaceholder;
- (NSString *)tfy_JSONStringValue;
- (NSString *)tfy_oldStyleJSONStringValue;

+ (NSTimeInterval)tfy_localTimeOffset;

+ (NSDate *)tfy_dateWithoutTime;
- (NSDate *)tfy_dateAsDateWithoutTime;

- (NSDateComponents *)tfy_components:(NSCalendarUnit)unitFlags;

- (BOOL)tfy_isBetweenDaysBefore:(NSInteger)daysBefore daysAfter:(NSInteger)daysAfter;

- (NSDate *)tfy_dateWithTime:(NSDate *)time;

- (NSDate *)tfy_dateByAligningToMinuteIncrement:(NSInteger)minuteIncrement;

- (NSString *)tfy_formattedShortDateString;
- (NSString *)tfy_formattedDateString;
- (NSString *)tfy_formattedStringUsingDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)tfy_formattedStringUsingDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle allowRelative:(BOOL)allowRelative;

- (NSString *)tfy_relativeStringWithStyle:(NSDateComponentsFormatterUnitsStyle)unitsStyle maximumUnits:(NSInteger)maximumUnits keepZero:(BOOL)keepZero defaultValue:(NSString *)defaultValue;
+ (NSString *)tfy_relativeStringForTimeInterval:(NSTimeInterval)timeInterval style:(NSDateComponentsFormatterUnitsStyle)unitsStyle maximumUnits:(NSInteger)maximumUnits keepZero:(BOOL)keepZero defaultValue:(NSString *)defaultValue;

- (NSDate *)tfy_dateOfMonthStartWithOffset:(NSInteger)monthOffset;
- (NSDate *)tfy_dateOfMonthEndWithOffset:(NSInteger)monthOffset;

- (NSString *)tfy_descriptionWithShortDateTime;
- (NSString *)tfy_descriptionWithShortDate;
- (NSString *)tfy_descriptionWithTime;

@end

