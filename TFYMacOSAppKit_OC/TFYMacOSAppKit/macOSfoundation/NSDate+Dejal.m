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
 如果接收者是今天的日期，则返回YES。
*/

- (BOOL)tfy_isToday;
{
    return ([[NSDate tfy_dateWithoutTime] isEqualToDate:[self tfy_dateAsDateWithoutTime]]);
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
 返回接收器的第二个。
 */

- (NSInteger)tfy_second;
{
    return [self tfy_components:NSCalendarUnitSecond].second;
}

/**
 返回接收者的分钟数。
 */

- (NSInteger)tfy_minute;
{
    return [self tfy_components:NSCalendarUnitMinute].minute;
}

/**
 返回接收方的时间。
 */

- (NSInteger)tfy_hour;
{
    return [self tfy_components:NSCalendarUnitHour].hour;
}

/**
 返回接收者的星期几。如果当前日历是公历，则周日= 1，周一= 2，等等。
*/

- (NSInteger)tfy_weekday;
{
    return [self tfy_components:NSCalendarUnitWeekday].weekday;
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
 返回接收者的日期。
 */

- (NSInteger)tfy_day;
{
    return [self tfy_components:NSCalendarUnitDay].day;
}

/**
 返回接收者的月份。
 */

- (NSInteger)tfy_month;
{
    return [self tfy_components:NSCalendarUnitMonth].month;
}

/**
 返回接收者的年份。
*/

- (NSInteger)tfy_year;
{
    return [self tfy_components:NSCalendarUnitYear].year;
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
 返回添加了指定分钟数的接收器。
*/

- (NSDate *)tfy_dateByAddingMinutes:(NSInteger)numMinutes;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setMinute:numMinutes];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 返回添加了指定小时数的接收器。
*/

- (NSDate *)tfy_dateByAddingHours:(NSInteger)numHours;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setHour:numHours];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 返回添加了指定天数的接收器。
*/

- (NSDate *)tfy_dateByAddingDays:(NSInteger)numDays;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setDay:numDays];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 返回添加了指定周数的接收器。
*/

- (NSDate *)tfy_dateByAddingWeeks:(NSInteger)numWeeks;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setWeekOfYear:numWeeks];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 返回添加了指定月数的接收器。
*/

- (NSDate *)tfy_dateByAddingMonths:(NSInteger)numMonths;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setMonth:numMonths];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 返回添加了指定年数的接收器。
*/

- (NSDate *)tfy_dateByAddingYears:(NSInteger)numYears;
{
    NSCalendar *gregorian = [self tfy_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setYear:numYears];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
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

