//
//  NSObject+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSObject+Dejal.h"
#import <objc/message.h>

@implementation NSObject (Dejal)


// ----------------------------------------------------------------------------------------
#pragma mark - KEY VALUE CODING METHODS
// ----------------------------------------------------------------------------------------


/**
 返回键路径的值，如果键路径无效则返回默认值(而不是抛出异常)。

 keyPath该值的路径。
 defaultValue如果路径无效或为NSNull时使用的值;可能是零。
 路径中的值，或者defaultValue。
 */

- (id)tfy_valueForKeyPath:(NSString *)keyPath defaultValue:(id)defaultValue;
{
    id result = nil;
    
    @try
    {
        result = [self valueForKeyPath:keyPath];
        
        if (!result || [result isEqual:[NSNull null]])
            result = defaultValue;
    }
    
    @catch (NSException *exception)
    {
        result = defaultValue;
    }
    
    return result;
}

/**
 尝试通过键从字典中获取一个值。如果找到一个值，则使用相同的键在接收器中设置它，否则不做任何更改。用于从字典中设置属性。
*/

- (void)tfy_setValueForKey:(NSString *)key withDictionary:(NSDictionary *)dict;
{
    id value = dict[key];
    
    if (value)
        [self setValue:value forKey:key];
}

/**
 尝试通过第一个键从字典中获取一个值。如果没有，试试另一个键。如果找到一个值，则使用第一个键在接收器中设置它，否则不做任何更改。用于从字典中设置属性。
*/

- (void)tfy_setValueForKey:(NSString *)key orDictKey:(NSString *)altKey withDictionary:(NSDictionary *)dict;
{
    id value = dict[key];
    
    if (!value && altKey)
        value = dict[altKey];
    
    if (value)
        [self setValue:value forKey:key];
}

/**
 尝试通过第一个键从字典中获取一个值。如果没有，则尝试其他键，直到找到值。如果找到一个值，则使用第一个键在接收器中设置它，否则不做任何更改。用于从字典中设置属性。
*/

- (void)tfy_setValueForKey:(NSString *)key orDictKeys:(NSArray *)altKeys withDictionary:(NSDictionary *)dict;
{
    id value = dict[key];
    
    if (!value && altKeys)
    {
        for (NSString *altKey in altKeys)
            if (!value)
	            value = dict[altKey];
    }
    
    if (value)
        [self setValue:value forKey:key];
}

/**
 如果接收器中有指定键的值，则在字典中设置该值，否则不执行任何操作。
*/

- (void)tfy_setValueInDictionary:(NSMutableDictionary *)dict forKey:(NSString *)key;
{
    [self tfy_setValueInDictionary:dict forKey:key removeIfNil:NO];
}

/**
 如果接收方中有指定键的值，则在字典中设置。如果没有值，则可选地从字典中删除键。传递YES相当于调用[dict setValue:[self valueForKey:key] forKey:key]。
*/

- (void)tfy_setValueInDictionary:(NSMutableDictionary *)dict forKey:(NSString *)key removeIfNil:(BOOL)removeIfNil;
{
    id value = [self valueForKey:key];
    
    if (value)
        dict[key] = value;
    else if (removeIfNil)
        [dict removeObjectForKey:key];
}


// ----------------------------------------------------------------------------------------
#pragma mark - IDENTITY METHODS
// ----------------------------------------------------------------------------------------


/**
 如果接收者是aClass的子类的实例，而不是aClass本身的实例，则返回YES。
*/

- (BOOL)tfy_isReallySubclassOfClass:(Class)aClass
{
    return [self isKindOfClass:aClass] && ![self isMemberOfClass:aClass];
}


/**
 类似于-isEqual，但如果接收方和另一个对象都被解释为不区分大小写的字符串时相等，则返回YES。因此，例如，@"THIS"和@"THIS"是等价的，@"123"和[NSNumber numberWithInteger:123]是等价的。如果另一个对象为nil，则返回NO;也就是说，一个非nil的接收者并不等于一个nil值(但是，当然，将这个发送给nil对象将导致0，如果另一个对象也是nil，这将是不正确的)。
*/

- (BOOL)tfy_isEquivalent:(id)anObject
{
    if (anObject)
        return ([[self description] caseInsensitiveCompare:[anObject description]] == NSOrderedSame);
    else
        return NO;
}

/**
 -isEquivalent:的别名，当“To”更有意义时。为了提高效率，逻辑是重复的。
*/

- (BOOL)tfy_isEquivalentTo:(id)anObject
{
    if (anObject)
        return ([[self description] caseInsensitiveCompare:[anObject description]] == NSOrderedSame);
    else
        return NO;
}


// ----------------------------------------------------------------------------------------
#pragma mark - PERFORM SELECTOR METHODS
// ----------------------------------------------------------------------------------------


/**
 类似于-performSelector:，但是调用一个返回布尔值的方法。如果接收者没有响应该选择器，则返回NO。
 */

