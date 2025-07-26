//
//  TFYStatusItemDropView.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import <Cocoa/Cocoa.h>
#import "TFYStatusItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYStatusItemDropView : NSView
@property (nonatomic, weak) TFYStatusItem *statusItem;
@property (nonatomic, copy) TFYStatusItemDropHandler dropHandler;
@property (nonatomic, copy) NSArray *dropTypes;
@end

NS_ASSUME_NONNULL_END
