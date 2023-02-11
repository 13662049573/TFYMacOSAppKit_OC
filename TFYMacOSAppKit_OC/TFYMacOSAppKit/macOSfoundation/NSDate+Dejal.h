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
@property (nonatomic, readonly) BOOL tfy_isToday;

@property (nonatomic, readonly) NSInteger tfy_second;
@property (nonatomic, readonly) NSInteger tfy_minute;
@property (nonatomic, readonly) NSInteger tfy_hour;
@property (nonatomic, readonly) NSInteger tfy_weekday;
@property (nonatomic, readonly) NSInteger tfy_dayOfYear;
@property (nonatomic, readonly) NSInteger tfy_day;
@property (nonatomic, readonly) NSInteger tfy_month;
@property (nonatomic, readonly) NSInteger tfy_year;

+ (NSCalendar *)tfy_gregorianCalendar;

+ (NSDate *)tfy_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day localTimeZone:(BOOL)localTimeZone;
+ (NSDate *)tfy_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second localTimeZone:(BOOL)localTimeZone;

+ (NSDate *)tfy_dateWithString:(NSString *)string;
+ (NSDate *)tfy_dateWithString:(NSString *)string format:(NSString *)format;

- (NSString *)tfy_stringWithFormat:(NSString *)format;

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

- (NSDate *)tfy_dateByAddingMinutes:(NSInteger)numMinutes;
- (NSDate *)tfy_dateByAddingHours:(NSInteger)numHours;
- (NSDate *)tfy_dateByAddingDays:(NSInteger)numDays;
- (NSDate *)tfy_dateByAddingWeeks:(NSInteger)numWeeks;
- (NSDate *)tfy_dateByAddingMonths:(NSInteger)numMonths;
- (NSDate *)tfy_dateByAddingYears:(NSInteger)numYears;

- (NSInteger)tfy_differenceInMinutesTo:(NSDate *)toDate;
- (NSInteger)tfy_differenceInHoursTo:(NSDate *)toDate;
- (NSInteger)tfy_differenceInDaysTo:(NSDate *)toDate;
- (NSInteger)tfy_differenceInWeeksTo:(NSDate *)toDate;
- (NSInteger)tfy_differenceInMonthsTo:(NSDate *)toDate;
- (NSInteger)tfy_differenceInYearsTo:(NSDate *)toDate;

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

