//
//  NSData+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSData+Dejal.h"


@implementation NSData (Dejal)

/**
 返回对象的存档呈现(它可以是任何符合NSCoding的对象，例如带有简单Cocoa对象的字典或数组)。使用下面的-object来解压缩对象。提供作为一个方便，因为这个功能似乎更合乎逻辑(对我来说)作为NSData的一部分。
*/

+ (NSData *)tfy_dataWithObject:(id)rootObject;
{
    return [NSKeyedArchiver archivedDataWithRootObject:rootObject requiringSecureCoding:YES error:nil];
}

/**
 返回已归档数据的对象再现。使用这个来平衡+dataWithObject:，上面。提供作为一个方便，因为这个功能似乎更合乎逻辑(对我来说)作为NSData的一部分。
*/

- (id)tfy_objectOfClass:(Class)class;
{
    id object = [NSKeyedUnarchiver unarchivedObjectOfClass:class fromData:self error:nil];
    return object;
}

@end

