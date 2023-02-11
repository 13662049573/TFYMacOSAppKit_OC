//
//  NSUserDefaults+AppKit+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


@interface NSUserDefaults (DejalAppKit)

- (NSPoint)tfy_pointForKey:(NSString *)defaultName;
- (void)tfy_setPoint:(NSPoint)point forKey:(NSString *)defaultName;

- (NSSize)tfy_sizeForKey:(NSString *)defaultName orDefaultSize:(NSSize)defaultSize;
- (void)tfy_setSize:(NSSize)size forKey:(NSString *)defaultName;

- (NSColor *)tfy_colorForKey:(NSString *)defaultName;
- (void)tfy_setColor:(NSColor *)color forKey:(NSString *)defaultName;

- (NSColor *)tfy_grayForKey:(NSString *)defaultName;
- (void)tfy_setGray:(NSColor *)gray forKey:(NSString *)defaultName;

@end

