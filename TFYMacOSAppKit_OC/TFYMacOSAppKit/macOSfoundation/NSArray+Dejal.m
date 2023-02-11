//
//  NSArray+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSArray+Dejal.h"
#import "NSObject+Dejal.h"


@implementation NSArray (Dejal)

/**
 如果索引在接收方可接受的范围内，则返回YES，否则返回NO。如果在返回NO时使用-objectAtIndex:或类似的索引，则会得到异常。
*/

- (BOOL)tfy_isValidIndex:(NSUInteger)i
{
    return (i < [self count]);
}

/**
 返回第一个字典对象，其中指定键的值与匹配值相等(参见-isEquivalentTo:)，如果没有匹配值则为nil。适用于基于字典值查找对象的常见模式。请参见下面的-indexOfObjectMatching:usingKey:， -objectMatching:usingSelector:和-arrayWithObjectsMatching:usingKey:。
*/

- (id)tfy_objectMatching:(id)match usingKey:(NSString *)key;
{
    __block id foundObject = nil;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj respondsToSelector:@selector(objectForKey:)] && [obj[key] tfy_isEquivalentTo:match])
         {
             foundObject = obj;
             *stop = YES;
         }
     }];
    
    return foundObject;
}

/**
 返回第一个字典对象的索引，其中指定键的值与匹配值相等(参见-isEquivalentTo:)，如果没有则返回NSNotFound。对于基于字典值查找对象索引的常见模式非常有用。请参见上面的-objectMatching:usingKey:和下面的-arrayWithObjectsMatching:usingKey:。
*/

- (NSUInteger)tfy_indexOfObjectMatching:(id)match usingKey:(NSString *)key
{
    return [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
     {
         return [obj respondsToSelector:@selector(objectForKey:)] && [obj[key] tfy_isEquivalentTo:match];
     }];
}

/**
 返回指定选择器的返回值与匹配值相等的第一个对象(参见-isEquivalentTo:)，如果没有则为nil。对于基于访问器值查找对象的常见模式非常有用。请参见下面的arrayWithObjectsMatching:usingSelector:。
*/

- (id)tfy_objectMatching:(id)match usingSelector:(SEL)selector;
{
    __block id foundObject = nil;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([[obj performSelector:selector] tfy_isEquivalentTo:match])
        {
            foundObject = obj;
            *stop = YES;
        }
#pragma clang diagnostic pop
     }];
    
    return foundObject;
}

/**
 返回指定选择器的返回值与匹配值相等的第一个对象(参见-isEquivalentTo:)。如果没有匹配，但指定了默认匹配值并且找到了匹配对象，则返回该值。如果不是，但firstIfNotFound为YES，则返回第一个对象。否则返回nil。对于基于访问器值查找对象和处理默认情况的常见模式非常有用。另请参阅上面的objectMatching:usingSelector:。
*/

- (id)tfy_objectMatching:(id)match orDefault:(id)defaultMatch orFirst:(BOOL)firstIfNotFound usingSelector:(SEL)selector
{
    if (!match && !defaultMatch && !firstIfNotFound)
    {
        // Short-circuit:
        return nil;
    }
    
    __block id foundObject = nil;
    __block id defaultObject = nil;
    __block id firstObject = nil;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
         id result = [obj performSelector:selector];
#pragma clang diagnostic pop
         // 这是我们想要的吗?
         if ([result tfy_isEquivalentTo:match])
         {
             foundObject = obj;
             *stop = YES;
         }
         
         // 是否指定了默认匹配，是该匹配吗?
         if (defaultMatch && [result tfy_isEquivalentTo:defaultMatch])
         {
             defaultObject = obj;
         }
         
         // 我们还没有注意到第一个问题吗?
         if (!firstObject && firstIfNotFound)
         {
             firstObject = obj;
         }
     }];
    
    if (foundObject)
    {
        return foundObject;
    }
    else if (defaultObject)
    {
        return defaultObject;
    }
    else if (firstObject)
    {
        return firstObject;
    }
    
    return nil;
}

