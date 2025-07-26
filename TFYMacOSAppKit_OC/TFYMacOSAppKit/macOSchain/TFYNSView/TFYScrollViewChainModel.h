//
//  TFYScrollViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYScrollViewChainModel;
@interface TFYScrollViewChainModel : TFYBaseViewChainModel<TFYScrollViewChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ documentView) (NSView*);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ contentView) (NSClipView*);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ documentCursor) (NSCursor*);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ borderType) (NSBorderType);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ backgroundColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ drawsBackground) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ hasVerticalScroller) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ hasHorizontalScroller) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ verticalScroller) (NSScroller*);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ horizontalScroller) (NSScroller*);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ autohidesScrollers) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ horizontalLineScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ verticalLineScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ lineScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ horizontalPageScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ verticalPageScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ pageScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ contentSize) (CGSize);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ scrollsDynamically) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ scrollerStyle) (NSScrollerStyle);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ scrollerKnobStyle) (NSScrollerKnobStyle);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ horizontalScrollElasticity) (NSScrollElasticity);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ verticalScrollElasticity) (NSScrollElasticity);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ usesPredominantAxisScrolling) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ allowsMagnification) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ magnification) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ maxMagnification) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ minMagnification) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ automaticallyAdjustsContentInsets) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ contentInsets) (NSEdgeInsets);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ scrollerInsets) (NSEdgeInsets);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ rulersVisible) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ hasHorizontalRuler) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ hasVerticalRuler) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ horizontalRulerView) (NSRulerView*);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ verticalRulerView) (NSRulerView*);
TFY_PROPERTY_CHAIN_READONLY TFYScrollViewChainModel * (^ findBarPosition) (NSScrollViewFindBarPosition);

@end
TFY_CATEGORY_EXINTERFACE(NSScrollView, TFYScrollViewChainModel)
NS_ASSUME_NONNULL_END
