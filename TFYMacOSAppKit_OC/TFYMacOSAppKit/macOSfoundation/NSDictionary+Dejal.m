//
//  NSDictionary+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSDictionary+Dejal.h"
#import "NSString+Dejal.h"
#import "NSDate+Dejal.h"


@implementation NSDictionary (Dejal)

/**
 给定一个包含字典和在这些字典中使用的键的数组，返回一个以这些键的值为键，以字典为值的新字典。如果数组或关键参数为nil，则返回nil。实际上与-allValues方法相反。
*/

+ (id)tfy_dictionaryWithArrayOfDictionaries:(NSArray *)array usingKey:(NSString *)key;
{
    if (!array || !key)
        return nil;
    
    NSMutableDictionary *masterDict = [NSMutableDictionary dictionaryWithCapacity:[array count]];
    NSDictionary *subDict;
    
    for (subDict in array)
    {
        NSString *identifier = subDict[key];
        
        if (identifier)
            masterDict[identifier] = subDict;
    }
    
    return masterDict;
}

/**
 类似于-copy，但也复制了字典中的每个对象(使用相同的键)。注意，像-copy一样，字典会被保留。
*/

- (id)tfy_deepCopy;
{
    id dict = [NSMutableDictionary new];
    id copy;
    
    for (id key in self)
    {
        id object = self[key];
        
        if ([object respondsToSelector:@selector(tfy_deepCopy)])
            copy = [object tfy_deepCopy];
        else
            copy = [object copy];
        
    	dict[key] = copy;
    }
    
    return dict;
}

/**
 类似于上面的-tfy_deepCopy，但是使字典的所有内容都是可变的。
*/

- (id)tfy_deepMutableCopy;
{
    id dict = [NSMutableDictionary new];
    id mutableCopy;
    
    for (id key in self)
    {
        id object = self[key];
        
        if ([object respondsToSelector:@selector(tfy_deepMutableCopy)])
            mutableCopy = [object tfy_deepMutableCopy];
        else if ([object conformsToProtocol:@protocol(NSMutableCopying)])
            mutableCopy = [object mutableCopy];
        else
            mutableCopy = [object copy];
        
    	dict[key] = mutableCopy;
    }
    
    return dict;
}

/**
 返回给定键值的条目值，如果没有与aKey相关的值，则返回nil，或者返回NSNull。
*/

- (id)tfy_nilOrObjectForKey:(id)aKey;
{
    id value = self[aKey];
    
    if ([value isKindOfClass:[NSNull class]])
        value = nil;
    
    return value;
}

/**
 返回给定键值的条目值，如果没有与aKey相关的值，则返回空字符串(@"")，或者它是NSNull。
*/

- (id)tfy_emptyStringOrObjectForKey:(id)aKey;
{
    id value = self[aKey];
    
    if (!value || [value isKindOfClass:[NSNull class]])
        value = @"";
    
    return value;
}

/**
 如果键在字典中存在则返回YES，如果不存在则返回NO。不确定的好处，因为-objectForKey:的结果无论如何都可以被视为布尔值，但有时你想要一个实际的BOOL值。
*/

- (BOOL)tfy_hasKey:(id)key;
{
    return (self[key] != nil);
}

/**
 类似于-allKeys，但按字典键的升序排序(不区分大小写)。
*/

