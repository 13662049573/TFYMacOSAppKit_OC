//
//  NSDictionary+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


@interface NSDictionary (Dejal)

+ (id)tfy_dictionaryWithArrayOfDictionaries:(NSArray *)array usingKey:(NSString *)key;

- (id)tfy_deepCopy NS_RETURNS_RETAINED;
- (id)tfy_deepMutableCopy NS_RETURNS_RETAINED;

- (id)tfy_nilOrObjectForKey:(id)aKey;
- (id)tfy_emptyStringOrObjectForKey:(id)aKey;

- (BOOL)tfy_hasKey:(id)key;

- (NSArray *)tfy_sortedKeys;

- (BOOL)tfy_boolForKey:(id)key;
- (NSInteger)tfy_integerForKey:(id)key;
- (CGFloat)tfy_floatForKey:(id)key;
- (NSTimeInterval)tfy_timeIntervalForKey:(id)key;

- (NSDate *)tfy_dateForKey:(id)key;
- (NSDate *)tfy_timeForKey:(id)key;

- (NSString *)tfy_descriptionForKey:(id)key;
- (NSInteger)tfy_stringLengthForKey:(id)key;
- (BOOL)tfy_containsSomethingForKey:(id)key;

- (id)tfy_objectForKey:(id)aKey orBool:(BOOL)aDefault;
- (id)tfy_objectForKey:(id)aKey orInteger:(BOOL)aDefault;

- (id)tfy_objectForKey:(id)aKey defaultValue:(id)aDefault;

- (id)tfy_keyForObject:(id)anObject;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSMutableDictionary (Dejal)

- (void)tfy_setBool:(BOOL)value forKey:(id)key;
- (void)tfy_setInteger:(NSInteger)value forKey:(id)key;
- (void)tfy_setFloat:(CGFloat)value forKey:(id)key;
- (void)tfy_setTimeInterval:(NSTimeInterval)value forKey:(id)key;
- (void)tfy_setJSONDate:(NSDate *)value forKey:(id)key removeIfNil:(BOOL)removeIfNil;

- (void)tfy_setDefaultValue:(id)aDefault forKey:(id)aKey;
- (void)tfy_setObject:(id)anObject forKey:(id)aKey defaultValue:(id)aDefault;
- (void)tfy_setObject:(id)anObject forKey:(id)aKey removeIfNil:(BOOL)removeIfNil;

- (void)tfy_replaceObject:(id)oldObject withObject:(id)newObject;

@end

