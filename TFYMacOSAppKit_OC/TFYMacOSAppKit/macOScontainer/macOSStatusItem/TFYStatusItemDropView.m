//
//  TFYStatusItemDropView.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import "TFYStatusItemDropView.h"

@interface TFYStatusItemDropView ()<NSDraggingDestination>
@property (nonatomic, copy) NSArray *privateDropTypes;
@end

@implementation TFYStatusItemDropView

- (NSArray *)dropTypes {
    return self.privateDropTypes;
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    // 这里可以进行一些初步的准备工作，比如检查拖放是否可能被接受等
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    // 获取拖放的粘贴板数据
    NSPasteboard *pasteboard = [sender draggingPasteboard];

    NSString *type = [self dropTypeInPasteboardTypes:pasteboard.types];

    if (type) {
        NSArray *items = [pasteboard propertyListForType:type];
        if (self.dropHandler) {
            self.dropHandler(self.statusItem, type, items);
            return YES;
        }
    }
    return NO;
}

- (void)setDropTypes:(NSArray *)dropTypes {
    self.privateDropTypes = dropTypes;
    [self registerForDraggedTypes:self.privateDropTypes];
}

- (NSString *)dropTypeInPasteboardTypes:(NSArray *)pasteboardTypes {
    for (NSString *type in self.dropTypes) {
        if ([pasteboardTypes containsObject:type]) {
            return type;
        }
    }
    return nil;
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard = [sender draggingPasteboard];

    if ([self dropTypeInPasteboardTypes:pboard.types]) {
        return NSDragOperationCopy;
    }
    else {
        return NSDragOperationNone;
    }
}


@end