/**
 返回响应-objectForKey:的所有对象的新数组，该方法的返回值相当于匹配值(参见-isEquivalentTo:)。如果没有，则返回一个空数组。用于在字典数组中查找对象的常见模式。参见上面的-objectMatching:usingKey:和-arrayWithObjectsMatching:usingSelector:。
*/

- (NSArray *)tfy_arrayWithObjectsMatching:(id)match usingKey:(NSString *)key
{
    __block NSMutableArray *array = [NSMutableArray array];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj respondsToSelector:@selector(objectForKey:)] && [obj[key] tfy_isEquivalentTo:match])
         {
             [array addObject:obj];
         }
     }];
    
    return array;
}

/**
 返回一个包含所有对象的新数组，其中指定的选择器的返回值与匹配值相等(参见-isEquivalentTo:)。如果没有，则返回一个空数组。对于基于访问器值查找对象的常见模式非常有用。请参见上面的-objectMatching:usingSelector:和下面的-arrayWithObjectsMatching:usingKey:。
*/

- (NSArray *)tfy_arrayWithObjectsMatching:(id)match usingSelector:(SEL)selector
{
    __block NSMutableArray *array = [NSMutableArray array];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
         if ([[obj performSelector:selector] tfy_isEquivalentTo:match])
         {
             [array addObject:obj];
         }
#pragma clang diagnostic pop
     }];
    
    return array;
}

/**
 返回一个新数组，其中包含由指定选择器为接收器中的每个对象返回的值。选择器通常是一个访问器，必须不带参数并返回一个对象值。
*/

- (NSArray *)tfy_arrayUsingSelector:(SEL)selector
{
    __block NSMutableArray *array = [NSMutableArray array];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
         [array addObject:[obj performSelector:selector]];
#pragma clang diagnostic pop
     }];
    
    return array;
}

/**
 返回一个新数组，其中包含除指定对象之外的所有接收器对象。
*/

- (NSArray *)tfy_arrayByRemovingObject:(id)object;
{
    NSMutableArray *array = [self mutableCopy];
    
    [array removeObject:object];
    
    return array;
}

/**
 返回一个新数组，其中包含除指定对象之外的所有接收器对象。
*/

- (NSArray *)tfy_arrayByRemovingObjectAtIndex:(NSUInteger)idx;
{
    NSMutableArray *array = [self mutableCopy];
    
    [array removeObjectAtIndex:idx];
    
    return array;
}

/**
 返回一个新数组，该数组只包含来自接收器的不属于另一个数组的对象。
*/

- (NSArray *)tfy_arrayByRemovingObjectsInArray:(NSArray *)otherArray
{
    NSMutableArray *array = [self mutableCopy];
    
    [array removeObjectsInArray:otherArray];
    
    return array;
}

/**
 返回接收器的反向版本。
*/

- (NSArray *)tfy_reverseArray;
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         [array addObject:obj];
     }];
    
    return array;
}

/**
 返回一个在查找器中排序的接收者的副本。
*/

- (NSArray *)tfy_sortedArrayUsingFinderOrder;
{
    return [self sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
}

/**
 给定一个属性键(即一个访问器名称)，返回按该值排序的接收器。(如果键的值不可能是唯一的，最好是手动执行，对两个键进行排序，从而避免对相同的主值进行随机排序。)
*/

- (NSArray *)tfy_sortedArrayUsingKey:(NSString *)key ascending:(BOOL)ascending;
{
    return [self sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:key ascending:ascending]]];
}

/**
 如果对象已经在数组中，则返回YES。
*/

- (BOOL)tfy_containsObjectIdenticalTo:(id)obj
{
    return [self indexOfObjectIdenticalTo:obj] != NSNotFound;
}

