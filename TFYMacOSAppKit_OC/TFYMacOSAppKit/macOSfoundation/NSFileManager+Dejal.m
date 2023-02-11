//
//  NSFileManager+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSFileManager+Dejal.h"
#import "NSObject+Dejal.h"
#import "NSArray+Dejal.h"
#import "NSString+Dejal.h"


@implementation NSFileManager (Dejal)

/**
 方便方法返回指定路径中的文件大小。
*/

- (NSInteger)tfy_fileSizeAtPath:(NSString *)path
{
    NSDictionary *attributes = [self attributesOfItemAtPath:path error:nil];
    
    return [attributes[NSFileSize] integerValue];
}

/**
 方法返回路径中指定的文件的创建日期。
*/

- (NSDate *)tfy_fileCreationDateAtPath:(NSString *)path;
{
    NSDictionary *attributes = [self attributesOfItemAtPath:path error:nil];
    
    return attributes[NSFileCreationDate];
}

/**
 方法返回路径中指定的文件的修改日期。
*/

- (NSDate *)tfy_fileModificationDateAtPath:(NSString *)path;
{
    NSDictionary *attributes = [self attributesOfItemAtPath:path error:nil];
    
    return attributes[NSFileModificationDate];
}

/**
 如果指定的路径是目录，则返回YES，否则返回NO。
*/

- (BOOL)tfy_isDirectoryAtURL:(NSURL *)url;
{
    BOOL isDirectory = NO;
    
    return ([self fileExistsAtPath:url.path isDirectory:&isDirectory]) && isDirectory;
}

/**
 如果指定的路径是目录，则返回YES，否则返回NO。
*/

- (BOOL)tfy_isDirectoryAtPath:(NSString *)path;
{
    BOOL isDirectory = NO;
    
    return ([self fileExistsAtPath:path isDirectory:&isDirectory]) && isDirectory;
}

/**
 重命名URL中指定的文件或目录，使其在相同位置具有指定的文件名。如果deleteExisting为YES，并且目标已经存在，则首先删除它;否则将发生错误。有关处理程序参数和其他相关信息的详细信息，请参阅标准的-movePath:toPath:handler: method描述。
*/

