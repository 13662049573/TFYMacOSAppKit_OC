//
//  NSArray+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

@import Foundation;


@interface NSArray (Dejal)

- (BOOL)tfy_isValidIndex:(NSUInteger)i;

- (id)tfy_objectMatching:(id)match usingKey:(NSString *)key;
- (NSUInteger)tfy_indexOfObjectMatching:(id)match usingKey:(NSString *)key;

- (id)tfy_objectMatching:(id)match usingSelector:(SEL)selector;
- (id)tfy_objectMatching:(id)match orDefault:(id)defaultMatch orFirst:(BOOL)firstIfNotFound usingSelector:(SEL)selector;

- (NSArray *)tfy_arrayWithObjectsMatching:(id)match usingKey:(NSString *)key;
- (NSArray *)tfy_arrayWithObjectsMatching:(id)match usingSelector:(SEL)selector;

- (NSArray *)tfy_arrayUsingSelector:(SEL)selector;

- (NSArray *)tfy_arrayByRemovingObject:(id)object;
- (NSArray *)tfy_arrayByRemovingObjectAtIndex:(NSUInteger)idx;
- (NSArray *)tfy_arrayByRemovingObjectsInArray:(NSArray *)otherArray;

- (NSArray *)tfy_reverseArray;

- (NSArray *)tfy_sortedArrayUsingFinderOrder;
- (NSArray *)tfy_sortedArrayUsingKey:(NSString *)key ascending:(BOOL)ascending;

- (BOOL)tfy_containsObjectIdenticalTo:(id)obj;
- (BOOL)tfy_containsObjectEquivalentTo:(id)obj;
- (NSUInteger)tfy_indexOfObjectEquivalentTo:(id)obj;

- (id)tfy_objectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;

- (id)tfy_penultimateObject;

- (id)tfy_deepCopy NS_RETURNS_RETAINED;
- (id)tfy_deepMutableCopy NS_RETURNS_RETAINED;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSMutableArray (Dejal)

- (NSUInteger)tfy_insertObject:(id)object atIndex:(NSUInteger)i orEnd:(BOOL)atEnd;
- (void)tfy_insertObjectsFromArray:(NSArray *)array atIndex:(NSUInteger)i;
- (NSUInteger)tfy_insertOrMoveObjectsFromArray:(NSArray *)array atIndex:(NSUInteger)i;
- (void)tfy_addOrMoveObjectsFromArray:(NSArray *)array;

- (NSMutableArray *)tfy_arrayWithIndexEnumerator:(NSEnumerator *)enumerator;

- (void)tfy_removeObjectsFromIndexEnumerator:(NSEnumerator *)enumerator;
- (void)tfy_removeObjectsMatching:(id)match usingKey:(NSString *)key;

- (NSMutableArray *)tfy_reverseArray;

- (void)tfy_makeObjectsSafelyPerformSelector:(SEL)selector;

- (void)tfy_enqueue:(id)obj;
- (id)tfy_dequeue;

- (void)tfy_push:(id)obj;
- (id)tfy_pop;

@end

