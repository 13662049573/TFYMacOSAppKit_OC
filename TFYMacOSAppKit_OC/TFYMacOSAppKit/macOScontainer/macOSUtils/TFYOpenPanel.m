//
//  TFYOpenPanel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/17.
//

#import "TFYOpenPanel.h"

@implementation TFYOpenPanel

+(void)openPanelWithTitleMessage:(NSString *)ttMessage
                                setPrompt:(NSString *)prompt
                              chooseFiles:(BOOL)bChooseFiles
                        multipleSelection:(BOOL)bSelection
                        chooseDirectories:(BOOL)bChooseDirc
                        createDirectories:(BOOL)bCreateDirc
                          andDirectoryURL:(NSURL *)dirURL
                         AllowedFileTypes:(NSArray *)fileTypes
               completionHandler:(void (^)(NSOpenPanel *openpanel,NSArray<NSURL *> *URLs))handler;
{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setPrompt:prompt];
    [panel setMessage: ttMessage];
    [panel setCanChooseDirectories : bChooseDirc];
    [panel setCanChooseFiles : bChooseFiles];
    [panel setAllowsMultipleSelection : bSelection];
    [panel setAllowedFileTypes : fileTypes];
    [panel setDirectoryURL:dirURL];
   
    [panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            handler(panel,panel.URLs);
        }else if(result == NSModalResponseCancel) {
            handler(panel,panel.URLs);
        }
    }];
}

+(void)savePanelWithTitleMessage:(NSString *)ttMessage
                                setPrompt:(NSString *)prompt
                                 setTitle:(NSString *)title
                           nameFiledValue:(NSString *)fileName
                        createDirectories:(BOOL)bCreateDirc
                   bSelectHiddenExtension:(BOOL)bSelectHiddenExtension
                          andDirectoryURL:(NSURL *)dirURL
                         AllowedFileTypes:(NSArray *)fileTypes
                        completionHandler:(void (^)(NSSavePanel *savePanel,NSURL *URL))handler;
{
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setMessage:ttMessage];
    [panel setPrompt:prompt];
    [panel setAllowedFileTypes:fileTypes];
    [panel setCanCreateDirectories : bCreateDirc];
    [panel setCanSelectHiddenExtension : bSelectHiddenExtension];
    [panel setTitle:title];
    [panel setNameFieldStringValue:fileName];
    [panel setDirectoryURL:dirURL];
    [panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            handler(panel,panel.URL);
        }else if(result == NSModalResponseCancel) {
            handler(panel,panel.URL);
        }
    }];
}

//  Open Save Panel To Set Save File
+(void)savePanelWithAllowedFileTypes:(NSArray *)fileTypes
                              titleMessage:(NSString *)ttMessage
                                 setPrompt:(NSString *)prompt
                         andAccessoryImage:(NSImage *)accessoryImage
                            completionHandler:(void (^)(NSSavePanel *savePanel,NSURL *URL))handler;
{
    NSSavePanel *panel = [NSSavePanel savePanel];
    NSView *accessoryView = [[NSView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    NSImageView *accessoryImageView = [[NSImageView alloc]initWithFrame:accessoryView.frame];
    accessoryImageView.image = accessoryImage;
    accessoryImageView.wantsLayer = YES;
    accessoryImageView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    [accessoryView addSubview:accessoryImageView];
    [panel setAccessoryView:accessoryView];
    [panel setAllowedFileTypes:fileTypes];
    [panel setCanCreateDirectories : YES];
    [panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            handler(panel,panel.URL);
        }else if(result == NSModalResponseCancel) {
            handler(panel,panel.URL);
        }
    }];
}

@end
