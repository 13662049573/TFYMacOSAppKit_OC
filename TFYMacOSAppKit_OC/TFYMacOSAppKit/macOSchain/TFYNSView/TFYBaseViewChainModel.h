//
//  TFYBaseViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYChainBaseModel.h"

#define TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYModelType, TFYPropertyClass) TFY_CATEGORY_CHAIN_IMPLEMENTATION(TFYMethod,TFYParaType, TFYModelType, TFYPropertyClass)


#define TFY_CATEGORY_VIEW_IMPLEMENTATION(TFYMacOSClass, modelType)\
@interface modelType(EffectiveEXT)\
@property (nonatomic, strong, readonly) NSMutableArray <TFYMacOSClass *>* effectiveObjects;\
@end\
@implementation TFYMacOSClass (EXT)\
- (modelType *)makeChain{\
    return [[modelType alloc] initWithTag:self.tag andView:self modelClass:[TFYMacOSClass class]];\
}\
@end

NS_ASSUME_NONNULL_BEGIN

typedef void(^TFYAssignViewLoad)(__kindof NSView *view);

@interface TFYBaseViewChainModel<__covariant  ObjectType> : TFYChainBaseModel<ObjectType>

- (instancetype)initWithTag:(NSInteger)tag andView:(id)view modelClass:(Class)modelClass;

TFY_PROPERTY_STRONG_READONLY __kindof NSView *view;

TFY_PROPERTY_ASSIGN_READONLY Class viewClass;

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ bounds) (NSRect);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ preparedContentRect) (NSRect);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ frame) (NSRect);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ origin) (NSPoint);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ x) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ y) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ size) (CGSize);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ width) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ height) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ top) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ left) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ bottom) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ right) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY CGFloat (^ visibleAlpha) (void);

TFY_PROPERTY_CHAIN_READONLY NSView *(^ viewWithTag) (NSInteger);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ autoresizingMask) (NSAutoresizingMaskOptions);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ alphaValue) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ hidden) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ postsFrameChangedNotifications) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ autoresizesSubviews) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ frameRotation) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ frameCenterRotation) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ boundsRotation) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ layerContentsPlacement) (NSViewLayerContentsPlacement);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ layerContentsRedrawPolicy) (NSViewLayerContentsRedrawPolicy);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ canDrawConcurrently) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ needsDisplay) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ wantsRestingTouches) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ wantsLayer) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ layer) (CALayer *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ canDrawSubviewsIntoLayer) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ needsLayout) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ layerUsesCoreImageFilters) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ backgroundFilters) (NSArray<__kindof CIFilter *> *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ compositingFilter) (CIFilter *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ contentFilters) (NSArray<__kindof CIFilter *> *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadow) (NSShadow *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ postsBoundsChangedNotifications) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ toolTip) (NSString *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ removeToolTip) (NSToolTipTag);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addToSuperView) (NSView *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addToSublayer) (CALayer *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addSubView) (NSView *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addGesture) (NSGestureRecognizer *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addGestureBlock) (void (^ gestureBlock) (id));

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ contents) (id);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ removeGesture) (NSGestureRecognizer *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addGestureWithTag) (NSGestureRecognizer *, NSString *);

TFY_PROPERTY_STRONG_READONLY NSGestureRecognizer * (^ getGestureByTag) (NSString *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ removeGestureByTag) (NSString *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ viewWillMoveToWindow) (NSWindow *newWindow);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ viewWillMoveToSuperview) (NSView *newSuperview);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ didAddSubview) (NSView *);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ willRemoveSubview) (NSView *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ replaceSubview) (NSView *oldView, NSView *newView);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ userInterfaceLayoutDirection) (NSUserInterfaceLayoutDirection);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ nextKeyView) (NSView*);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ focusRingType) (NSFocusRingType);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ additionalSafeAreaInsets) (NSEdgeInsets);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ allowedTouchTypes) (NSTouchTypeMask);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ resizeSubviewsWithOldSize) (NSSize);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ resizeWithOldSuperviewSize)(NSSize);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shouldRasterize)(BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ layerOpacity)(float);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ layerBackGroundColor)(NSColor *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ layerOpaque)(BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ rasterizationScale)(CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ masksToBounds)(BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ cornerRadius)(CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ border)(CGFloat, NSColor *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ borderWidth)(CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ borderColor)(CGColorRef);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ zPosition)(CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ anchorPoint)(CGPoint);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadowlayer)(CGSize, CGFloat, NSColor *, CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadowColor)(CGColorRef);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadowOpacity)(CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadowOffset)(CGSize);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadowRadius)(CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ layerTransform)(CATransform3D);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadowPath) (CGPathRef);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ assignTo)(TFYAssignViewLoad);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ setFrameOrigin) (NSPoint);

TFY_PROPERTY_CHAIN_READONLY CGSize (^ sizeToFitSize) (CGSize);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ removeFormSuperView) (void);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ setFrameSize) (NSSize);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ setBoundsOrigin) (NSPoint);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ setBoundsSize) (NSSize);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ translateOriginToPoint) (NSPoint);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ scaleUnitSquareToSize) (NSSize);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ rotateByAngle) (CGFloat);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ display) (void);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ displayIfNeeded) (void);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ displayIfNeededIgnoringOpacity) (void);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ displayRect) (NSRect);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ displayIfNeededInRect) (NSRect);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ displayRectIgnoringOpacity) (NSRect);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ displayIfNeededInRectIgnoringOpacity) (NSRect);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ drawRect) (NSRect);

@end

NS_ASSUME_NONNULL_END
