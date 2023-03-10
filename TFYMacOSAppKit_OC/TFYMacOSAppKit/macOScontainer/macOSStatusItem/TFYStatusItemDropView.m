//
//  TFYStatusItemDropView.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import "TFYStatusItemDropView.h"

@interface TFYStatusItemDropView ()
@property (nonatomic, copy) NSArray *privateDropTypes;
@end

@implementation TFYStatusItemDropView

- (NSArray *)dropTypes {
    return self.privateDropTypes;
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

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard = [sender draggingPasteboard];
    NSString *type = [self dropTypeInPasteboardTypes:pboard.types];

    if (type) {
        NSArray *items = [pboard propertyListForType:type];
        if (self.dropHandler) {
            self.dropHandler(self.statusItem, type, items);
            return YES;
        }
    }
    return NO;
}


@end
