//
//  NSToolbar+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSToolbar (Dejal)

+ (CGFloat)tfy_toolbarHeightForWindow:(NSWindow *)window;

- (NSUInteger)tfy_indexOfFirstToolbarItemWithIdentifier:(NSString *)identifier;

@end

