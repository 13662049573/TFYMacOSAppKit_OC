//
//  TFYOpenPanel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/17.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFYOpenPanel : NSObject

+(void)openPanelWithTitleMessage:(NSString *)ttMessage
                                setPrompt:(NSString *)prompt
                              chooseFiles:(BOOL)bChooseFiles
                        multipleSelection:(BOOL)bSelection
                        chooseDirectories:(BOOL)bChooseDirc
                        createDirectories:(BOOL)bCreateDirc
                          andDirectoryURL:(NSURL *)dirURL
                         AllowedFileTypes:(NSArray *)fileTypes
               completionHandler:(void (^)(NSOpenPanel *openpanel,NSArray<NSURL *> *URLs))handler;


//  Open Save Panel To Set Save File
+(void)savePanelWithTitleMessage:(NSString *)ttMessage
                                setPrompt:(NSString *)prompt
                                 setTitle:(NSString *)title
                           nameFiledValue:(NSString *)fileName
                        createDirectories:(BOOL)bCreateDirc
                   bSelectHiddenExtension:(BOOL)bSelectHiddenExtension
                          andDirectoryURL:(NSURL *)dirURL
                         AllowedFileTypes:(NSArray *)fileTypes
               completionHandler:(void (^)(NSSavePanel *savePanel,NSURL *URL))handler;


//  Open Save Panel To Set Save File
+(void)savePanelWithAllowedFileTypes:(NSArray *)fileTypes
                              titleMessage:(NSString *)ttMessage
                                 setPrompt:(NSString *)prompt
                         andAccessoryImage:(NSImage *)accessoryImage
                   completionHandler:(void (^)(NSSavePanel *savePanel,NSURL *URL))handler;

@end

NS_ASSUME_NONNULL_END
