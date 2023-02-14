//
//  TFYBaseViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseViewChainModel.h"
#import "TFYNSGesture.h"
#import "TFYChainBaseModel+TFY_Tools.h"
#import <objc/runtime.h>
#import "NSView+TFY_Tools.h"

#define TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, id,NSView)


#define  TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(TFYMethod,TFYParaType) \
- (id (^)(TFYParaType TFYMethod))TFYMethod    \
{   \
return ^id (TFYParaType TFYMethod) {    \
[self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {\
obj.layer.TFYMethod = TFYMethod;\
}];\
return self;    \
};\
}

@implementation TFYBaseViewChainModel

- (instancetype)initWithTag:(NSInteger)tag andView:(id)view modelClass:(nonnull Class)modelClass{
    if (self = [super initWithModelObject:view modelClass:modelClass]) {

    }
    return self;
}

#pragma mark - frame -

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(bounds, NSRect)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(frame, NSRect)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(preparedContentRect, NSRect)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(origin, NSPoint)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(x, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(y, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(size, CGSize)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(width, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(height, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(top, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(bottom, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(left, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(right, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(autoresizingMask, NSAutoresizingMaskOptions)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(autoresizesSubviews, BOOL)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(alphaValue, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(hidden, BOOL)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(postsFrameChangedNotifications, BOOL)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(frameRotation, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(frameCenterRotation, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(layerContentsPlacement, NSViewLayerContentsPlacement)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(layerContentsRedrawPolicy, NSViewLayerContentsRedrawPolicy)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(boundsRotation, CGFloat)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(canDrawConcurrently, BOOL)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(needsDisplay, BOOL)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(wantsRestingTouches, BOOL)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(wantsLayer, BOOL)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(layer, CALayer*)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(canDrawSubviewsIntoLayer, BOOL)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(needsLayout, BOOL)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(layerUsesCoreImageFilters, BOOL)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(backgroundFilters, NSArray<__kindof CIFilter *> *)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(compositingFilter, CIFilter *)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(contentFilters, NSArray<__kindof CIFilter *> *)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(shadow, NSShadow *)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(postsBoundsChangedNotifications, BOOL)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(toolTip, NSString *)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(userInterfaceLayoutDirection, NSUserInterfaceLayoutDirection)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(nextKeyView, NSView*)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(focusRingType, NSFocusRingType)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(additionalSafeAreaInsets, NSEdgeInsets)

TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION(allowedTouchTypes,NSTouchTypeMask)

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(masksToBounds, BOOL);

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(shadowColor, CGColorRef);

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(shadowOpacity, CGFloat);

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(shadowOffset, CGSize);

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(shadowRadius, CGFloat);

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(borderWidth, CGFloat);

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(borderColor, CGColorRef);

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(zPosition, CGFloat);

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(anchorPoint, CGPoint);

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(shouldRasterize, BOOL);

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(rasterizationScale, CGFloat);

TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION(shadowPath, CGPathRef);

- (NSView * _Nonnull (^)(NSInteger))viewWithTag {
    return ^ (NSInteger tag){
        NSView *view = [self.view viewWithTag:tag];
        return view;
    };
}

- (CGFloat (^)(void))visibleAlpha{
    return ^{
        return [self.view tfy_visibleAlpha];
    };
}

- (id  _Nonnull (^)(NSToolTipTag))removeToolTip{
    return ^(NSToolTipTag tag){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj removeToolTip:tag];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSView * _Nonnull))addToSuperView{
    return ^(NSView *superView){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [superView addSubview:obj];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(CALayer * _Nonnull))addToSublayer {
    return ^(CALayer *layer){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj.layer addSublayer:layer];
        }];
        return self;
    };
}

- (id _Nonnull (^)(id))contents {
    return ^(id contents) {
        [self enumerateObjectsUsingBlock:^(NSView *_Nonnull obj) {
            obj.layer.contents = contents;
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSView * _Nonnull))addSubView{
    return ^(NSView *subView){
        [self.view addSubview:subView];
        return self;
    };
}

- (id  _Nonnull (^)(NSSize))resizeSubviewsWithOldSize{
    return ^(NSSize oldSize){
        [self.view resizeSubviewsWithOldSize:oldSize];
        return self;
    };
}

- (id  _Nonnull (^)(NSSize))resizeWithOldSuperviewSize {
    return ^(NSSize oldSize){
        [self.view resizeWithOldSuperviewSize:oldSize];
        return self;
    };
}


- (id  _Nonnull (^)(NSGestureRecognizer * _Nonnull))addGesture{
    return ^(NSGestureRecognizer *ges){
        if (!ges) return self;
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj addGestureRecognizer:ges];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSGestureRecognizer * _Nonnull))removeGesture{
    return ^(NSGestureRecognizer *ges){
        if (!ges) return self;
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj removeGestureRecognizer:ges];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSGestureRecognizer * _Nonnull, NSString * _Nonnull))addGestureWithTag{
    return ^(NSGestureRecognizer *ges, NSString *tag){
        if (!tag) return self;
        NSMutableDictionary *dic = [self tfy_category_gestureDic];
        if ([dic.allKeys containsObject:tag]) {
            self.removeGestureByTag(tag);
        }
        self.addGesture(ges);
        [dic setObject:ges forKey:tag];
        return self;
    };
}

- (id  _Nonnull (^)(NSString * _Nonnull))removeGestureByTag{
    return ^(NSString *tag){
        if (!tag) return self;
        NSMutableDictionary *dic = [self tfy_category_gestureDic];
        NSGestureRecognizer *ges = [dic objectForKey:tag];
        self.removeGesture(ges);
        [dic removeObjectForKey:tag];
        return self;
    };
}

- (NSGestureRecognizer * (^)(NSString * ))getGestureByTag{
    return ^(NSString *tag){
        NSGestureRecognizer *ges;
        if (!tag) {
            NSMutableDictionary *dic = [self tfy_category_gestureDic];
            ges = [dic objectForKey:tag];
        }
        return ges;
    };
}

- (NSMutableDictionary *)tfy_category_gestureDic{
    NSMutableDictionary *_dic = objc_getAssociatedObject(self, @selector(tfy_category_gestureDic));
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(tfy_category_gestureDic), _dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _dic;
}

- (id  _Nonnull (^)(NSWindow * _Nonnull))viewWillMoveToWindow {
    return ^ (NSWindow *window){
        [self.view viewWillMoveToWindow:window];
        return self;
    };
}

- (id  _Nonnull (^)(NSView * _Nonnull))viewWillMoveToSuperview {
    return ^ (NSView *view){
        [self.view viewWillMoveToSuperview:view];
        return self;
    };
}

- (id  _Nonnull (^)(NSView * _Nonnull))didAddSubview {
    return ^ (NSView *view){
        [self.view didAddSubview:view];
        return self;
    };
}

- (id  _Nonnull (^)(NSView * _Nonnull))willRemoveSubview {
    return ^ (NSView *view){
        [self.view willRemoveSubview:view];
        return self;
    };
}

- (id  _Nonnull (^)(NSView * _Nonnull, NSView * _Nonnull))replaceSubview{
    return ^(NSView *v1, NSView *v2){
        [self.view replaceSubview:v1 with:v2];
        return self;
    };
}

- (id (^)(CGFloat cornerRadius))cornerRadius
{
    return ^__kindof TFYBaseViewChainModel *(CGFloat cornerRadius) {
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj.layer setCornerRadius:cornerRadius];
        }];
        return self;
    };
}

- (id (^)(CGFloat borderWidth, NSColor *borderColor))border
{
    return ^__kindof TFYBaseViewChainModel *(CGFloat borderWidth, NSColor *borderColor) {
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj.layer setBorderWidth:borderWidth];
            [obj.layer setBorderColor:borderColor.CGColor];
        }];
        
        return self;
    };
}

- (id (^)(CGSize shadowOffset, CGFloat shadowRadius, NSColor *shadowColor, CGFloat shadowOpacity))shadowlayer
{
    return ^ TFYBaseViewChainModel *(CGSize shadowOffset, CGFloat shadowRadius, NSColor *shadowColor, CGFloat shadowOpacity) {
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj.layer setShadowOffset:shadowOffset];
            [obj.layer setShadowRadius:shadowRadius];
            [obj.layer setShadowColor:shadowColor.CGColor];
            [obj.layer setShadowOpacity:shadowOpacity];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(float))layerOpacity {
    return ^ (float opacity){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            obj.layer.opacity = opacity;
        }];
        return self;
    };
}