/**
 如果接收端包含一个与指定对象等价的对象，则返回YES。看到-isEquivalentTo:。
*/

- (BOOL)tfy_containsObjectEquivalentTo:(id)obj
{
    return [self tfy_indexOfObjectEquivalentTo:obj] != NSNotFound;
}

/**
 返回接收器中与指定对象等价的第一个对象的索引。如果没有找到，则返回NSNotFound。看到-isEquivalentTo:。
*/

- (NSUInteger)tfy_indexOfObjectEquivalentTo:(id)obj
{
    NSUInteger i = 0;
    id object = nil;
    BOOL found = NO;
    
    while (!found && i < [self count])
    {
        if ((object = self[i]))
            found = [object tfy_isEquivalentTo:obj];
        
        if (!found)
            i++;
    }
    
    if (found)
        return i;
    else
        return NSNotFound;
}

/**
 返回数组中在给定块中通过测试的第一个对象。

 要应用到数组中元素的块。
 接收器中通过谓词指定的测试的第一个对象。如果没有对象通过测试，则返回nil。
 */

- (id)tfy_objectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
{
    __block id foundObject = nil;
    
    [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
     {
         if (predicate(obj, idx, stop))
         {
             foundObject = obj;
             return YES;
         }
         
         return NO;
     }];
    
    return foundObject;
}

/**
 返回数组中倒数第二个对象，如果数组为空或只包含一个对象，则返回nil。
*/

- (id)tfy_penultimateObject
{
    NSUInteger numberOfItems = [self count];
    
    if (numberOfItems >= 2)
        return self[numberOfItems - 2];
    else
        return nil;
}

/**
 类似于-copy，但是数组中的每个对象也会被复制。注意，与-copy一样，数组也会被保留。
*/

- (id)tfy_deepCopy
{
    id array = [[NSMutableArray alloc] init];
    id copy;
    
    for (id object in self)
    {
        if ([object respondsToSelector:@selector(tfy_deepCopy)])
            copy = [object tfy_deepCopy];
        else
            copy = [object copy];
        
    	[array addObject:copy];
    }
    
    return array;
}

/**
 类似于上面的-deepCopy，但使字典的所有内容都是可变的。
 */