- (NSArray *)tfy_sortedKeys;
{
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

// NOTE: may want to add -arrayForKey:, -mutableArrayForKey:, and other variations too sometime.

/**
 如果该键的值是包含“YES”(不区分大小写)的字符串，或者是非零值的数字，则返回YES。否则返回NO。
*/

- (BOOL)tfy_boolForKey:(id)key;
{
    NSString *value = [self tfy_descriptionForKey:key];
    
    if (value)
        return ([value integerValue] || [[value lowercaseString] isEqualToString:@"yes"]);
    else
        return NO;
}

/**
 使用键调用descriptionForKey:。如果没有返回字符串，则返回0。否则，结果字符串将发送一个integerValue消息，该消息提供该方法的返回值。
*/

- (NSInteger)tfy_integerForKey:(id)key;
{
    NSString *value = [self tfy_descriptionForKey:key];
    
    if (value)
        return [value integerValue];
    else
        return 0;
}

/**
 使用键调用descriptionForKey:。如果没有返回字符串，则返回0.0。否则，结果字符串将被发送一个floatValue消息，该消息提供该方法的返回值。
*/

- (CGFloat)tfy_floatForKey:(id)key;
{
    NSString *value = [self tfy_descriptionForKey:key];
    
    if (value)
        return [value floatValue];
    else
        return 0.0;
}

/**
 使用键调用descriptionForKey:。如果没有返回字符串，则返回0.0。否则，结果字符串将被发送一个doubleValue消息，该消息提供该方法的返回值。
*/

- (NSTimeInterval)tfy_timeIntervalForKey:(id)key
{
    NSString *value = [self tfy_descriptionForKey:key];
    
    if (value)
        return [value doubleValue];
    else
        return 0.0;
}

/**
 从JSON字符串中返回一个日期，如果NSNull不是有效日期则返回nil。
*/

- (NSDate *)tfy_dateForKey:(id)key;
{
    id value = [self tfy_nilOrObjectForKey:key];
    
    if ([value isKindOfClass:[NSString class]])
    {
        return [NSDate tfy_dateWithJSONString:value allowPlaceholder:NO];
    }
    else if ([value isKindOfClass:[NSDate class]])
    {
        return value;
    }
    else
    {
        return nil;
    }
}

/**
 从JSON字符串返回一个时间，如果NSNull时间无效，则返回nil。
*/

- (NSDate *)tfy_timeForKey:(id)key;
{
    id value = [self tfy_nilOrObjectForKey:key];
    
    if ([value isKindOfClass:[NSString class]])
    {
        return [NSDate tfy_dateWithJSONString:value allowPlaceholder:YES];
    }
    else if ([value isKindOfClass:[NSDate class]])
    {
        return value;
    }
    else
    {
        return nil;
    }
}

/**
 类似于-objectForKey:，但总是返回一个字符串，如果没有带有该键的对象则返回nil。使用-description将任何非字符串类型转换为字符串等效类型。
*/

- (NSString *)tfy_descriptionForKey:(id)key;
{
    return [self[key] description];
}

/**
 返回解释为字符串的对象的长度。参见下面的-containsSomethingForKey:。
*/

- (NSInteger)tfy_stringLengthForKey:(id)key;
{
    return [[self tfy_descriptionForKey:key] length];
}

/**
 如果被解释为字符串的对象非空，即非nil和@""，则返回YES。参见上面的-stringLengthForKey:。
*/

- (BOOL)tfy_containsSomethingForKey:(id)key;
{
    return ([[self tfy_descriptionForKey:key] length] > 0);
}

/**
 如果没有与aKey相关的值，则返回一个带有aDefault布尔值的NSNumber。
*/

- (id)tfy_objectForKey:(id)aKey orBool:(BOOL)aDefault;
{
    id value = self[aKey];
    
    if (!value)
        value = @(aDefault);
    
    return value;
}

/**
 如果没有与aKey相关的值，则返回一个带有aDefault整型的NSNumber。
*/

- (id)tfy_objectForKey:(id)aKey orInteger:(BOOL)aDefault;
{
    id value = self[aKey];
    
    if (!value)
        value = @(aDefault);
    
    return value;
}

/**
 返回给定键值的条目值，如果没有与aKey相关联的值，则返回默认值。
*/

- (id)tfy_objectForKey:(id)aKey defaultValue:(id)aDefault;
{
    id value = self[aKey];
    
    if (!value)
        value = aDefault;
    
    return value;
}

/**
 给定一个对象，返回它在接收器中第一次出现的键，如果它为nil或不存在，则返回nil。[一旦10.6是最小值，可能想要使用- keysofentrespassingtest:来代替更大的灵活性。]
*/

- (id)tfy_keyForObject:(id)anObject;
{
    if (!anObject)
        return nil;
    
    for (NSString *key in self)
        if ([self[key] isEqual:anObject])
            return key;
    
    return nil;
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSMutableDictionary (Dejal)

/**
 用指定的键在可变字典中设置一个NSNumber值。
*/

- (void)tfy_setBool:(BOOL)value forKey:(id)key;
{
    self[key] = @(value);
}

/**
 用指定的键在可变字典中设置一个NSNumber值。
 */

- (void)tfy_setInteger:(NSInteger)value forKey:(id)key;
{
    self[key] = @(value);
}

/**
 用指定的键在可变字典中设置一个NSNumber值。
 */

- (void)tfy_setFloat:(CGFloat)value forKey:(id)key;
{
    self[key] = @(value);
}

/**
 用指定的键在可变字典中设置一个NSNumber值。
*/

- (void)tfy_setTimeInterval:(NSTimeInterval)value forKey:(id)key
{
    self[key] = @(value);
}

/**
 用指定的键设置可变字典中NSDate值的json兼容字符串表示形式。
 */

- (void)tfy_setJSONDate:(NSDate *)value forKey:(id)key removeIfNil:(BOOL)removeIfNil;
{
    if (value != nil && ![value isKindOfClass:[NSDate class]])
    {
        NSLog(@"Detected non-date value: %@; this will crash", value);  // log
    }
    
    [self tfy_setObject:value.tfy_JSONStringValue forKey:key removeIfNil:removeIfNil];
}

/**
 如果没有为该键设置对象，则设置默认值。如果已经有值，则不执行任何操作。
*/

- (void)tfy_setDefaultValue:(id)aDefault forKey:(id)aKey;
{
    if (!self[aKey])
        self[aKey] = aDefault;
}

/**
 向接收端添加一个条目，该条目由aKey和它对应的值对象anObject组成。如果object为nil，则改为设置默认值;如果两个对象都为nil，则不执行任何操作。
*/

- (void)tfy_setObject:(id)anObject forKey:(id)aKey defaultValue:(id)aDefault;
{
    if (anObject)
        self[aKey] = anObject;
    else if (aDefault)
        self[aKey] = aDefault;
}

/**
 向接收端添加一个条目，该条目由aKey和它对应的值对象anObject组成。如果object为nil且removeIfNil为YES，则键将从接收者中移除，如果已经存在，否则什么也不会发生;当对象可能为nil时，有助于避免异常。注意:使用YES对removeIfNil调用此函数等价于使用-setValue:forKey:，所以最好使用它。
*/

- (void)tfy_setObject:(id)anObject forKey:(id)aKey removeIfNil:(BOOL)removeIfNil;
{
    if (anObject)
        self[aKey] = anObject;
    else if (removeIfNil)
        [self removeObjectForKey:aKey];
}

/**
 如果接收端中存在oldObject，则将其替换为newObject，否则无效。只替换第一个发生的事件[如果将来需要的话，可以添加一个参数替换所有事件]。
*/

- (void)tfy_replaceObject:(id)oldObject withObject:(id)newObject;
{
    NSString *key = [self tfy_keyForObject:oldObject];
    
    if (key && newObject)
        self[key] = newObject;
}

@end