- (id  _Nonnull (^)(BOOL))layerOpaque {
    return ^ (BOOL opaque){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            obj.layer.opaque = opaque;
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSColor * _Nonnull))layerBackGroundColor{
    return ^ (NSColor *color){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            obj.layer.backgroundColor = color.CGColor;
        }];
        return self;
    };
}


- (id  _Nonnull (^)(CATransform3D))layerTransform{
    return ^ (CATransform3D ta){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            obj.layer.transform = ta;
        }];
        
        return self;
    };
}

- (id  _Nonnull (^)(TFYAssignViewLoad _Nonnull))assignTo{
    return ^ (void (^assignTo)(id view)){
        if (assignTo) {
            assignTo(self.view);
        }
        assignTo = nil;
        return self;
    };
}

- (id  _Nonnull (^)(void))removeFormSuperView{
    return ^ (){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj removeFromSuperview];
        }];
        
        return self;
    };
}

- (id  _Nonnull (^)(NSPoint))setFrameOrigin{
    return ^ (NSPoint newOrigin){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj setFrameOrigin:newOrigin];
        }];
        return self;
    };
}

- (CGSize (^)(CGSize))sizeToFitSize{
    return ^ (CGSize size){
        return [self.view sizeThatFits:size];
    };
}

- (id (^)(CGRect))setNeedsDisplayRect{
    return ^ (CGRect rect){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj setNeedsDisplayInRect:rect];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSSize))setFrameSize{
    return ^ (NSSize newSize){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj setFrameSize:newSize];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSPoint))setBoundsOrigin{
    return ^ (NSPoint newOrigin){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj setBoundsOrigin:newOrigin];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSSize))setBoundsSize {
    return ^ (NSSize newSize){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj setBoundsSize:newSize];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSPoint))translateOriginToPoint{
    return ^ (NSPoint newOrigin){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj translateOriginToPoint:newOrigin];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSSize))scaleUnitSquareToSize {
    return ^ (NSSize newSize){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj scaleUnitSquareToSize:newSize];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(CGFloat))rotateByAngle{
    return ^ (CGFloat angle){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj rotateByAngle:angle];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(void))display{
    return ^ (){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj display];
        }];
        return self;
    };
}


