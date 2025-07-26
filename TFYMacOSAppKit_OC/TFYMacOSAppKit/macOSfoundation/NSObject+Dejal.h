//
//  NSObject+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//
#import <Cocoa/Cocoa.h>

@interface NSObject (Dejal)

- (id)tfy_valueForKeyPath:(NSString *)keyPath defaultValue:(id)defaultValue;

- (void)tfy_setValueForKey:(NSString *)key withDictionary:(NSDictionary *)dict;
- (void)tfy_setValueForKey:(NSString *)key orDictKey:(NSString *)altKey withDictionary:(NSDictionary *)dict;
- (void)tfy_setValueForKey:(NSString *)key orDictKeys:(NSArray *)altKeys withDictionary:(NSDictionary *)dict;

- (void)tfy_setValueInDictionary:(NSMutableDictionary *)dict forKey:(NSString *)key;
- (void)tfy_setValueInDictionary:(NSMutableDictionary *)dict forKey:(NSString *)key removeIfNil:(BOOL)removeIfNil;

- (BOOL)tfy_isReallySubclassOfClass:(Class)aClass;

- (BOOL)tfy_isEquivalent:(id)anObject;
- (BOOL)tfy_isEquivalentTo:(id)anObject;

- (BOOL)tfy_performBoolSelector:(SEL)selector;
- (BOOL)tfy_performBoolSelector:(SEL)selector withObject:(__unsafe_unretained id)object;
- (BOOL)tfy_performBoolSelector:(SEL)selector withObject:(__unsafe_unretained id)object1 withObject:(__unsafe_unretained id)object2;

- (NSInteger)tfy_performIntegerSelector:(SEL)selector;
- (NSInteger)tfy_performIntegerSelector:(SEL)selector withObject:(__unsafe_unretained id)object;
- (NSInteger)tfy_performIntegerSelector:(SEL)selector withObject:(__unsafe_unretained id)object1 withObject:(__unsafe_unretained id)object2;

- (void)tfy_performSelector:(SEL)selector withArguments:(NSArray *)arguments;

- (void)tfy_performSelector:(SEL)selector withEachObjectInArray:(NSArray *)array;
- (void)tfy_performSelector:(SEL)selector withEachObjectInDictionary:(NSDictionary *)dict;
- (void)tfy_performSelector:(SEL)selector withEachObjectInSet:(NSSet *)set;

+ (void)tfy_exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;

@end

