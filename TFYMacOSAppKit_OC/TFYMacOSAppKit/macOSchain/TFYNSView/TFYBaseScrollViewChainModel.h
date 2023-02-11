//
//  TFYBaseScrollViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYBaseScrollViewChainModel<__covariant ObjectType> : TFYBaseViewChainModel<ObjectType>

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ documentView) (NSView*);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ contentView) (NSClipView*);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ documentCursor) (NSCursor*);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ borderType) (NSBorderType);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ backgroundColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ drawsBackground) (BOOL);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ hasVerticalScroller) (BOOL);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ hasHorizontalScroller) (BOOL);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ verticalScroller) (NSScroller*);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ horizontalScroller) (NSScroller*);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ autohidesScrollers) (BOOL);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ horizontalLineScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ verticalLineScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ lineScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ horizontalPageScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ verticalPageScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ pageScroll) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ contentSize) (CGSize);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ scrollsDynamically) (BOOL);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ scrollerStyle) (NSScrollerStyle);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ scrollerKnobStyle) (NSScrollerKnobStyle);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ horizontalScrollElasticity) (NSScrollElasticity);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ verticalScrollElasticity) (NSScrollElasticity);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ usesPredominantAxisScrolling) (BOOL);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ allowsMagnification) (BOOL);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ magnification) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ maxMagnification) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ minMagnification) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ automaticallyAdjustsContentInsets) (BOOL);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ contentInsets) (NSEdgeInsets);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ scrollerInsets) (NSEdgeInsets);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ rulersVisible) (BOOL);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ hasHorizontalRuler) (BOOL);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ hasVerticalRuler) (BOOL);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ horizontalRulerView) (NSRulerView*);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ verticalRulerView) (NSRulerView*);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ findBarPosition) (NSScrollViewFindBarPosition);

@end

NS_ASSUME_NONNULL_END