- (id  _Nonnull (^)(void))displayIfNeeded{
    return ^ (){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj displayIfNeeded];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(void))displayIfNeededIgnoringOpacity{
    return ^ (){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj displayIfNeededIgnoringOpacity];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSRect))displayRect{
    return ^ (NSRect rect){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj displayRect:rect];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSRect))displayIfNeededInRect{
    return ^ (NSRect rect){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj displayIfNeededInRect:rect];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSRect))displayRectIgnoringOpacity{
    return ^ (NSRect rect){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj displayRectIgnoringOpacity:rect];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSRect))drawRect{
    return ^ (NSRect rect){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj drawRect:rect];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(NSRect))displayIfNeededInRectIgnoringOpacity{
    return ^ (NSRect rect){
        [self enumerateObjectsUsingBlock:^(NSView * _Nonnull obj) {
            [obj displayIfNeededInRectIgnoringOpacity:rect];
        }];
        return self;
    };
}

- (NSView *)view {
    return self.effectiveObjects.firstObject;
}

@end
#undef TFY_CATEGORY_CHAIN_MASONRY_IMPLEMENTATION

#undef TFY_CATEGORY_CHAIN_LAYER_IMPLEMENTATION
#undef TFY_CATEGORY_CHAIN_VIEW_IMPLEMENTATION

