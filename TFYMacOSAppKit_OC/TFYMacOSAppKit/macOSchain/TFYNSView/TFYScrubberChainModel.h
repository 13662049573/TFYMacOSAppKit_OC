//
//  TFYScrubberChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYScrubberChainModel;
@interface TFYScrubberChainModel : TFYBaseViewChainModel<TFYScrubberChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ dataSource) (id<NSScrubberDataSource>);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ delegate) (id<NSScrubberDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ scrubberLayout) (NSScrubberLayout*);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ selectedIndex) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ mode) (NSScrubberMode);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ itemAlignment) (NSScrubberAlignment);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ continuous) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ floatsSelectionViews) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ selectionBackgroundStyle) (NSScrubberSelectionStyle*);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ selectionOverlayStyle) (NSScrubberSelectionStyle*);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ showsArrowButtons) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ showsAdditionalContentIndicators) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ backgroundColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ backgroundView) (NSView*);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ insertItemsAtIndexes) (NSIndexSet*);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ removeItemsAtIndexes) (NSIndexSet*);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ reloadItemsAtIndexes) (NSIndexSet*);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ moveItemAtIndex_toIndex) (NSInteger,NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ scrollItemAtIndex_toAlignment) (NSInteger,NSScrubberAlignment);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ registerClass_forIdentifier) (Class,NSUserInterfaceItemIdentifier);
TFY_PROPERTY_CHAIN_READONLY TFYScrubberChainModel * (^ registerNib_forIdentifier) (NSNib*,NSUserInterfaceItemIdentifier);

@end
TFY_CATEGORY_EXINTERFACE(NSScrubber, TFYScrubberChainModel)
NS_ASSUME_NONNULL_END
