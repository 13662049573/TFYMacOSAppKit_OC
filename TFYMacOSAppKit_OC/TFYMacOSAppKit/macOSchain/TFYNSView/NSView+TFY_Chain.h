//
//  NSView+TFY_Chain.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import <Cocoa/Cocoa.h>
#import "TFYNSView.h"
#import "TFYNSGesture.h"
#import "CALayer+TFY_Chain.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSView (TFY_Chain)

TFY_PROPERTY_STRONG_READONLY TFYControlChainModel *(^ addControl)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYViewChainModel *(^ addView)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYScrollViewChainModel *(^ addScrollView)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYBoxChainModel *(^ addBox)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYCollectionViewChainModel *(^ addCollection)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYSplitViewChainModel *(^ addSplit)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYGridViewChainModel *(^ addGrid)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYTextViewChainModel *(^ addText)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYTableCellViewChainModel *(^ addTableCell)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYRulerViewChainModel *(^ addRuler)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYProgressIndicatorViewChainModel *(^ addProgressIndicator)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYVisualEffectViewChainModel *(^ addVisualEffect)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYStatusBarButtonChainModel *(^ addStatusBarButton)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYMatrixChainModel *(^ addMatrix)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYBrowserChainModel *(^ addBrowser)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYColorWellChainModel *(^ addColorWell)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYImageViewChainModel *(^ addImageView)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYScrollerChainModel *(^ addScroller)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYSegmentedControlChainModel *(^ addSegmentedControl)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYSliderChainModel *(^ addSlider)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYSwitchChainModel *(^ addSwitch)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYTextFieldChainModel *(^ addTextField)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYTokenFieldChainModel *(^ addTokenField)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYComboBoxChainModel *(^ addComboBox)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYSearchFieldChainModel *(^ addSearchField)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYCustomizeTextFieldChainModel *(^ addCustomizeTextField)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYSecureTextFieldChainModel *(^ addSecureTextField)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYLabelViewChainModel *(^ addLabelView)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYComboButtonChainModel *(^ addComboButton)(NSInteger) API_AVAILABLE(macos(13.0));
TFY_PROPERTY_STRONG_READONLY TFYTableViewlChainModel *(^ addTableView)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYOutlineViewChainModel *(^ addOutline)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYStepperChainModel *(^ addStepper)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYPathControlChainModel *(^ addPathControl)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYRuleEditorChainModel *(^ addRuleEditor)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYPredicateEditorChainModel *(^ addPredicateEditor)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYDatePickerChainModel *(^ addDatePicker)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYLevelIndicatorChainModel *(^ addLevelIndicator)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYCustomizeButtonChainModel *(^ addCustomizeButton)(NSInteger);
TFY_PROPERTY_STRONG_READONLY TFYEmiiterLayerChainModel *(^ addEmiiterLayer)(void);
TFY_PROPERTY_STRONG_READONLY TFYGradientLayerChainModel *(^ addGradientLayer)(void);
TFY_PROPERTY_STRONG_READONLY TFYLayerChainModel *(^ addLayer)(void);
TFY_PROPERTY_STRONG_READONLY TFYReplicatorLayerChainModel *(^ addReplicatorLayer)(void);
TFY_PROPERTY_STRONG_READONLY TFYScrollLayerChainModel *(^ addScrollLayer)(void);
TFY_PROPERTY_STRONG_READONLY TFYShaperLayerChainModel *(^ addShaperLayer)(void);
TFY_PROPERTY_STRONG_READONLY TFYTextLayerChainModel *(^ addTextLayer)(void);
TFY_PROPERTY_STRONG_READONLY TFYTiledLayerChainModel *(^ addTiledLayer)(void);
//
@end

NS_ASSUME_NONNULL_END
