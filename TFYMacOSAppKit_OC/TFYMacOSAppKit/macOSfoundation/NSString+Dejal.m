//
//  NSString+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSString+Dejal.h"
#import "NSArray+Dejal.h"
#import "NSDictionary+Dejal.h"


@implementation NSString (Dejal)

/**
 给定一个整数值，返回相应的字符串。
*/

+ (NSString *)tfy_stringWithIntegerValue:(NSInteger)value;
{
#if TARGET_OS_IPHONE
    return [self stringWithFormat:@"%ld", (long)value];
#else
    return [self stringWithFormat:@"%ld", value];
#endif
}

/**
 给定CGFloat值和表示它的小数位数，返回相应的字符串。
*/

+ (NSString *)tfy_stringWithFloatValue:(CGFloat)value places:(NSInteger)places
{
#if TARGET_OS_IPHONE
    NSString *format = [self stringWithFormat:@"%%.%ldf", (long)places];
#else
    NSString *format = [self stringWithFormat:@"%%.%ldf", places];
#endif
    
    return [self stringWithFormat:format, value];
}

/**
 给定CGFloat值，返回相应的字符串，在小数部分中包含尽可能多的非零数字。
*/

+ (NSString *)tfy_stringWithTruncatedFloatValue:(CGFloat)value;
{
    NSMutableString *mutie = [[self stringWithFormat:@"%f", value] mutableCopy];
    
    while ([mutie hasSuffix:@"0"])
        [mutie deleteCharactersInRange:NSMakeRange([mutie length] - 1, 1)];
    
    if ([mutie hasSuffix:@"."])
        [mutie deleteCharactersInRange:NSMakeRange([mutie length] - 1, 1)];
    
    return mutie;
}

/**
 给定一个NSInteger值，如果它为0，则返回0字符串;如果是，则返回单数字符串;否则返回复数字符串。
*/

+ (NSString *)tfy_stringWithIntegerValue:(NSInteger)value
                                zero:(NSString *)zero
                            singular:(NSString *)singular
                              plural:(NSString *)plural;
{
    if (!value && zero)
        return zero;
    else if ((value == 1 || value == -1) && singular)
        return singular;
    else
        return plural;
}

/**
 给定CGFloat值，如果它为0，则返回0字符串;如果恰好为1，则返回单数字符串;否则返回复数字符串。
*/

+ (NSString *)tfy_stringWithFloatValue:(CGFloat)value
                              zero:(NSString *)zero
                          singular:(NSString *)singular
                            plural:(NSString *)plural;
{
    if (!value && zero)
        return zero;
    else if ((value == 1.0 || value == -1.0) && singular)
        return singular;
    else
        return plural;
}

/**
 给定时间间隔，返回具有该时间间隔和适当时间单位的字符串。这可能是一个更好的NSFormatter子类的时间间隔?
*/

+ (NSString *)tfy_stringWithTimeInterval:(NSTimeInterval)seconds;
{
    return [self tfy_stringWithTimeInterval:seconds suffix:nil];
}

/**
 给定一个时间间隔和后缀(例如;"ago")，返回一个包含该间隔、适当的时间单位和后缀的字符串，例如。“3.2分钟前”。这可能是一个更好的NSFormatter子类的时间间隔?
*/

