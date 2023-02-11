//
//  NSFileManager+AppKit+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSFileManager+Dejal.h"


@interface NSFileManager (DejalAppKit)

- (BOOL)tfy_isDirectoryAtPath:(NSString *)path butNotPackage:(BOOL)notPackage;


@end

