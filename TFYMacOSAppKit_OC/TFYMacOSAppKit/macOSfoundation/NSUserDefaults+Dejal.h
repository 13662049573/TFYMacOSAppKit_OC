//
//  NSUserDefaults+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


@interface NSUserDefaults (Dejal)
/**
 返回给定键值的条目值，如果没有与aKey相关联的值，则返回默认值。
*/

- (id)tfy_objectForKey:(id)aKey defaultValue:(id)aDefault;
/**
 向接收端添加一个条目，该条目由aKey和它对应的值对象anObject组成。如果object为nil，则改为设置默认值;如果两个对象都为nil，则不执行任何操作。
*/
- (void)tfy_setObject:(id)anObject forKey:(id)aKey defaultValue:(id)aDefault;
/**
 向接收端添加一个条目，该条目由aKey和它对应的值对象anObject组成。如果object为nil且removeIfNil为YES，则键将从接收者中移除，如果已经存在，否则什么也不会发生;当对象可能为nil时，有助于避免异常。
*/
- (void)tfy_setObject:(id)anObject forKey:(id)aKey removeIfNil:(BOOL)removeIfNil;
/**
 给定一个任意对象，使其安全地存储在用户默认值中。数组和字典的层次结构被保留，它们的值被递归地清除。非属性列表对象目前只是作为它们的描述存储;这可以改进为编码为数据(如果对象支持编码)。

 任意对象或集合。
 只包含属性列表对象的对象或集合。
 */
- (id)tfy_sanitizeObject:(id)object;
/**
 给定一个任意对象，安全地将其设置在接收器中。数组和字典的层次结构被保留，它们的值被递归地清除。非属性列表对象目前只是作为它们的描述存储;这可以改进为编码为数据(如果对象支持编码)。

 任意对象或集合。
 key存储为的键。
 */
- (void)tfy_setArbitraryObject:(id)object forKey:(NSString *)key;
/**
 增加整数用户默认值的方便方法。
*/

- (NSInteger)tfy_incrementIntegerForKey:(NSString *)defaultName;
/**
 使用指定键从默认值返回一个时间间隔。如果该键没有首选项，则返回0。
*/

- (NSTimeInterval)tfy_timeIntervalForKey:(NSString *)defaultName;
/**
 使用指定键从默认值返回一个时间间隔。如果该键没有优先级，则返回指定的时间间隔。
*/
- (NSTimeInterval)tfy_timeIntervalForKey:(NSString *)defaultName orDefaultTimeInterval:(NSTimeInterval)defaultTimeInterval;
/**
 使用指定的键在默认值中存储指定的时间间隔。
*/

- (void)tfy_setTimeInterval:(NSTimeInterval)timeInterval forKey:(NSString *)defaultName;
/**
 给定一个用户默认键数组，返回出厂设置，即-registerDefaults:设置的值。
*/
- (NSDictionary *)tfy_factorySettingsForKeys:(NSArray *)keysArray;
/**
 给定一个用户默认键，如果该默认键已从出厂设置更改，即-registerDefaults:设置，则返回YES。
*/

- (BOOL)tfy_changedFromFactorySettingsForKey:(NSString *)key;
/**
 给定一个用户默认键数组，如果默认值已从其出厂设置更改，即由-registerDefaults:设置，则返回YES。
*/
- (BOOL)tfy_changedFromFactorySettingsForKeys:(NSArray *)keysArray;
/**
 给定一个用户默认键，将其值恢复到出厂设置，即-registerDefaults:设置的值。
*/
- (void)tfy_restoreFactorySettingsForKey:(NSString *)key;
/**
 给定一个用户默认键数组，将它们的所有值恢复到出厂设置，即-registerDefaults:设置的值。
 */
- (void)tfy_restoreFactorySettingsForKeys:(NSArray *)keysArray;
/**
 给定一个旧首选项的用户默认键和该首选项的新键，将对应的对象复制到新键。如果没有对象用旧钥匙，什么都不做。如果replace为NO，则如果新键的首选项已经存在，则不复制对象。如果复制了对象，则返回YES。
*/
- (BOOL)tfy_copyObjectForKey:(NSString *)oldKey toKey:(NSString *)newKey replace:(BOOL)replace;
/**
 给定新旧用户默认键对的数组，将对应的对象从旧键复制到新键。没有对象的旧键将被跳过。如果replace为NO，则包含现有对象的新键也将被跳过。如果复制了任何对象则返回YES。
*/

- (BOOL)tfy_copyObjectsForKeys:(NSArray *)keyPairsArray replace:(BOOL)replace;
/**
 将带有指定bundle标识符的首选项文件中的一个首选项复制到接收方的首选项。如果在另一个文件中没有设置首选项，则可以跳过或从接收方的首选项中删除它。
*/
- (void)tfy_copyPreferenceWithKey:(NSString *)preferenceKey fromBundleIdentifier:(NSString *)bundleIdentifier removeIfMissing:(BOOL)removeIfMissing;
/**
 用指定的包标识符从首选项文件复制任意数量的首选项到接收方的首选项。如果在另一个文件中没有设置首选项，则可以跳过或从接收方的首选项中删除它。
*/
- (void)tfy_copyPreferencesWithKeys:(NSArray *)preferenceKeys fromBundleIdentifier:(NSString *)bundleIdentifier removeIfMissing:(BOOL)removeIfMissing;

@end