+ (NSString *)tfy_stringWithTimeInterval:(NSTimeInterval)seconds suffix:(NSString *)suffix;
{
    NSString *value;
    CGFloat minutes = seconds / 60.0;
    CGFloat hours = minutes / 60.0;
    CGFloat days = hours / 24.0;
    CGFloat weeks = days / 7.0;
    CGFloat months = days / 31.0;
    CGFloat years = months / 12.0;

    if (years >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", years, [NSString tfy_stringWithFloatValue:years zero:nil singular:@"year" plural:@"years"]];
    else if (months >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", months, [NSString tfy_stringWithFloatValue:months zero:nil singular:@"month" plural:@"months"]];
    else if (weeks >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", weeks, [NSString tfy_stringWithFloatValue:weeks zero:nil singular:@"week" plural:@"weeks"]];
    else if (days >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", days, [NSString tfy_stringWithFloatValue:days zero:nil singular:@"day" plural:@"days"]];
    else if (hours >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", hours, [NSString tfy_stringWithFloatValue:hours zero:nil singular:@"hour" plural:@"hours"]];
    else if (minutes >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", minutes, [NSString tfy_stringWithFloatValue:minutes zero:nil singular:@"minute" plural:@"minutes"]];
    else
        value = [NSString stringWithFormat:@"%.1f %@", seconds, [NSString tfy_stringWithFloatValue:seconds zero:nil singular:@"second" plural:@"seconds"]];
    
    if (suffix.length)
        value = [value stringByAppendingFormat:@" %@", suffix];
    
    return value;
}

/**
 给定一个时间间隔和后缀(例如;"ago")返回一个字符串，其中包含该间隔(四舍五入到最接近的整数)、适当的时间单位和后缀，例如。“3分钟前”。这可能是一个更好的NSFormatter子类的时间间隔?
*/

+ (NSString *)tfy_stringWithRoundedTimeInterval:(NSTimeInterval)seconds suffix:(NSString *)suffix;
{
    NSString *value;
    CGFloat minutes = seconds / 60.0;
    CGFloat hours = minutes / 60.0;
    CGFloat days = hours / 24.0;
    CGFloat weeks = days / 7.0;
    CGFloat months = days / 31.0;
    CGFloat years = months / 12.0;
    
    if (years >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(years), [NSString tfy_stringWithIntegerValue:rintf(years) zero:nil singular:@"year" plural:@"years"]];
    else if (months >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(months), [NSString tfy_stringWithIntegerValue:rintf(months) zero:nil singular:@"month" plural:@"months"]];
    else if (weeks >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(weeks), [NSString tfy_stringWithIntegerValue:rintf(weeks) zero:nil singular:@"week" plural:@"weeks"]];
    else if (days >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(days), [NSString tfy_stringWithIntegerValue:rintf(days) zero:nil singular:@"day" plural:@"days"]];
    else if (hours >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(hours), [NSString tfy_stringWithIntegerValue:rintf(hours) zero:nil singular:@"hour" plural:@"hours"]];
    else if (minutes >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(minutes), [NSString tfy_stringWithIntegerValue:rintf(minutes) zero:nil singular:@"minute" plural:@"minutes"]];
    else
        value = [NSString stringWithFormat:@"%.0f %@", rintf(seconds), [NSString tfy_stringWithIntegerValue:rintf(seconds) zero:nil singular:@"second" plural:@"seconds"]];
    
    if (suffix.length)
        value = [value stringByAppendingFormat:@" %@", suffix];
    
    return value;
}

/**
 给定一个表示时间(以秒为单位)的整数值，以及表示分钟和秒的适当单词的单数和复数，该函数将返回一个表示该时间间隔的字符串，例如@"1分37秒"。为minutes或seconds参数对传递nil以排除这些单位，例如，为secondSingular和secondsPlural传递nil将只产生“1分钟”。如果两者都需要，且其中一个为零，则省略[如果将来需要不同的行为，则添加参数表示;不要改变这个功能]。可以根据需要添加类似的方法，以包括工作时间等选项。
*/

+ (NSString *)tfy_stringWithSeconds:(NSInteger)seconds
                 minuteSingular:(NSString *)minuteSingular
                  minutesPlural:(NSString *)minutesPlural
                 secondSingular:(NSString *)secondSingular
                  secondsPlural:(NSString *)secondsPlural
{
    NSString *minutesString = nil;
    NSString *secondsString = nil;
    NSString *timeString = nil;
    NSInteger minutes = seconds / 60;

    BOOL wantSeconds = (secondSingular && secondsPlural);
    BOOL wantMinutes = (minuteSingular && minutesPlural);
    
    if (wantMinutes)
    {
        seconds = seconds % 60;
        
#if TARGET_OS_IPHONE
        minutesString = [self stringWithFormat:@"%ld %@", (long)minutes,
            [self tfy_stringWithIntegerValue:minutes zero:nil singular:minuteSingular plural:minutesPlural]];
#else
        minutesString = [self stringWithFormat:@"%ld %@", minutes,
                         [self tfy_stringWithIntegerValue:minutes zero:nil singular:minuteSingular plural:minutesPlural]];
#endif
    }

    if (wantSeconds)
        secondsString = [self stringWithFormat:NSLocalizedString(@"%ld %@", @"Seconds remaining"), (long)seconds,
            [self tfy_stringWithIntegerValue:seconds zero:nil singular:secondSingular plural:secondsPlural]];

    if (minutes && seconds && wantSeconds && wantMinutes)
        timeString = [NSString stringWithFormat:@"%@ %@", minutesString, secondsString];
    else if (minutes || !wantSeconds)
        timeString = minutesString;
    else
        timeString = secondsString;
    
    return timeString;
}

/**
 给定一个NSInteger值，以字符串形式返回。如果结果字符串的长度小于minLength，则根据请求在左侧或右侧使用指定的填充字符填充它。[注:目前填充假设为单个字符，但未来可能会增加对多个字符的支持。]
*/

+ (NSString *)tfy_stringWithIntegerValue:(NSInteger)value minimumLength:(NSUInteger)minLength paddedWith:(NSString *)padding padLeft:(BOOL)padLeft;
{
#if TARGET_OS_IPHONE
    return [[self stringWithFormat:@"%ld", (long)value] tfy_stringWithMinimumLength:minLength paddedWith:padding padLeft:padLeft];
#else
    return [[self stringWithFormat:@"%ld", value] tfy_stringWithMinimumLength:minLength paddedWith:padding padLeft:padLeft];
#endif
}

/**
 给定一个NSInteger值，将其作为具有指定数字数的字符串返回。如果数字中数字较少，则用前导零填充。如果有更多，则截断为该位数。注意，这相当于稍短但不太直观的+[NSString stringWithFormat:@"%0.4d"， value]，其中4被数字的位数取代，除了该方法不会截断较长的数字。
*/

+ (NSString *)tfy_stringWithLeadingZeroesForIntegerValue:(NSInteger)value digits:(NSInteger)digits;
{
#if TARGET_OS_IPHONE
    return [[self stringWithFormat:@"%0.10ld", (long)value] tfy_right:digits];
#else
    return [[self stringWithFormat:@"%0.10ld", value] tfy_right:digits];
#endif
}

/**
 给定一个以字节为单位的值，将其作为带" bytes"、" KB"、" MB"或" GB"后缀的字符串返回(视情况而定)。
*/

+ (NSString *)tfy_stringAsBytesWithInteger:(NSInteger)bytes;
{
    NSString *temp;
    CGFloat kilobyte = 1024.0;
    CGFloat megabyte = kilobyte * kilobyte;
    CGFloat gigabyte = megabyte * kilobyte;
    
    if (bytes == 0)
        temp = NSLocalizedStringFromTable(@"Zero KB", @"tfyOpen", @"Zero Kilobytes");
    else if (bytes >= gigabyte)
        temp = [self stringWithFormat:NSLocalizedStringFromTable(@"%.1f GB", @"tfyOpen", @"Gigabytes"), bytes / gigabyte];
    else if (bytes >= megabyte)
        temp = [self stringWithFormat:NSLocalizedStringFromTable(@"%.1f MB", @"tfyOpen", @"Megabytes"), bytes / megabyte];
    else if (bytes >= kilobyte)
        temp = [self stringWithFormat:NSLocalizedStringFromTable(@"%.1f KB", @"tfyOpen", @"Kilobytes"), bytes / kilobyte];
    else
        temp = [self stringWithFormat:NSLocalizedStringFromTable(@"%ld bytes", @"tfyOpen", @"Bytes"), (long)bytes];

    return temp;
}

/**
 如果关键字是一个有效的非空字符串，则返回一个包含前缀、关键字和后缀的字符串(如果需要，前缀和/或后缀可以为nil)。否则，如果替代项是一个有效的非空字符串，则返回该字符串。如果关键字和备选项都为nil，则返回nil，因此如果你想要一个有效的字符串，至少为备选项传递@""。
*/

+ (NSString *)tfy_stringWithPrefix:(NSString *)prefix keyword:(NSString *)keyword suffix:(NSString *)suffix or:(NSString *)alternative;
{
    if (!keyword && !alternative)
        return nil;
    
    NSMutableString *retString = [NSMutableString string];
    
    [retString tfy_appendPrefix:prefix keyword:keyword suffix:suffix or:alternative];
    
    return retString;
}

/**
 一定是最短的方法名之一!如果preferred不是nil，则返回该对象，否则返回self。提供可选字符串很有用，例如[@"never"或:someDateObject]。
*/

- (id)tfy_or:(id)preferred;
{
    if (preferred)
        return preferred;
    else
        return self;
}

/**
 给定一个字符串，其中包含两个或多个以" | "分隔的备选项，返回指定下标处的字符串。可以用作bool的一种极其低效的变体吗?Str1: str2，或者获取基于整数的几个值之一。对于本地化字符串特别有用，因为几个字符串可以组合成一个字符串。如果索引大于备选项的数量，则返回空字符串。
*/

- (NSString *)tfy_indexedBy:(NSUInteger)idx;
{
    NSArray *alternatives = [self componentsSeparatedByString:@" | "];
    
    if (idx < [alternatives count])
	    return alternatives[idx];
    else
        return @"";
}

/**
 如果字符串非空，即非nil和@""，则返回YES。
*/

- (BOOL)tfy_containsSomething
{
    return ([self length] > 0);
}


- (NSComparisonResult)tfy_caseAndSpaceInsensitiveCompare:(NSString *)otherString
{
    NSString *selfString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *other = [otherString stringByReplacingOccurrencesOfString:@" " withString:@""];

    return [selfString caseInsensitiveCompare:other];
}

/**
 返回除数字以外的所有字符的接收器。有用的比较两个字符串没有多余的标点符号等。
 */

- (NSString *)tfy_digitsOnly;
{
    NSCharacterSet *charSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    return [self tfy_stringByRemovingCharactersInSet:charSet];
}

/**
 返回将所有字母字符转换为小写字母，并删除所有其他字符的接收器。有用的比较两个字符串没有多余的标点符号等。
*/

- (NSString *)tfy_lowercasedLettersOnly
{
    NSCharacterSet *charSet = [[NSCharacterSet lowercaseLetterCharacterSet] invertedSet];
    NSString *clean = [[self lowercaseString] tfy_stringByRemovingCharactersInSet:charSet];
    
    return clean;
}

/**
 返回接收方，将所有字母字符转换为小写字母，删除除数字以外的所有其他字符。有用的比较两个字符串没有多余的标点符号等。
*/

- (NSString *)tfy_lowercasedLettersOrDigitsOnly;
{
    NSCharacterSet *charSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *clean = [[self lowercaseString] tfy_stringByRemovingCharactersInSet:charSet];
    
    return clean;
}

/**
 如果接收方包含另一个字符串，则只查看字母字符，忽略大小写，返回YES。
*/

- (BOOL)tfy_containsStringLetters:(NSString *)otherString
{
    return ([[self tfy_lowercasedLettersOnly] containsString:[otherString tfy_lowercasedLettersOnly]]);
}

/**
 如果接收者和另一个字符串相等，只看字母，忽略大小写，则返回YES。
*/

- (BOOL)tfy_isLetterEquivalentToString:(NSString *)otherString
{
    return ([[self tfy_lowercasedLettersOnly] isEqualToString:[otherString tfy_lowercasedLettersOnly]]);
}

/**
 返回一个字符串，其中所有字符都与从接收端删除的集合匹配。
*/

- (NSString *)tfy_stringByRemovingCharactersInSet:(NSCharacterSet *)set;
{
    NSMutableString *mutString = [NSMutableString stringWithString:self];
    
    [mutString tfy_deleteCharactersInSet:set];
    
    return [NSString stringWithString:mutString];
}

/**
 返回从接收端移除变音符标记的字符串。例如，带有重音的“expose”将返回不带重音的“expose”。
*/

- (NSString *)tfy_stringByRemovingDiacriticalMarks;
{
    NSMutableString *mutie = [[self decomposedStringWithCanonicalMapping] mutableCopy];
    NSCharacterSet *nonBaseSet = [NSCharacterSet nonBaseCharacterSet];
    NSRange range = NSMakeRange([mutie length], 0);
    
    while (range.location > 0)
    {
        range = [mutie rangeOfCharacterFromSet:nonBaseSet options:NSBackwardsSearch range:NSMakeRange(0, range.location)];
        
        if (range.length == 0)
            break;
        
        [mutie deleteCharactersInRange:range];
    }
    
    return mutie;
}

- (NSString *)tfy_stringByRemovingQuotesAndSpaces
{
    BOOL insideQuote = NO;
    NSString *nextChar;
    NSMutableString *retString = [NSMutableString string];
    NSUInteger i;

    for (i = 0; i < [self length]; i++)
    {
        unichar nChar = [self characterAtIndex:i];
        nextChar = [NSString stringWithCharacters:&nChar length:1];
        
        if ([nextChar isEqual:@"\""])
        {
            if (!insideQuote)
                insideQuote = YES;
            else
                insideQuote = NO;
            
            continue;
        }
        
        if ([nextChar isEqual:@" "] && insideQuote)
            [retString appendString:@"&SP&"];
        else
            [retString appendString:nextChar];
    }

    return [NSString stringWithString:retString];
}

/**
 如果接收方有指定的前缀，则返回一个不带该前缀的新字符串，否则返回接收方不变。
*/

- (NSString *)tfy_stringByRemovingPrefix:(NSString *)prefix;
{
    if ([self hasPrefix:prefix])
        return [self substringFromIndex:prefix.length];
    else
        return self;
}

/**
 如果接收方具有指定的后缀，则返回一个不带该后缀的新字符串，否则不加修改地返回接收方。
*/

- (NSString *)tfy_stringByRemovingSuffix:(NSString *)suffix;
{
    if ([self hasSuffix:suffix])
        return [self substringToIndex:self.length - suffix.length];
    else
        return self;
}

- (NSString *)tfy_stringByDeletingLeadingSpaces:(BOOL)leading trailingSpaces:(BOOL)trailing
{
    NSMutableString *mutString = [NSMutableString stringWithString:self];

    [mutString tfy_deleteLeadingSpaces:leading trailingSpaces:trailing];

    return [NSString stringWithString:mutString];
}

/**
 如果接收者的长度小于minLength，它将被指定的填充字符串填充，在请求的左边或右边。[注:目前填充假设为单个字符，但未来可能会增加对多个字符的支持。]
 注意:可能想要弃用这个方法，因为-[NSString stringByPaddingToLength:withString:startingAtIndex:]是可用的，尽管它不支持左侧填充。
*/

- (NSString *)tfy_stringWithMinimumLength:(NSUInteger)minLength paddedWith:(NSString *)padding padLeft:(BOOL)padLeft;
{
    NSString *temp = self;
    
    if (!padding)
        padding = @" ";
    
    if ([temp length] < minLength)
    {
        NSUInteger shortfall = minLength - [temp length];
        NSUInteger i;
        
        for (i = 0; i < shortfall; i++)
        {
            if (padLeft)
                temp = [padding stringByAppendingString:temp];
            else
                temp = [temp stringByAppendingString:padding];
        }
    }
    
    return temp;
}

/**
 从接收端返回一个字符串数组，用空格分隔，每个字符串不超过长度字符。支持多个段落，但假设它们由lf分隔。如果重要的话，将来可以调整这个限制。
*/

- (NSArray *)tfy_componentsSeparatedByLength:(NSUInteger)length;
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *paragraphs = [self componentsSeparatedByString:@"\n"];
    NSString *paragraph;
    
    for (paragraph in paragraphs)
    {
        NSScanner *wordScanner = [NSScanner scannerWithString:paragraph];
        NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceCharacterSet];
        NSString *word = nil;
        NSString *separator = nil;
        NSMutableString *line = [NSMutableString stringWithCapacity:length];
        
        [wordScanner setCharactersToBeSkipped:[NSCharacterSet illegalCharacterSet]];
        
        while (![wordScanner isAtEnd])
        {
            [wordScanner scanUpToCharactersFromSet:whiteSpace intoString:&word];
            [wordScanner scanCharactersFromSet:whiteSpace intoString:&separator];
            
            if (([line length] + [word length] + [separator length]) <= length)
            {
                [line appendString:word];
                [line appendString:separator];
            }
            else
            {
                [array addObject:line];
                line = [NSMutableString stringWithString:word];
                [line appendString:separator];
            }
        }
        
        [array addObject:line];
    }
    
    return array;
}

/**
 给定一个整数，以字符串形式返回其长度。
*/

+ (NSUInteger)tfy_lengthOfInteger:(NSInteger)integer;
{
    return [[NSString stringWithFormat:@"%@", @(integer)] length];
}

/**
 返回一个有符号值的接收者的长度，以避免“有符号和无符号之间的比较”警告。
*/

- (NSInteger)tfy_signedLength;
{
    return (NSInteger)[self length];
}

/**
 返回接收器中的字数。
*/

- (NSInteger)tfy_wordCount
{
    NSScanner *wordScanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceCharacterSet];
    NSMutableCharacterSet *tempSet = (NSMutableCharacterSet *)[NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    [tempSet formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
    NSCharacterSet *skipSet = [tempSet copy];
    NSInteger wordCount = 0;
    
    [wordScanner setCharactersToBeSkipped:skipSet];
    
    while ([wordScanner scanUpToCharactersFromSet:whiteSpace intoString:nil])
        wordCount++;
    
    return wordCount;
}

/**
 给定一个包含版本号的字符串，形式为“1.2.3b4”，返回一个字典，每个组件分开，分别使用键“Major”，“Minor”，“Bug”，“Kind”和“Stage”。此外，“Version”键将包含原始版本字符串，“General”将包含通用版本部分，即省略“b4”或其他内容，“IsGeneral”是一个布尔值，指示它是否是通用版本。如果缺少版本字符串的相应组件，则省略键。
*/

- (NSDictionary *)tfy_dictionaryWithVersionComponents
{
    NSRange range = [self rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    NSString *general = self;
    NSString *kind = nil;
    NSString *stage = nil;
    
    if (range.location != NSNotFound)
    {
        general = [self substringToIndex:range.location];
        kind = [self substringWithRange:range];
        stage = [self substringFromIndex:range.location + range.length];
    }
    
    NSArray *array = [general componentsSeparatedByString:@"."];
    NSUInteger count = [array count];
    NSString *major = (count >= 1) ? array[0] : nil;
    NSString *minor = (count >= 2) ? array[1] : nil;
    NSString *bug = (count >= 3) ? array[2] : nil;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict tfy_setObject:self forKey:@"Version" removeIfNil:NO];
    [dict tfy_setObject:general forKey:@"General" removeIfNil:NO];
    dict[@"IsGeneral"] = @(!kind);
    [dict tfy_setObject:major forKey:@"Major" removeIfNil:NO];
    [dict tfy_setObject:minor forKey:@"Minor" removeIfNil:NO];
    [dict tfy_setObject:bug forKey:@"Bug" removeIfNil:NO];
    [dict tfy_setObject:kind forKey:@"Kind" removeIfNil:NO];
    [dict tfy_setObject:stage forKey:@"Stage" removeIfNil:NO];
    
    return dict;
}

/**
 给定一个包含键“Major”，“Minor”，“Bug”，“Kind”和“Stage”(其中一些可能缺失)的字典，返回字符串表示，例如:“1.2.3b4”。如果字典包含一个预先组合的“Version”键，它只返回该键。
*/

+ (NSString *)tfy_versionWithDictionary:(NSDictionary<NSString*,NSString*> *)dict
{
    NSString *version = dict[@"Version"];
    
    if ([version length])
        return version;
    
    NSInteger major = [dict[@"Major"] integerValue];
    NSInteger minor = [dict[@"Minor"] integerValue];
    NSInteger bug = [dict[@"Bug"] integerValue];
    NSString *kind = dict[@"Kind"];
    NSInteger stage = [dict[@"Stage"] integerValue];
    
    return [self tfy_versionWithMajor:major minor:minor bug:bug kind:kind stage:stage];
}

/**
 给定一个版本号的组件的值(任何一个都可以是0或nil)，返回字符串表示形式，例如:“1.2.3b4”。
*/

+ (NSString *)tfy_versionWithMajor:(NSInteger)major minor:(NSInteger)minor bug:(NSInteger)bug kind:(NSString *)kind stage:(NSInteger)stage
{
    NSString *version = nil;
    
#if TARGET_OS_IPHONE
    if (bug)
        version = [NSString stringWithFormat:@"%ld.%ld.%ld", (long)major, (long)minor, (long)bug];
    else
        version = [NSString stringWithFormat:@"%ld.%ld", (long)major, (long)minor];
    
    if ([kind length])
        version = [NSString stringWithFormat:@"%@%@%ld", version, kind, (long)stage];
#else
    if (bug)
        version = [NSString stringWithFormat:@"%ld.%ld.%ld", major, minor, bug];
    else
        version = [NSString stringWithFormat:@"%ld.%ld", major, minor];
    
    if ([kind length])
        version = [NSString stringWithFormat:@"%@%@%ld", version, kind, stage];
#endif
    
    return version;
}

/**
 返回从接收器开始的指定字符数，如果没有那么多，则返回整个接收器。如果传递了一个负值，它将返回从接收端开始直到传递值在接收端长度之前的绝对值的字符，(例如[@"Hello!" left:-1]返回@"Hello")，如果没有那么多，则返回空字符串。
*/

- (NSString *)tfy_left:(NSInteger)length
{
    if (length < 0)
    {
        if (-length < (NSInteger)[self length])
            return [self substringToIndex:[self length] + length];
        else
            return @"";
    }
    else
    {
        if (length < (NSInteger)[self length])
            return [self substringToIndex:length];
        else
            return self;
    }
}

/**
 返回从接收器末端开始的指定字符数，如果没有那么多字符，则返回整个接收器。如果传递了一个负值，它将返回从接收器末端到接收器开始之前传递值的绝对值的字符，(例如[@"An example" left:-3]返回@"example")，如果没有那么多，则返回一个空字符串。
*/

- (NSString *)tfy_right:(NSInteger)length
{
    if (length < 0)
    {
        NSInteger i = [self length] + length;
        
        if (i > 0)
            return [self substringFromIndex:[self length] - i];
        else
            return @"";
    }
    else
    {
        NSInteger i = [self length] - length;
        
        if (i > 0)
            return [self substringFromIndex:i];
        else
            return self;
    }
}

/**
 返回接收器的子字符串，从指定的位置和指定的长度。如果该位置没有那么多字符，则返回有多少字符就返回多少字符;如果该位置超出范围，则返回空字符串。
*/

- (NSString *)tfy_from:(NSUInteger)position length:(NSUInteger)length
{
    if (position >= [self length])
        return @"";
    else
        return [[self substringFromIndex:position] tfy_left:length];
}

/**
 返回接收器的子字符串，从起始位置到结束位置，包括起始位置和结束位置。如果任何一个位置超出了范围，则返回该范围的可用值。
*/

- (NSString *)tfy_from:(NSUInteger)startPosition to:(NSUInteger)endPosition
{
    if (startPosition > endPosition)
        return @"";
    else
        return [self tfy_from:startPosition length:endPosition - startPosition + 1];
}

/**
 类似于-substringFromIndex:，但要查找的是字符串而不是索引。如果字符串在接收器内，则返回该字符串之后到末尾的字符。如果不在，则返回接收器。
*/

- (NSString *)tfy_substringFromString:(NSString *)string;
{
    NSRange range = [self rangeOfString:string];
    
    if (range.location == NSNotFound)
        return self;
    else
        return [self substringFromIndex:range.location + range.length];
}

/**
 类似于-substringToIndex:，但要查找的是字符串而不是索引。如果字符串在接收器内，则返回从起始位置到不包括该字符串位置的字符。如果不在，则返回接收器。
*/

- (NSString *)tfy_substringToString:(NSString *)string;
{
    NSRange range = [self rangeOfString:string];
    
    if (range.location == NSNotFound)
        return self;
    else
        return [self substringToIndex:range.location];
}

/**
 类似于同时使用-substringFromString:和-substringToString:来返回两个字符串之间的字符串，除非接收者中没有startString或endString，否则将返回defaultString。
*/

- (NSString *)tfy_substringFromString:(NSString *)startString toString:(NSString *)endString defaultString:(NSString *)defaultString;
{
    NSRange substringRange = [self tfy_rangeFromString:startString toString:endString];
    
    if (substringRange.location == NSNotFound)
        return defaultString;
    else
        return [self substringWithRange:substringRange];
}

/**
 返回由指定的开始和结束字符串所包含的字符串范围，如果没有找到则返回NSNotFound。
*/

- (NSRange)tfy_rangeFromString:(NSString *)startString toString:(NSString *)endString;
{
    return [self tfy_rangeFromString:startString toString:endString inclusive:NO];
}

/**
 返回由指定的开始和结束字符串所包含的字符串范围，如果没有找到则返回NSNotFound。如果include为YES，则范围包括开始和结束字符串，否则它只是它们之间的文本。
*/

- (NSRange)tfy_rangeFromString:(NSString *)startString toString:(NSString *)endString inclusive:(BOOL)inclusive;
{
    NSRange startRange = [self rangeOfString:startString];
    
    if (startRange.location == NSNotFound)
        return startRange;
    
    NSInteger substringLocation = startRange.location + startRange.length;
    NSRange endRange = [self rangeOfString:endString options:0 range:NSMakeRange(substringLocation, self.length - substringLocation)];
    
    if (endRange.location == NSNotFound)
        return endRange;
    
    if (inclusive)
        return NSMakeRange(startRange.location, (endRange.location - startRange.location) + endRange.length);
    else
        return NSMakeRange(substringLocation, endRange.location - substringLocation);
}

/**
 以倒序的方式返回接收端。
*/

- (NSString *)tfy_reverse
{
    NSString *nextChar;
    NSMutableString *retString = [NSMutableString string];
    NSInteger i;
    
    for (i = [self length] - 1; i >= 0; i--)
    {
        unichar nChar = [self characterAtIndex:i];
        nextChar = [NSString stringWithCharacters:&nChar length:1];
        
        [retString appendString:nextChar];
    }
    
    return [NSString stringWithString:retString];
}

/**
 返回接收方的校验和，可用于与其他字符串进行比较。类似于-hash，但是可以(并且已经)在不同的操作系统版本之间更改。
*/

- (NSUInteger)tfy_checksum;
{
    NSUInteger base = [self length];
    NSUInteger result = base * base;
    
    for (NSUInteger i = 0; i < [self length]; i++)
    {
        result = (result + ([self characterAtIndex:i] * (i + 34)) + (732 * i) + (base * (i + 83))) % 999999999;
    }
    return result;
}

/**
 返回一个简单加密的接收器，用于隐藏密码等。通过下面的-unmask进行解密。
*/

- (NSString *)tfy_mask
{
    if (![self length])
        return self;
    
    NSMutableString *retString = [NSMutableString string];
    NSString *fragment;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    NSUInteger randomValue = ([components day] * [components minute]) / ([components second] + 5);
    unichar character = 0;
    NSUInteger i;
    
    for (i = 0; i < [self length]; i++)
    {
        character = [self characterAtIndex:i] + 57 + (randomValue * (i + 3));
        fragment = [NSString stringWithFormat:@"%xO", character];
        
        [retString appendString:fragment];
    }
    
#if TARGET_OS_IPHONE
    return [NSString stringWithFormat:@"1a7q4%lud39%@", (unsigned long)randomValue, [retString tfy_reverse]];          // 版本1，以防我想改变算法
#else
    return [NSString stringWithFormat:@"1a7q4%ldd39%@", randomValue, [retString tfy_reverse]];          // 版本1，以防我想改变算法
#endif
}

/**
 给定一个通过-mask进行屏蔽的字符串，返回解密后的结果。可以用一个未屏蔽的字符串调用;在这种情况下只返回self。
*/

- (NSString *)tfy_unmask
{
    if (![self length])
        return self;
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSMutableString *retString = [NSMutableString string];
    NSString *fragment;
    unsigned hexInt = 0;
    unichar character = 0;
    NSInteger version = 0;
    NSInteger randomValue = 0;
    NSInteger i = 0;
    
    if (![scanner scanInteger:&version])
        return self;
    
    if (![scanner scanString:@"a7q4" intoString:nil])
        return self;
    
    if (![scanner scanInteger:&randomValue])
        return self;
    
    if (![scanner scanString:@"d39" intoString:nil])
        return self;
    
    NSInteger location = [scanner scanLocation];
    NSString *remaining = [[self substringFromIndex:location] tfy_reverse];
    
    scanner = [NSScanner scannerWithString:remaining];
    
    while (![scanner isAtEnd])
    {
        if ([scanner scanHexInt:&hexInt])
        {
            character = hexInt - (randomValue * (i + 3)) - 57;
            fragment = [NSString stringWithCharacters:&character length:1];
            
            [retString appendString:fragment];
        }
        
        [scanner scanString:@"O" intoString:nil];
        
        i++;
    }
    
    return [NSString stringWithString:retString];
}

/**
 将接收器转换为base64编码版本。
 */

- (NSString *)tfy_encodeAsBase64UsingEncoding:(NSStringEncoding)encoding;
{
    NSData *data = [self dataUsingEncoding:encoding];
    
    return [data base64EncodedStringWithOptions:0];
}

/**
 将base64编码的接收器转换为解码后的字符串。
 */

- (NSString *)tfy_decodeFromBase64UsingEncoding:(NSStringEncoding)encoding;
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [[NSString alloc] initWithData:data encoding:encoding];
}

/**
 返回用标准Rot13算法编码的接收器:字母字符绕字母表旋转一半，其他字符保持不变。
*/ 

- (NSString *)tfy_rotate13
{
    NSMutableString *string = [NSMutableString string];
    NSUInteger i;
    
    for (i = 0; i < [self length]; ++i)
    {
        unichar character = [self characterAtIndex:i];
        unichar capital = character & 32;
        
        character &= ~capital;
        character = ((character >= 'A') && (character <= 'z')) ? ((character - 'A' + 13) % 26 + 'A') : character;
        character |= capital;
        
        [string appendFormat:@"%c", character];
    }
    
    return string;
}

/**
 返回一个保证全局唯一的字符串，可以用作唯一标识符。这种变化省略了破折号。使用[NSUUID UUID]。直接使用UUIDString，如果破折号没问题。
*/

+ (NSString *)tfy_uuid;
{
    return [[NSUUID UUID].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

/**
 -mappedFromValue:withDefault:将字符串值映射为整数的方便方法。
*/

- (NSInteger)tfy_integerMappedFromString:(NSString *)value withDefault:(NSInteger)defaultValue;
{
    return [[self tfy_mappedFromValue:value withDefault:@(defaultValue)] integerValue];
}

/**
 -mappedFromValue的方便方法:withDefault:将整型值映射为字符串。
*/

- (NSString *)tfy_stringMappedFromInteger:(NSInteger)value withDefault:(NSString *)defaultValue;
{
    return [self tfy_mappedFromValue:@(value) withDefault:defaultValue];
}

/**
 给定接收端中“foo=bar;blah=beep;x=y”形式的映射和一个值(任何类型)，返回相应的值。例如，使用上面的映射和值"blah"，将返回"beep"。它以两种方式工作:如果传递了"beep"，则返回"blah"。如果无法找到匹配项，并且提供了默认值，则返回默认值。除了大的if/else或switch子句之外，可能还有更简单或更有效的方法来做到这一点，但从使用的角度来看，这似乎更整洁:只需调用一行代码。(我考虑过为此添加一个tfyMapperData类，但现在决定反对它，因为我想在Simon插件中使用它，如果我想在应用程序的其他地方使用它，它有类共享问题。)
*/

- (NSString *)tfy_mappedFromValue:(id)value withDefault:(id)defaultValue;
{
    NSArray *array = [self componentsSeparatedByString:@";"];
    NSString *desired = [value description];
    NSString *result = nil;
    NSString *mapping = nil;
    
    // 扫描映射直到找到匹配:
    for (mapping in array)
    {
    	NSArray *parts = [mapping componentsSeparatedByString:@"="];
        
        if ([desired isEqualToString:[parts firstObject]])
            result = [parts lastObject];
        else if ([desired isEqualToString:[parts lastObject]])
            result = [parts firstObject];
    }
    
    // 如果没有结果，并且提供了一个默认值，返回一个默认值的副本转换为一个字符串(生成一个副本作为-[NSString description]返回self):
    if (!result && defaultValue)
        result = [[defaultValue copy] description];
    
    return result;
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSString (DejalInternet)

/**
 Core Foundation函数周围的Objective-C包装器，用于将url安全字符串转换为原始格式。
*/

- (NSString *)tfy_stringByReplacingPercentEscapes
{
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL, (__bridge CFStringRef)self, CFSTR(""));
}

/**
 一个围绕Core Foundation函数的Objective-C包装器，用于将原始字符串转换为url安全格式。
*/

- (NSString *)tfy_stringByAddingPercentEscapes
{
    //警告:忽略弃用;应该改天修复
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", kCFStringEncodingUTF8);
#pragma clang diagnostic pop
}

/**
 返回基于接收器的字符串，删除变音符标记，并根据需要添加百分比转义，可以安全地作为URL参数传递。
*/

- (NSString *)tfy_stringByMakingURLSafe;
{
    return [[self tfy_stringByRemovingDiacriticalMarks] tfy_stringByAddingPercentEscapes];
}

/**
 给定一个包含HTML标记的字符串，如“<p>”和“<href>”，去掉所有这样的标记，包括字符串开头的任何不完整的标记(如果它是源的子字符串)。
*/

- (NSString *)tfy_stringByStrippingHTML;
{
    NSMutableString *output = [NSMutableString stringWithCapacity:[self length]];
    
    // 扫描字符串:
    NSScanner *scanner = [NSScanner scannerWithString:self];
    
    // NSScanner跳过空格并默认返回，这是我们不想要的，所以让它跳过非法字符:
    [scanner setCharactersToBeSkipped:[NSCharacterSet illegalCharacterSet]];
    
    while (![scanner isAtEnd])
    {
        NSString *prefix = @"";
        
        // 扫描到一个HTML标签，并记住以后:
        [scanner scanUpToString:@"<" intoString:&prefix];
        
        // 如果我们找到一个HTML标签，扫描过去:
        if ([scanner scanString:@"<" intoString:nil] && [scanner scanUpToString:@">" intoString:nil])
            [scanner scanString:@">" intoString:nil];
        
        // 将HTML标签之前的东西附加到输出:
        [output appendString:prefix];
    }
    
    NSRange range = [output rangeOfString:@">"];
    
    if (range.location != NSNotFound)
        [output deleteCharactersInRange:NSMakeRange(0, range.location + range.length)];
    
    return [NSString stringWithString:output];
}

/**
 给定一个潜在的URL，清理它以确保它是有效的。如果接收器是空白的，它将原封不动地返回。它默认TLD为“。com”，不影响路径，并在需要时添加“http://”方案。举个例子，
 */

- (NSString *)tfy_stringByCleaningURL;
{
    return [self tfy_stringByCleaningURLWithDefaultScheme:nil];
}

/**
 给定一个潜在的URL，清理它以确保它是有效的。如果接收器是空白的，它将原封不动地返回。它将TLD默认为“。com”，而不影响路径，并在需要时添加指定的默认方案。如果方案为nil，则默认为“
*/

- (NSString *)tfy_stringByCleaningURLWithDefaultScheme:(NSString *)scheme;
{
    if (![self length])
        return self;
    
    NSString *url = self;
    NSString *path = @"/";
    NSRange range = [url rangeOfString:@"://"];
    
    if (range.location != NSNotFound)
    {
        scheme = [url substringToIndex:range.location + range.length];
        url = [url substringFromIndex:range.location + range.length];
    }
    
    range = [url rangeOfString:@"/"];
    
    if (range.location != NSNotFound)
    {
        path = [url substringFromIndex:range.location];
        url = [url substringToIndex:range.location];
    }
    
    if (![url containsString:@"."] && ![scheme isEqualToString:@"file://"] && ![url containsString:@"localhost"])
        url = [NSString stringWithFormat:@"%@.com", url];
    
    if (!scheme)
    {
        scheme = @"https://";
    }
    
    url = [NSString stringWithFormat:@"%@%@%@", scheme, url, path];
    
    return url;
}

/**
 返回接收者的URL表示形式，如果不是有效URL则返回nil。
*/

- (NSURL *)tfy_urlValue;
{
    NSURL *url = nil;
    
    if (self.length)
        url = [NSURL URLWithString:[self tfy_stringByCleaningURL]];
    
    return url;
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSString (DejalFilePath)

/**
 给定一个文件名(不是路径)，返回删除或替换非法文件名字符的文件名。如果结果文件名为空，则返回指定的默认文件名。
*/

- (NSString *)tfy_stringByCleaningFilenameWithDefault:(NSString *)defaultFilename
{
    NSMutableString *mutString = [NSMutableString stringWithString:self];
    
    [mutString tfy_deleteLeadingSpaces:YES trailingSpaces:YES];
    [mutString tfy_replaceAllOccurrencesOf:@"/" with:@"-"];
    [mutString tfy_replaceAllOccurrencesOf:@":" with:@"-"];
    
    while ([mutString hasPrefix:@"."])
        [mutString deleteCharactersInRange:NSMakeRange(0, 1)];
    
    if ([mutString length])
        return [NSString stringWithString:mutString];
    else
        return defaultFilename;
}

/**
 与-stringByAppendingPathComponent:相同，但是文件名首先通过-stringByCleaningFilenameWithDefault:被清理。
*/

- (NSString *)tfy_stringByAppendingPathComponent:(NSString *)dirtyFilename cleanWithDefault:(NSString *)defaultFilename
{
    return [self stringByAppendingPathComponent:[dirtyFilename tfy_stringByCleaningFilenameWithDefault:defaultFilename]];
}

/**
 返回路径的文件名部分，不带任何扩展名。
*/

- (NSString *)tfy_lastPathComponentWithoutExtension
{
    return [[self lastPathComponent] stringByDeletingPathExtension];
}

/**
 给定一个文件或目录路径，返回相同的路径，在扩展名(如果有)之前插入波浪号，这是备份文件的常规做法。
*/

- (NSString *)tfy_backupFilePath
{
    NSString *extension = [self pathExtension];
    NSString *previous = [self stringByDeletingPathExtension];
    NSString *path = [previous stringByAppendingString:@"~"];
    
    if ([extension length])
        path = [path stringByAppendingPathExtension:extension];
    
    return path;
}

/**
 给定一个文件或目录路径，如果它已经是唯一的(即那里不存在文件)，则返回相同的路径，或者在必要时返回该路径，在扩展名之前插入一个数字以使其唯一。参见下面的-uniquePathWithPrefix:。
*/

- (NSString *)tfy_uniquePath
{
    return [self tfy_uniquePathWithPrefix:nil];
}

/**
 给定一个文件或目录路径，如果它已经是唯一的(即那里不存在文件)，则返回相同的路径，或者返回该路径的前缀和/或在扩展名之前插入一个数字以使其唯一(例如。"filename copy.txt"， "filename copy 2.txt"， "filename copy 3.txt"，等等)，如有必要。另请参见上面的-uniquePath。
*/

- (NSString *)tfy_uniquePathWithPrefix:(NSString *)prefix
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:self])
        return self;
    
    NSString *path = nil;
    NSString *extension = [self pathExtension];
    NSString *previous = [self stringByDeletingPathExtension];
    BOOL usePrefix = [prefix length];
    NSUInteger i = !usePrefix;
    
    do
    {
        i++;
        path = previous;
        
        if (usePrefix)
            path = [path stringByAppendingFormat:@" %@", prefix];
        
        if (i > 1)
#if TARGET_OS_IPHONE
            path = [path stringByAppendingFormat:@" %lu", (unsigned long)i];
#else
            path = [path stringByAppendingFormat:@" %ld", i];
#endif
        
        if ([extension length])
            path = [path stringByAppendingPathExtension:extension];
    }
    while ([[NSFileManager defaultManager] fileExistsAtPath:path]);
    
    return path;
}

/**
 展开路径中的波浪号和/或符号链接，然后检查路径中的所有目录是否已经存在。如果没有，就创建它们。返回展开后的路径。
*/

- (NSString *)tfy_validatedDirectoryPath
{
    NSString *standardized = [self tfy_expandedPath];
    NSArray *components = [standardized pathComponents];
    NSString *component;
    NSString *path = @"";
    
    for (component in components)
    {
        path = [path stringByAppendingPathComponent:component];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path])
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:NULL];
    }
    
    return path;
}

/**
 类似于上面的-validatedDirectoryPath，只是最后一个路径组件被假定为文件名，因此被忽略。
*/

- (NSString *)tfy_validatedFilePath
{
    NSString *filename = [self lastPathComponent];
    NSString *directory = [self stringByDeletingLastPathComponent];
    
    directory = [directory tfy_validatedDirectoryPath];
    
    NSString *path = [directory stringByAppendingPathComponent:filename];
    
    return path;
}

/**
 类似于Cocoa - stringbystandarzingpath方法，但也可以识别和扩展特殊的应用程序包指示符“&lt;APP&gt;”。可以缩写为- atedpath，如下所示。
*/

- (NSString *)tfy_expandedPath
{
    if ([self hasPrefix:@"<APP>"])
        return [self stringByReplacingOccurrencesOfString:@"<APP>" withString:[[NSBundle mainBundle] bundlePath]];
    else
        return [self stringByStandardizingPath];
}

/**
 类似于Cocoa - stringbyatingwithtildeinpath方法，但也使用指示符“&lt;APP&gt;”来缩写应用程序包中的路径。可以使用上面的-expandedPath进行扩展。
*/

- (NSString *)tfy_abbreviatedPath
{
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    
    if ([self hasPrefix:bundlePath])
        return [self stringByReplacingOccurrencesOfString:bundlePath withString:@"<APP>"];
    else
        return [self stringByAbbreviatingWithTildeInPath];
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSString (DejalPropertyList)

+ (NSString *)tfy_stringWithBoolValue:(BOOL)value;
{
    return [self tfy_stringWithIntegerValue:value];
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSMutableString (Dejal)

/**
 从接收端移除与集合匹配的所有字符。
*/

- (void)tfy_deleteCharactersInSet:(NSCharacterSet *)set;
{
    NSInteger i;
    
    for (i = [self length] - 1; i >= 0; i--)
    {
        unichar nChar = [self characterAtIndex:i];
        
        if ([set characterIsMember:nChar])
            [self deleteCharactersInRange:NSMakeRange(i, 1)];
    }
}

- (void)tfy_caseInsensitiveReplaceAllOccurrencesOf:(NSString *)string1 with:(NSString *)string2;
{
    [self replaceOccurrencesOfString:string1 withString:string2 options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
}

- (void)tfy_replaceAllOccurrencesOf:(NSString *)string1 with:(NSString *)string2
{
    [self replaceOccurrencesOfString:string1 withString:string2 options:0 range:NSMakeRange(0, [self length])];
}

- (void)tfy_deleteLeadingSpaces:(BOOL)leading trailingSpaces:(BOOL)trailing
{
    if (leading)
    {
        while ([self hasPrefix:@" "])
            [self deleteCharactersInRange:NSMakeRange(0, 1)];
    }

    if (trailing)
    {
        while ([self hasSuffix:@" "])
            [self deleteCharactersInRange:NSMakeRange([self length] - 1, 1)];
    }
}

/**
 如果字符串是有效的非空字符串，则将其追加到接收方。否则，如果替代项是有效的非空字符串，则追加它。如果两者都不适用，则不会更改接收者。
*/

- (void)tfy_appendString:(NSString *)string or:(NSString *)alternative;
{
    if ([string length])
        [self appendString:string];
    else if ([alternative length])
        [self appendString:alternative];
}

/**
 如果关键字是一个有效的非空字符串，前缀和关键字将被追加到接收器(只有当接收器不为空时，前缀才会被包括在内，如果需要，可以为nil)。否则，不改变接收方。
*/

- (void)tfy_appendPrefix:(NSString *)prefix keyword:(NSString *)keyword;
{
    [self tfy_appendSeparator:prefix prefix:nil keyword:keyword suffix:nil or:nil];
}

/**
 如果关键字是一个有效的非空字符串，则前缀、关键字和后缀将附加到接收端(如果需要，前缀和/或后缀可以为nil)。否则，如果替代项是有效的非空字符串，则追加它。如果两者都不适用，则不会更改接收者。
*/

- (void)tfy_appendPrefix:(NSString *)prefix keyword:(NSString *)keyword suffix:(NSString *)suffix or:(NSString *)alternative;
{
    [self tfy_appendSeparator:nil prefix:prefix keyword:keyword suffix:suffix or:alternative];
}

/**
 如果关键字是一个有效的非空字符串，分隔符、前缀、关键字和后缀将被追加到接收端(分隔符、前缀和后缀可以为nil)。分隔符仅在接收器不为空时才包含。否则，如果替代项是有效的非空字符串，则追加它。如果两者都不适用，则不会更改接收者。
*/

- (void)tfy_appendSeparator:(NSString *)separator prefix:(NSString *)prefix keyword:(NSString *)keyword suffix:(NSString *)suffix  or:(NSString *)alternative;
{
    if (keyword.length)
    {
        if (self.length)
            [self tfy_appendString:separator or:nil];
        
        [self tfy_appendString:prefix or:nil];
        [self appendString:keyword];
        [self tfy_appendString:suffix or:nil];
    }
    else
        [self tfy_appendString:alternative or:nil];
}

@end

