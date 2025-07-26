//
//  TFYStackViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TFYStackViewChainModel;
@interface TFYStackViewChainModel : TFYBaseViewChainModel<TFYStackViewChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYStackViewChainModel * (^ delegate) (id<NSStackViewDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYStackViewChainModel * (^ orientation) (NSUserInterfaceLayoutOrientation);
TFY_PROPERTY_CHAIN_READONLY TFYStackViewChainModel * (^ alignment) (NSLayoutAttribute);
TFY_PROPERTY_CHAIN_READONLY TFYStackViewChainModel * (^ edgeInsets) (NSEdgeInsets);
TFY_PROPERTY_CHAIN_READONLY TFYStackViewChainModel * (^ distribution) (NSStackViewDistribution);
TFY_PROPERTY_CHAIN_READONLY TFYStackViewChainModel * (^ spacing) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYStackViewChainModel * (^ setCustomSpacing_afterView) (CGFloat,NSView*);
TFY_PROPERTY_CHAIN_READONLY TFYStackViewChainModel * (^ detachesHiddenViews) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYStackViewChainModel * (^ addArrangedSubview) (NSView*);
TFY_PROPERTY_CHAIN_READONLY TFYStackViewChainModel * (^ insertArrangedSubview_atIndex) (NSView*,NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYStackViewChainModel * (^ removeArrangedSubview) (NSView*);

@end
CG_INLINE NSStackView * stackViewWithViews(NSArray<NSView *> * views){
    return [NSStackView stackViewWithViews:views];
}
TFY_CATEGORY_EXINTERFACE(NSStackView, TFYStackViewChainModel)
NS_ASSUME_NONNULL_END
