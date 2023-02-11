//
//  NSFileManager+AppKit+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSFileManager+AppKit+Dejal.h"


@implementation NSFileManager (DejalAppKit)

/**
 如果指定的路径是目录，也可选不是文件包(bundle)，则返回YES，否则返回NO。
*/

- (BOOL)tfy_isDirectoryAtPath:(NSString *)path butNotPackage:(BOOL)notPackage;
{
    BOOL isDirectory = NO;
    
    if (![self fileExistsAtPath:path isDirectory:&isDirectory])
        return NO;
    
    if (notPackage)
        return (isDirectory && ![[NSWorkspace sharedWorkspace] isFilePackageAtPath:path]);
    else
        return isDirectory;
}


@end

