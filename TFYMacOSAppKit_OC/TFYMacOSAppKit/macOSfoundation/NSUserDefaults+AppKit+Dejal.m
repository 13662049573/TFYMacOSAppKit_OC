//
//  NSUserDefaults+AppKit+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSUserDefaults+AppKit+Dejal.h"
#import "NSString+AppKit+Dejal.h"
#import "NSDictionary+AppKit+Dejal.h"


@implementation NSUserDefaults (DejalAppKit)

/**
 从默认值中返回具有指定键的点。
*/

- (NSPoint)tfy_pointForKey:(NSString *)defaultName;
{
    NSDictionary *dict = [self objectForKey:defaultName];
    NSPoint point = NSZeroPoint;
    
    if (dict)
    {
        point.x = [dict tfy_floatForKey:@"X"];
        point.y = [dict tfy_floatForKey:@"Y"];
    }
    
    return point;
}

/**
 使用指定的键在默认值中存储指定的点。
*/

- (void)tfy_setPoint:(NSPoint)point forKey:(NSString *)defaultName;
{
    NSDictionary *dict = @{@"X": @(point.x), @"Y": @(point.y)};
    
    [self setObject:dict forKey:defaultName];
}

/**
 使用指定的键从默认值返回一个大小。如果该键没有首选项，则返回指定的大小(例如NSZeroSize)。
*/

- (NSSize)tfy_sizeForKey:(NSString *)defaultName orDefaultSize:(NSSize)defaultSize;
{
    NSDictionary *dict = [self objectForKey:defaultName];
    NSSize size = defaultSize;
    
    if (dict)
    {
        size.width = [dict tfy_floatForKey:@"Width"];
        size.height = [dict tfy_floatForKey:@"Height"];
    }
    
    return size;
}

/**
 使用指定的键在默认值中存储指定的大小。
*/

- (void)tfy_setSize:(NSSize)size forKey:(NSString *)defaultName;
{
    NSDictionary *dict = @{@"Width": @(size.width), @"Height": @(size.height)};
    
    [self setObject:dict forKey:defaultName];
}

/**
 返回带有指定键的默认颜色。
*/

- (NSColor *)tfy_colorForKey:(NSString *)defaultName;
{
    NSString *value = [self stringForKey:defaultName];
    
    if (value)
        return [value tfy_color];
    else
        return nil;
}

/**
 使用指定的键将指定的颜色存储在默认值中。
*/

- (void)tfy_setColor:(NSColor *)color forKey:(NSString *)defaultName;
{
    [self setObject:[NSString tfy_stringWithColor:color] forKey:defaultName];
}

/**
 使用指定的键返回默认值的灰色阴影。
*/

- (NSColor *)tfy_grayForKey:(NSString *)defaultName;
{
    return [NSColor colorWithCalibratedWhite:[self floatForKey:defaultName] alpha:1.0];
}

/**
 使用指定的键在默认值中存储指定的灰色阴影。
*/

- (void)tfy_setGray:(NSColor *)gray forKey:(NSString *)defaultName;
{
    CGFloat grayFloat;

    [[gray colorUsingColorSpace:NSColorSpace.deviceGrayColorSpace] getWhite:&grayFloat alpha:NULL];
    [self setFloat:grayFloat forKey:defaultName];
}

@end

