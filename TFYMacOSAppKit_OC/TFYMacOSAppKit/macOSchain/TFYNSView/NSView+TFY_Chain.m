//
//  NSView+TFY_Chain.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "NSView+TFY_Chain.h"

#define TFY_CATEGORY_ADDVIEW(method, ModelClass, ViewClass)\
- (ModelClass * (^)(NSInteger tag))method    \
{   \
    return ^(NSInteger tag) {      \
        ViewClass *view = [[ViewClass alloc] init];       \
        [self addSubview:view];                            \
        ModelClass *chainModel = [[ModelClass alloc] initWithTag:tag andView:view modelClass:[ViewClass class]]; \
        return chainModel;      \
    };      \
}
#define TFY_CATEGORY_ADDLAYER(method, ModelClass, LayerClass)\
- (ModelClass * _Nonnull (^)(void))method{\
return ^ (){\
    LayerClass *layer = [LayerClass layer];\
    ModelClass *chainModel = [[ModelClass alloc] initWithLayer:layer modelClass:[LayerClass class]];\
    [self.layer addSublayer:layer];\
    return chainModel;\
};\
}

@implementation NSView (TFY_Chain)

TFY_CATEGORY_ADDVIEW(addControl, TFYControlChainModel, NSControl);
TFY_CATEGORY_ADDVIEW(addView, TFYViewChainModel, NSView);
TFY_CATEGORY_ADDVIEW(addScrollView, TFYScrollViewChainModel, NSScrollView);
TFY_CATEGORY_ADDVIEW(addBox, TFYBoxChainModel, NSBox);
TFY_CATEGORY_ADDVIEW(addCollection, TFYCollectionViewChainModel, NSCollectionView);
TFY_CATEGORY_ADDVIEW(addSplit, TFYSplitViewChainModel, NSSplitView);
TFY_CATEGORY_ADDVIEW(addGrid, TFYGridViewChainModel, NSGridView);
TFY_CATEGORY_ADDVIEW(addText, TFYTextViewChainModel, NSTextView);
TFY_CATEGORY_ADDVIEW(addTableCell, TFYTableCellViewChainModel, NSTableCellView);
TFY_CATEGORY_ADDVIEW(addRuler, TFYRulerViewChainModel, NSRulerView);
TFY_CATEGORY_ADDVIEW(addProgressIndicator, TFYProgressIndicatorViewChainModel, NSProgressIndicator);
TFY_CATEGORY_ADDVIEW(addVisualEffect, TFYVisualEffectViewChainModel, NSVisualEffectView);
TFY_CATEGORY_ADDVIEW(addStatusBarButton, TFYStatusBarButtonChainModel, NSStatusBarButton);
TFY_CATEGORY_ADDVIEW(addMatrix, TFYMatrixChainModel, NSMatrix);
TFY_CATEGORY_ADDVIEW(addBrowser, TFYBrowserChainModel, NSBrowser);
TFY_CATEGORY_ADDVIEW(addColorWell, TFYColorWellChainModel, NSColorWell);
TFY_CATEGORY_ADDVIEW(addImageView, TFYImageViewChainModel, NSImageView);
TFY_CATEGORY_ADDVIEW(addScroller, TFYScrollerChainModel, NSScroller);
TFY_CATEGORY_ADDVIEW(addSegmentedControl, TFYSegmentedControlChainModel, NSSegmentedControl);
TFY_CATEGORY_ADDVIEW(addSlider, TFYSliderChainModel, NSSlider);
TFY_CATEGORY_ADDVIEW(addSwitch, TFYSwitchChainModel, NSSwitch);
TFY_CATEGORY_ADDVIEW(addTextField, TFYTextFieldChainModel, NSTextField);
TFY_CATEGORY_ADDVIEW(addTokenField, TFYTokenFieldChainModel, NSTokenField);
TFY_CATEGORY_ADDVIEW(addComboBox, TFYComboBoxChainModel, NSComboBox);
TFY_CATEGORY_ADDVIEW(addSearchField, TFYSearchFieldChainModel, NSSearchField);
TFY_CATEGORY_ADDVIEW(addCustomizeTextField, TFYCustomizeTextFieldChainModel, TFYTextField);
TFY_CATEGORY_ADDVIEW(addSecureTextField, TFYSecureTextFieldChainModel, TFYSecureTextField);
TFY_CATEGORY_ADDVIEW(addLabelView, TFYLabelViewChainModel, TFYLabel);
TFY_CATEGORY_ADDVIEW(addComboButton, TFYComboButtonChainModel, NSComboButton);
TFY_CATEGORY_ADDVIEW(addTableView, TFYTableViewlChainModel, NSTableView);
TFY_CATEGORY_ADDVIEW(addOutline, TFYOutlineViewChainModel, NSOutlineView);
TFY_CATEGORY_ADDVIEW(addStepper, TFYStepperChainModel, NSStepper);
TFY_CATEGORY_ADDVIEW(addPathControl, TFYPathControlChainModel, NSPathControl);
TFY_CATEGORY_ADDVIEW(addRuleEditor, TFYRuleEditorChainModel, NSRuleEditor);
TFY_CATEGORY_ADDVIEW(addPredicateEditor, TFYPredicateEditorChainModel, NSPredicateEditor);
TFY_CATEGORY_ADDVIEW(addDatePicker, TFYDatePickerChainModel, NSDatePicker);
TFY_CATEGORY_ADDVIEW(addLevelIndicator, TFYLevelIndicatorChainModel, NSLevelIndicator);
TFY_CATEGORY_ADDVIEW(addCustomizeButton, TFYCustomizeButtonChainModel, TFYButton);

TFY_CATEGORY_ADDLAYER(addEmiiterLayer, TFYEmiiterLayerChainModel, CAEmitterLayer);
TFY_CATEGORY_ADDLAYER(addGradientLayer, TFYGradientLayerChainModel, CAGradientLayer);
TFY_CATEGORY_ADDLAYER(addLayer, TFYLayerChainModel, CALayer);
TFY_CATEGORY_ADDLAYER(addReplicatorLayer, TFYReplicatorLayerChainModel, CAReplicatorLayer);
TFY_CATEGORY_ADDLAYER(addScrollLayer, TFYScrollLayerChainModel, CAScrollLayer);
TFY_CATEGORY_ADDLAYER(addShaperLayer, TFYShaperLayerChainModel, CAShapeLayer);
TFY_CATEGORY_ADDLAYER(addTextLayer, TFYTextLayerChainModel, CATextLayer);
TFY_CATEGORY_ADDLAYER(addTiledLayer, TFYTiledLayerChainModel, CATiledLayer);

@end
#undef TFY_CATEGORY_ADDVIEW
#undef TFY_CATEGORY_ADDLAYER
