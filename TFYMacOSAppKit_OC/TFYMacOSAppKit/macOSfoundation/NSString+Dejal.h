//
//  NSString+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


@import Foundation;


@interface NSString (Dejal)

+ (NSString *)tfy_stringWithIntegerValue:(NSInteger)value;
+ (NSString *)tfy_stringWithFloatValue:(CGFloat)value places:(NSInteger)places;
+ (NSString *)tfy_stringWithTruncatedFloatValue:(CGFloat)value;

+ (NSString *)tfy_stringWithIntegerValue:(NSInteger)value zero:(NSString *)zero singular:(NSString *)singular plural:(NSString *)plural;

+ (NSString *)tfy_stringWithFloatValue:(CGFloat)value zero:(NSString *)zero singular:(NSString *)singular plural:(NSString *)plural;

+ (NSString *)tfy_stringWithTimeInterval:(NSTimeInterval)seconds;
+ (NSString *)tfy_stringWithTimeInterval:(NSTimeInterval)seconds suffix:(NSString *)suffix;

+ (NSString *)tfy_stringWithRoundedTimeInterval:(NSTimeInterval)seconds suffix:(NSString *)suffix;

+ (NSString *)tfy_stringWithSeconds:(NSInteger)seconds minuteSingular:(NSString *)minuteSingular minutesPlural:(NSString *)minutesPlural secondSingular:(NSString *)secondSingular secondsPlural:(NSString *)secondsPlural;

+ (NSString *)tfy_stringWithIntegerValue:(NSInteger)value minimumLength:(NSUInteger)minLength paddedWith:(NSString *)padding padLeft:(BOOL)padLeft;

+ (NSString *)tfy_stringWithLeadingZeroesForIntegerValue:(NSInteger)value digits:(NSInteger)digits;

+ (NSString *)tfy_stringAsBytesWithInteger:(NSInteger)bytes;

+ (NSString *)tfy_stringWithPrefix:(NSString *)prefix keyword:(NSString *)keyword suffix:(NSString *)suffix or:(NSString *)alternative;

- (id)tfy_or:(id)preferred;
- (NSString *)tfy_indexedBy:(NSUInteger)idx;

- (BOOL)tfy_containsSomething;

//- (BOOL)tfy_containsString:(NSString *)subString;
//- (BOOL)tfy_containsStringCaseInsensitive:(NSString *)subString;

- (NSComparisonResult)tfy_caseAndSpaceInsensitiveCompare:(NSString *)otherString;

- (NSString *)tfy_digitsOnly;
- (NSString *)tfy_lowercasedLettersOnly;
- (NSString *)tfy_lowercasedLettersOrDigitsOnly;
- (BOOL)tfy_containsStringLetters:(NSString *)otherString;
- (BOOL)tfy_isLetterEquivalentToString:(NSString *)otherString;

- (NSString *)tfy_stringByRemovingCharactersInSet:(NSCharacterSet *)set;
- (NSString *)tfy_stringByRemovingDiacriticalMarks;
- (NSString *)tfy_stringByRemovingQuotesAndSpaces;

- (NSString *)tfy_stringByRemovingPrefix:(NSString *)prefix;
- (NSString *)tfy_stringByRemovingSuffix:(NSString *)suffix;

- (NSString *)tfy_stringByDeletingLeadingSpaces:(BOOL)leading trailingSpaces:(BOOL)trailing;

- (NSString *)tfy_stringWithMinimumLength:(NSUInteger)minLength paddedWith:(NSString *)padding padLeft:(BOOL)padLeft;

- (NSArray *)tfy_componentsSeparatedByLength:(NSUInteger)length;
+ (NSUInteger)tfy_lengthOfInteger:(NSInteger)integer;

- (NSInteger)tfy_signedLength;
- (NSInteger)tfy_wordCount;

- (NSDictionary *)tfy_dictionaryWithVersionComponents;
+ (NSString *)tfy_versionWithDictionary:(NSDictionary *)dict;
+ (NSString *)tfy_versionWithMajor:(NSInteger)major minor:(NSInteger)minor bug:(NSInteger)bug kind:(NSString *)kind stage:(NSInteger)stage;

