//
//  TFYScrubberChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYScrubberChainModel.h"

#define TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYScrubberChainModel *,NSScrubber)

@implementation TFYScrubberChainModel

TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(dataSource, id<NSScrubberDataSource>)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(delegate, id<NSScrubberDelegate>)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(scrubberLayout, NSScrubberLayout *)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(selectedIndex, NSInteger)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(mode, NSScrubberMode)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(itemAlignment, NSScrubberAlignment)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(continuous, BOOL)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(floatsSelectionViews, BOOL)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(selectionBackgroundStyle, NSScrubberSelectionStyle*)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(selectionOverlayStyle, NSScrubberSelectionStyle*)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(showsArrowButtons, BOOL)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(showsAdditionalContentIndicators, BOOL)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(backgroundColor, NSColor*)
TFY_CATEGORY_CHAIN_SCRUBBER_IMPLEMENTATION(backgroundView, NSView*)

- (TFYScrubberChainModel * _Nonnull (^)(NSIndexSet*))insertItemsAtIndexes{
    return ^(NSIndexSet * indexes)
    {
        [self enumerateObjectsUsingBlock:^(NSScrubber * _Nonnull obj) {
            [obj insertItemsAtIndexes:indexes];
        }];
        return self;
    };
}

- (TFYScrubberChainModel * _Nonnull (^)(NSIndexSet*))removeItemsAtIndexes{
    return ^(NSIndexSet * indexes)
    {
        [self enumerateObjectsUsingBlock:^(NSScrubber * _Nonnull obj) {
            [obj removeItemsAtIndexes:indexes];
        }];
        return self;
    };
}

- (TFYScrubberChainModel * _Nonnull (^)(NSIndexSet*))reloadItemsAtIndexes{
    return ^(NSIndexSet * indexes)
    {
        [self enumerateObjectsUsingBlock:^(NSScrubber * _Nonnull obj) {
            [obj reloadItemsAtIndexes:indexes];
        }];
        return self;
    };
}

- (TFYScrubberChainModel * _Nonnull (^)(NSInteger,NSInteger))moveItemAtIndex_toIndex{
    return ^(NSInteger oldIndex,NSInteger newIndex)
    {
        [self enumerateObjectsUsingBlock:^(NSScrubber * _Nonnull obj) {
            [obj moveItemAtIndex:oldIndex toIndex:newIndex];
        }];
        return self;
    };
}

- (TFYScrubberChainModel * _Nonnull (^)(NSInteger,NSScrubberAlignment))scrollItemAtIndex_toAlignment{
    return ^(NSInteger index,NSScrubberAlignment alignment)
    {
        [self enumerateObjectsUsingBlock:^(NSScrubber * _Nonnull obj) {
            [obj scrollItemAtIndex:(NSInteger)index toAlignment:alignment];
        }];
        return self;
    };
}

- (TFYScrubberChainModel * _Nonnull (^)(Class,NSUserInterfaceItemIdentifier))registerClass_forIdentifier{
    return ^(Class itemViewClass,NSUserInterfaceItemIdentifier itemIdentifier)
    {
        [self enumerateObjectsUsingBlock:^(NSScrubber * _Nonnull obj) {
            [obj registerClass:itemViewClass forItemIdentifier:itemIdentifier];
        }];
        return self;
    };
}

- (TFYScrubberChainModel * _Nonnull (^)(NSNib*,NSUserInterfaceItemIdentifier))registerNib_forIdentifier{
    return ^(NSNib * nib,NSUserInterfaceItemIdentifier itemIdentifier)
    {
        [self enumerateObjectsUsingBlock:^(NSScrubber * _Nonnull obj) {
            [obj registerNib:nib forItemIdentifier:itemIdentifier];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSScrubber, TFYScrubberChainModel)
#undef TFY_CATEGORY_CHAIN_DATEPICKER_IMPLEMENTATION
