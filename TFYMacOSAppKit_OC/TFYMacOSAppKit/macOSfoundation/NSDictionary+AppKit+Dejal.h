//
//  NSDictionary+AppKit+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSDictionary+Dejal.h"


@interface NSDictionary (DejalAppKit)
/**
 给定一个颜色，返回它编码为字典，这样它就可以添加到默认值中，等等。
*/
+ (instancetype)tfy_dictionaryWithColor:(NSColor *)color;
/**
 从接收器的编码值中返回一个NSColor，该值必须由+dictionaryWithColor:编码，或者手动构造(例如在plist文件中)，以具有“Red”，“Green”，“Blue”和“Alpha”键，如果需要，可以省略任何一个键。
*/

- (NSColor *)tfy_color;
/**
 返回带有指定键的默认颜色。
*/
- (NSColor *)tfy_colorForKey:(id)key;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSMutableDictionary (DejalAppKit)
/**
 使用指定的键将指定的颜色存储在默认值中。
*/
- (void)tfy_setColor:(NSColor *)color forKey:(id)key;

@end