- (id)tfy_deepMutableCopy;
{
    id array = [[NSMutableArray alloc] init];
    id mutableCopy;
    
    for (id object in self)
    {
        if ([object respondsToSelector:@selector(tfy_deepMutableCopy)])
            mutableCopy = [object tfy_deepMutableCopy];
        else if ([object conformsToProtocol:@protocol(NSMutableCopying)])
            mutableCopy = [object mutableCopy];
        else
            mutableCopy = [object copy];
        
    	[array addObject:mutableCopy];
    }
    
    return array;
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSMutableArray (Dejal)

/**
 类似于-insertObject:atIndex:，但如果索引超出范围，则在末尾插入(如果atEnd为YES)或在开头插入(如果atEnd为NO)，而不是给出异常。返回插入对象的索引。
*/

- (NSUInteger)tfy_insertObject:(id)object atIndex:(NSUInteger)i orEnd:(BOOL)atEnd
{
    NSUInteger count = [self count];
    
    // 记住，索引可以等于count的-insertObject:atIndex:——这只是意味着之后插入，但在这里检查它，以防atEnd是NO:
    if (i > count)
    {
        if (atEnd)
            i = count;
        else
            i = 0;
    }
    
    [self insertObject:object atIndex:i];
    
    return i;
}

/**
 类似于-insertObject:atIndex:，但在索引位置插入多个对象。
*/

- (void)tfy_insertObjectsFromArray:(NSArray *)array atIndex:(NSUInteger)i
{
    id object;
    
    for (object in array)
    {
        [self insertObject:object atIndex:i++];
    }
}

/**
 将指定数组中的对象插入到索引位置，如果已存在，则将其从旧位置移除。如果索引无效，则将对象添加到数组中(而不是引起异常)。返回调整后的索引;如果一些旧索引在新索引之前，则会对其进行调整。
*/

- (NSUInteger)tfy_insertOrMoveObjectsFromArray:(NSArray *)array atIndex:(NSUInteger)i;
{
    id object;
    
    for (object in array)
    {
        NSUInteger existing = [self indexOfObject:object];
        
        if (existing != NSNotFound)
        {
            if (existing < i)
                i--;
            
            [self removeObjectAtIndex:existing];
        }
    }
    
    if ([self tfy_isValidIndex:i])
        [self tfy_insertObjectsFromArray:array atIndex:i];
    else
    {
        i = [array count];
        [self addObjectsFromArray:array];
    }
    
    return i;
}

/**
 从指定数组中添加对象，如果已存在，则将其从旧位置移除。
*/

- (void)tfy_addOrMoveObjectsFromArray:(NSArray *)array
{
    [self tfy_insertOrMoveObjectsFromArray:array atIndex:-1];
}

/**
 给定一个索引号数组的枚举数(例如，在NSTableView的-selectedRowsEnumerator中使用)，它将返回一个新的可变数组，其中包含来自接收器的相应对象。
*/

- (NSMutableArray *)tfy_arrayWithIndexEnumerator:(NSEnumerator *)enumerator
{
    NSMutableArray *array = [NSMutableArray array];
    NSNumber *i;
    
    while ((i = [enumerator nextObject]))
    {
        id object = self[[i integerValue]];
        
        if (object)
            [array addObject:object];
    }
    
    return array;
}

/**
 给定索引号数组的枚举数(例如，由-[NSTableView selectedRowsEnumerator]返回)，将从接收端删除相应的对象。
*/

- (void)tfy_removeObjectsFromIndexEnumerator:(NSEnumerator *)enumerator
{
    [self removeObjectsInArray:[self tfy_arrayWithIndexEnumerator:enumerator]];
}

/**
 给定一个要匹配的值和一个用于查找该值的键，这将从接收器中删除相应的对象。用于删除数组中具有匹配值的所有字典。
*/

- (void)tfy_removeObjectsMatching:(id)match usingKey:(NSString *)key
{
    [self removeObjectsInArray:[self tfy_arrayWithObjectsMatching:match usingKey:key]];
}

/**
 返回一个可变的反向版本的接收器。
*/

- (NSMutableArray *)tfy_reverseArray
{
    return [[super tfy_reverseArray] mutableCopy];
}

/**
 创建接收器的不可变副本，然后将选择器发送给数组中的每个对象。对于可变数组，应该使用-makeObjectsPerformSelector而不是-makeObjectsPerformSelector，因为如果数组在枚举过程中发生了突变(例如，作为选择器方法的副作用)，它们可能会引发异常。
*/

- (void)tfy_makeObjectsSafelyPerformSelector:(SEL)selector;
{
    NSArray *immutableArray = [self copy];
    
    [immutableArray makeObjectsPerformSelector:selector];
}

/**
 使用可变数组作为队列的方便方法;将对象添加到队列的末尾。
 */

- (void)tfy_enqueue:(id)obj;
{
    [self addObject:obj];
}

/**
 使用可变数组作为队列的方便方法;从队列中删除第一个对象并返回它。
 */

- (id)tfy_dequeue;
{
    id first = [self firstObject];
    
    if (first)
        [self removeObjectAtIndex:0];
    
    return first;
}

/**
 使用可变数组作为堆栈的方便方法;将对象添加到堆栈的顶部(末端)。
 */

- (void)tfy_push:(id)obj;
{
    [self addObject:obj];
}

/**
 使用可变数组作为堆栈的方便方法;从堆栈中移除顶部(结束)对象并返回它。
 */
- (id)tfy_pop;
{
    id last = [self lastObject];
    
    if (last)
        [self removeLastObject];
    
    return last;
}

@end