- (NSString *)tfy_left:(NSInteger)length;
- (NSString *)tfy_right:(NSInteger)length;

- (NSString *)tfy_from:(NSUInteger)position length:(NSUInteger)length;
- (NSString *)tfy_from:(NSUInteger)startPosition to:(NSUInteger)endPosition;

- (NSString *)tfy_substringFromString:(NSString *)string;
- (NSString *)tfy_substringToString:(NSString *)string;
- (NSString *)tfy_substringFromString:(NSString *)startString toString:(NSString *)endString defaultString:(NSString *)defaultString;

- (NSRange)tfy_rangeFromString:(NSString *)startString toString:(NSString *)endString;
- (NSRange)tfy_rangeFromString:(NSString *)startString toString:(NSString *)endString inclusive:(BOOL)inclusive;

- (NSString *)tfy_reverse;

- (NSUInteger)tfy_checksum;

- (NSString *)tfy_mask;
- (NSString *)tfy_unmask;

- (NSString *)tfy_encodeAsBase64UsingEncoding:(NSStringEncoding)encoding;
- (NSString *)tfy_decodeFromBase64UsingEncoding:(NSStringEncoding)encoding;

- (NSString *)tfy_rotate13;

+ (NSString *)tfy_uuid;

- (NSInteger)tfy_integerMappedFromString:(NSString *)value withDefault:(NSInteger)defaultValue;
- (NSString *)tfy_stringMappedFromInteger:(NSInteger)value withDefault:(NSString *)defaultValue;
- (NSString *)tfy_mappedFromValue:(id)value withDefault:(id)defaultValue;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSString (DejalInternet)

- (NSString *)tfy_stringByReplacingPercentEscapes;
- (NSString *)tfy_stringByAddingPercentEscapes;

- (NSString *)tfy_stringByMakingURLSafe;

- (NSString *)tfy_stringByStrippingHTML;

- (NSString *)tfy_stringByCleaningURL;
- (NSString *)tfy_stringByCleaningURLWithDefaultScheme:(NSString *)scheme;

- (NSURL *)tfy_urlValue;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSString (DejalFilePath)

- (NSString *)tfy_stringByCleaningFilenameWithDefault:(NSString *)defaultFilename;
- (NSString *)tfy_stringByAppendingPathComponent:(NSString *)dirtyFilename cleanWithDefault:(NSString *)defaultFilename;

- (NSString *)tfy_lastPathComponentWithoutExtension;

- (NSString *)tfy_backupFilePath;

- (NSString *)tfy_uniquePath;
- (NSString *)tfy_uniquePathWithPrefix:(NSString *)prefix;

- (NSString *)tfy_validatedDirectoryPath;
- (NSString *)tfy_validatedFilePath;

- (NSString *)tfy_expandedPath;
- (NSString *)tfy_abbreviatedPath;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSString (DejalPropertyList)

+ (NSString *)tfy_stringWithBoolValue:(BOOL)value;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSMutableString (Dejal)

- (void)tfy_deleteCharactersInSet:(NSCharacterSet *)set;

- (void)tfy_caseInsensitiveReplaceAllOccurrencesOf:(NSString *)string1 with:(NSString *)string2;
- (void)tfy_replaceAllOccurrencesOf:(NSString *)string1 with:(NSString *)string2;

- (void)tfy_deleteLeadingSpaces:(BOOL)leading trailingSpaces:(BOOL)trailing;

- (void)tfy_appendString:(NSString *)string or:(NSString *)alternative;
- (void)tfy_appendPrefix:(NSString *)prefix keyword:(NSString *)keyword;
- (void)tfy_appendPrefix:(NSString *)prefix keyword:(NSString *)keyword suffix:(NSString *)suffix or:(NSString *)alternative;
- (void)tfy_appendSeparator:(NSString *)separator prefix:(NSString *)prefix keyword:(NSString *)keyword suffix:(NSString *)suffix  or:(NSString *)alternative;

@end

