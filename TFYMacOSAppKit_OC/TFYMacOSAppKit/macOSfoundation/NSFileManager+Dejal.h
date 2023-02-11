//
//  NSFileManager+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//
#import <Cocoa/Cocoa.h>

@interface NSFileManager (Dejal)

- (NSInteger)tfy_fileSizeAtPath:(NSString *)path;
- (NSDate *)tfy_fileCreationDateAtPath:(NSString *)path;
- (NSDate *)tfy_fileModificationDateAtPath:(NSString *)path;

- (BOOL)tfy_isDirectoryAtURL:(NSURL *)url;
- (BOOL)tfy_isDirectoryAtPath:(NSString *)path;

- (BOOL)tfy_renameItemAtURL:(NSURL *)url toFilename:(NSString *)filename deleteExisting:(BOOL)deleteExisting error:(NSError **)error;
- (BOOL)tfy_renameItemAtPath:(NSString *)path toFilename:(NSString *)filename deleteExisting:(BOOL)deleteExisting error:(NSError **)error;

- (BOOL)tfy_renameWorkingFile:(NSString *)workingPath forSuccess:(BOOL)success error:(NSError **)error;


- (BOOL)tfy_removeFileIfExistsAtPath:(NSString *)path;

+ (BOOL)tfy_backupPath:(NSString *)path;
- (BOOL)tfy_copyPath:(NSString *)path withSuffix:(NSString *)suffix replaceExisting:(BOOL)replace error:(NSError **)error;

- (NSArray *)tfy_pathsWithFragments:(NSArray *)fragments isExtension:(BOOL)isExtension
                         atPath:(NSString *)basePath deepScan:(BOOL)deep;
- (NSArray *)tfy_pathsAtPath:(NSString *)basePath deepScan:(BOOL)deep;
- (NSArray *)tfy_pathsWithExtensions:(NSArray *)extensions atPath:(NSString *)basePath deepScan:(BOOL)deep;
- (NSArray *)tfy_pathsWithExtension:(NSString *)extension atPath:(NSString *)basePath deepScan:(BOOL)deep;
- (NSArray *)tfy_pathsWithFilenames:(NSArray *)filenames atPath:(NSString *)basePath deepScan:(BOOL)deep;
- (NSArray *)tfy_pathsWithFilename:(NSString *)filename atPath:(NSString *)basePath deepScan:(BOOL)deep;

@end