- (BOOL)tfy_performBoolSelector:(SEL)selector;
{
    return [self tfy_performIntegerSelector:selector withObject:[NSNull null] withObject:[NSNull null]];
}

/**
 类似于-performSelector:withObject:，但是调用一个返回布尔值的方法。如果接收者没有响应该选择器，则返回NO。
 */

- (BOOL)tfy_performBoolSelector:(SEL)selector withObject:(__unsafe_unretained id)object;
{
    return [self tfy_performIntegerSelector:selector withObject:object withObject:[NSNull null]];
}

/**
 类似于-performSelector:withObject:withObject:，但是调用一个返回布尔值的方法。如果接收者没有响应该选择器，则返回NO。
 */

- (BOOL)tfy_performBoolSelector:(SEL)selector withObject:(__unsafe_unretained id)object1 withObject:(__unsafe_unretained id)object2;
{
    return [self tfy_performIntegerSelector:selector withObject:object1 withObject:object2];
}

/**
 类似于-performSelector:，但是调用一个返回整数值的方法。如果接收者没有响应该选择器，则返回0。
*/

- (NSInteger)tfy_performIntegerSelector:(SEL)selector
{
    return [self tfy_performIntegerSelector:selector withObject:[NSNull null] withObject:[NSNull null]];
}

/**
 类似于-performSelector:withObject:，但是调用一个返回整数值的方法。如果接收者没有响应该选择器，则返回0。
*/

- (NSInteger)tfy_performIntegerSelector:(SEL)selector withObject:(__unsafe_unretained id)object
{
    return [self tfy_performIntegerSelector:selector withObject:object withObject:[NSNull null]];
}

/**
 类似于-performSelector:withObject:withObject:，但是调用一个返回整数值的方法。如果selector为nil或接收者没有响应该selector，则不执行任何操作(并返回0)。
*/

- (NSInteger)tfy_performIntegerSelector:(SEL)selector withObject:(__unsafe_unretained id)object1 withObject:(__unsafe_unretained id)object2
{
    if (!selector || ![self respondsToSelector:selector])
        return 0;
    
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    NSInteger result = 0;
    
    [invocation setSelector:selector];
    
    if (![object1 isKindOfClass:[NSNull class]])
        [invocation setArgument:&object1 atIndex:2];
    
    if (![object2 isKindOfClass:[NSNull class]])
        [invocation setArgument:&object2 atIndex:3];
    
    [invocation invokeWithTarget:self];
    [invocation getReturnValue:&result];
    
    return result;
}

/**
 类似于-performSelector:withObject:，但允许任意数量的参数。参数按顺序从数组中取出。选择器应该期望相同数量的参数。参数为nil是可以的，如果选择器不接受任何参数。如果selector为nil，或者selector和数组的参数数目不同，则不执行任何操作。
*/

- (void)tfy_performSelector:(SEL)selector withArguments:(NSArray *)arguments;
{
    if (!selector)
        return;
    
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    // 排除隐藏的self和_cmd参数:
    if (([signature numberOfArguments] - 2) != [arguments count])
    {
        NSLog(@"performSelector:%@ withObjects:%@ has different number of arguments", NSStringFromSelector(selector), arguments);         // log
        
        return;
    }
    
    [invocation setSelector:selector];
    
    for (NSUInteger i = 0; i < [arguments count]; i++)
    {
        __unsafe_unretained id object = arguments[i];
        
        [invocation setArgument:&object atIndex:i + 2];
    }
    
    [invocation invokeWithTarget:self];
}

/**
 调用选择器，将数组中的每个对象作为参数传递。与-[NSArray makeObjectsPerformSelector:]不同，因为它使数组中的对象执行选择器，而不是使接收对象执行选择器。选择器必须接受一个参数。
*/

- (void)tfy_performSelector:(SEL)selector withEachObjectInArray:(NSArray *)array
{
    id object;
    
    for (object in array)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector withObject:object];
#pragma clang diagnostic pop
    }
}

/**
 调用选择器，将字典中的每个对象作为参数传递。调用的顺序没有定义。更多信息参见-performSelector:withEachObjectInArray:。
*/

- (void)tfy_performSelector:(SEL)selector withEachObjectInDictionary:(NSDictionary *)dict
{
    [self tfy_performSelector:selector withEachObjectInArray:[dict allValues]];
}

/**
 调用选择器，将集合中的每个对象作为参数传递。调用的顺序没有定义。更多信息参见-performSelector:withEachObjectInArray:。
*/

- (void)tfy_performSelector:(SEL)selector withEachObjectInSet:(NSSet *)set
{
    [self tfy_performSelector:selector withEachObjectInArray:[set allObjects]];
}

+ (void)tfy_exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {
    
    Method originalMethod = class_getInstanceMethod(anClass, method1Sel);
    Method swizzledMethod = class_getInstanceMethod(anClass, method2Sel);
    
    BOOL didAddMethod =
    class_addMethod(anClass,
                    method1Sel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(anClass,
                            method2Sel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end