- (BOOL)tfy_renameItemAtURL:(NSURL *)url toFilename:(NSString *)filename deleteExisting:(BOOL)deleteExisting error:(NSError **)error;
{
    NSURL *destination = [[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:filename];
    
    // 特殊情况:如果当前名称和文件名是等价的，即只是在情况下不同，删除将是错误的，移动将失败，所以我们需要更改名称:
    NSString *oldName = [url lastPathComponent];
    
    if ([oldName tfy_isEquivalentTo:filename])
    {
        NSURL *oldURL = url;
        NSString *tempName = [oldName stringByAppendingFormat:@"%.2f", [NSDate timeIntervalSinceReferenceDate]];
        
        url = [[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:tempName];
        
        [self moveItemAtURL:oldURL toURL:url error:error];
    }
    
    if (deleteExisting)
        [self removeItemAtURL:destination error:nil];
    
    return [self moveItemAtURL:url toURL:destination error:error];
}

/**
 重命名路径中指定的文件或目录，使其在相同位置具有指定的文件名。如果deleteExisting为YES，并且目标已经存在，则首先删除它;否则将发生错误。有关处理程序参数和其他相关信息的详细信息，请参阅标准的-movePath:toPath:handler: method描述。
*/

- (BOOL)tfy_renameItemAtPath:(NSString *)path toFilename:(NSString *)filename deleteExisting:(BOOL)deleteExisting error:(NSError **)error;
{
    NSString *destination = [[path stringByDeletingLastPathComponent] stringByAppendingPathComponent:filename];
    
    // 特殊情况:如果当前名称和文件名是等价的，即只是在情况下不同，删除将是错误的，移动将失败，所以我们需要更改名称:
    if ([[path lastPathComponent] tfy_isEquivalentTo:filename])
    {
        NSString *oldPath = path;
        
        path = [path stringByAppendingFormat:@"%.2f", [NSDate timeIntervalSinceReferenceDate]];
        
        [self moveItemAtPath:oldPath toPath:path error:error];
    }
    
    if (deleteExisting && [self fileExistsAtPath:destination])
        [self removeItemAtPath:destination error:error];
    
    return [self moveItemAtPath:path toPath:destination error:error];
}

/**
 给定一个工作文件，即在扩展名前以波浪号命名的文件(参见-[NSString backupFilePath])，交换工作文件和之前的最终文件(如果有的话)。
*/

- (BOOL)tfy_renameWorkingFile:(NSString *)workingPath forSuccess:(BOOL)success error:(NSError **)error;
{
    BOOL okay = YES;
    
    if (success)
    {
        NSString *basePath = [workingPath stringByDeletingLastPathComponent];
        NSString *extension = [workingPath pathExtension];
        NSString *workingFilename = [workingPath lastPathComponent];
        NSString *workingBase = [workingFilename stringByDeletingPathExtension];
        NSString *finalFilename = [workingBase substringToIndex:[workingBase length] - 1];
        NSString *tempFilename = [workingBase stringByAppendingString:@"~"];
        
        if ([extension length])
        {
            finalFilename = [finalFilename stringByAppendingPathExtension:extension];
            tempFilename = [tempFilename stringByAppendingPathExtension:extension];
        }
        
        NSString *finalPath = [basePath stringByAppendingPathComponent:finalFilename];
        NSString *tempPath = [basePath stringByAppendingPathComponent:tempFilename];
        
        // 重命名工作文件，在最后加一个波浪号:
        okay = [self tfy_renameItemAtPath:workingPath toFilename:tempFilename deleteExisting:YES error:error];
        
        // 将之前的文件重命名为工作文件:
        if ([self fileExistsAtPath:finalPath])
            okay = okay && [self tfy_renameItemAtPath:finalPath toFilename:workingFilename deleteExisting:NO error:error];
        
        // 将工作文件重命名为与前一个文件相同的文件:
        okay = okay && [self tfy_renameItemAtPath:tempPath toFilename:finalFilename deleteExisting:NO error:error];
    }
    else
    {
        // 失败了，所以直接删除工作文件:
        okay = [self removeItemAtPath:workingPath error:error];
    }
    
    return okay;
}


/**
 如果路径中存在文件或文件夹，则盲目删除。与使用-removeFileAtPath:handler:一样，使用此方法时要谨慎。如果文件不存在或已成功删除，则返回YES，如果无法删除则返回NO。
*/

- (BOOL)tfy_removeFileIfExistsAtPath:(NSString *)path
{
    if ([self fileExistsAtPath:path])
        return [self removeItemAtPath:path error:nil];
    else
        return YES;
}

/**
 方便类的方法复制带有“backup”后缀的路径，替换任何旧的备份。
*/

+ (BOOL)tfy_backupPath:(NSString *)path;
{
    return [[self defaultManager] tfy_copyPath:path withSuffix:@" backup" replaceExisting:YES error:nil];
}

/**
 类似于-copyFile:toPath:handler:，但只是使用与目标相同的路径，并附加了后缀。如果指定路径上不存在文件，或者后缀为空，则不执行任何操作。可选地首先删除新路径上的任何旧文件。这对于执行重复操作或备份文件或文件夹特别有用。
*/

- (BOOL)tfy_copyPath:(NSString *)path withSuffix:(NSString *)suffix replaceExisting:(BOOL)replace error:(NSError **)error;
{
    if ([self fileExistsAtPath:path] && [suffix length])
    {
        NSString *destPath = [[path stringByDeletingPathExtension] stringByAppendingString:suffix];
        destPath = [destPath stringByAppendingPathExtension:[path pathExtension]];
        
        if (replace)
            [self tfy_removeFileIfExistsAtPath:destPath];
        
        return [self copyItemAtPath:path toPath:destPath error:error];
    }
    else
        return NO;
}

/**
 给定一个文件名或扩展名数组(可以为nil或空)和一个目录路径，返回一个完整路径数组，其中包含该目录中的这些文件名或扩展名(如果没有提供片段，则返回所有文件)。如果deep为YES，则扫描所有子目录，否则只扫描基本目录。如果基路径不存在，或者不是目录，则返回nil。基本路径可以包含波浪号。请参见以下更具体的方法。
*/

- (NSArray *)tfy_pathsWithFragments:(NSArray *)fragments isExtension:(BOOL)isExtension
                         atPath:(NSString *)basePath deepScan:(BOOL)deep;
{
    basePath = [basePath tfy_expandedPath];
    BOOL isDirectory = NO;
    
    if (![self fileExistsAtPath:basePath isDirectory:&isDirectory] || !isDirectory)
        return nil;
    
    NSMutableArray *paths = [NSMutableArray array];
    NSArray *subpaths;
    
    if (deep)
        subpaths = [self subpathsAtPath:basePath];
    else
        subpaths = [self contentsOfDirectoryAtPath:basePath error:nil];
    
    subpaths = [subpaths tfy_sortedArrayUsingFinderOrder];
    
    for (NSString *subpath in subpaths)
    {
        NSString *want = isExtension ? [subpath pathExtension] : [subpath tfy_lastPathComponentWithoutExtension];
        
        if (!fragments || [fragments tfy_containsObjectEquivalentTo:want])
            [paths addObject:[basePath stringByAppendingPathComponent:subpath]];
    }
    
    return paths;
}

/**
 给定一个目录路径，返回该目录内完整路径的数组。如果deep为YES，则扫描所有子目录，否则只扫描基本目录。如果基路径不存在，或者不是目录，则返回nil。基本路径可以包含波浪号。
*/

- (NSArray *)tfy_pathsAtPath:(NSString *)basePath deepScan:(BOOL)deep;
{
    return [self tfy_pathsWithFragments:nil isExtension:NO atPath:basePath deepScan:deep];
}

/**
 给定一个扩展名数组(可能为nil或空)和一个目录路径，返回该目录中包含这些扩展名(如果没有提供扩展名，则返回所有文件)的完整路径数组。如果deep为YES，则扫描所有子目录，否则只扫描基本目录。如果基路径不存在，或者不是目录，则返回nil。基本路径可以包含波浪号。参见- pathswitheextension:atPath:deepScan:。
*/

- (NSArray *)tfy_pathsWithExtensions:(NSArray *)extensions atPath:(NSString *)basePath deepScan:(BOOL)deep
{
    return [self tfy_pathsWithFragments:extensions isExtension:YES atPath:basePath deepScan:deep];
}

/**
 给定一个扩展名(可能为nil或空)和一个目录路径，返回该目录中具有该扩展名(如果没有提供扩展名，则返回所有文件)的完整路径数组。如果deep为YES，则扫描所有子目录，否则只扫描基本目录。如果基路径不存在，或者不是目录，则返回nil。基本路径可以包含波浪号。参见-pathsWithExtensions:atPath:deepScan:。
*/

- (NSArray *)tfy_pathsWithExtension:(NSString *)extension atPath:(NSString *)basePath deepScan:(BOOL)deep
{
    NSArray *paths;
    
    if (![extension length])
        paths = [self tfy_pathsWithExtensions:nil atPath:basePath deepScan:deep];
    else
        paths = [self tfy_pathsWithExtensions:@[extension] atPath:basePath deepScan:deep];
    
    return paths;
}

/**
 给定一个没有扩展名的文件名数组(可能为nil或空)和一个目录路径，返回一个完整路径数组，其中包含该目录中的这些文件名(如果没有提供文件名，则返回所有文件)。如果deep为YES，则扫描所有子目录，否则只扫描基本目录。如果基路径不存在，或者不是目录，则返回nil。基本路径可以包含波浪号。参见-pathsWithFilename:atPath:deepScan:。
 */

- (NSArray *)tfy_pathsWithFilenames:(NSArray *)filenames atPath:(NSString *)basePath deepScan:(BOOL)deep
{
    return [self tfy_pathsWithFragments:filenames isExtension:NO atPath:basePath deepScan:deep];
}

/**
 给定一个没有扩展名的文件名(可能是nil或空白)和一个目录路径，返回该目录中具有该文件名(如果没有提供文件名，则返回所有文件)的完整路径数组。如果deep为YES，则扫描所有子目录，否则只扫描基本目录。如果基路径不存在，或者不是目录，则返回nil。基本路径可以包含波浪号。参见-pathsWithFilenames:atPath:deepScan:。
 */

- (NSArray *)tfy_pathsWithFilename:(NSString *)filename atPath:(NSString *)basePath deepScan:(BOOL)deep
{
    NSArray *paths;
    
    if (![filename length])
        paths = [self tfy_pathsWithFilenames:nil atPath:basePath deepScan:deep];
    else
        paths = [self tfy_pathsWithFilenames:@[filename] atPath:basePath deepScan:deep];
    
    return paths;
}

@end

