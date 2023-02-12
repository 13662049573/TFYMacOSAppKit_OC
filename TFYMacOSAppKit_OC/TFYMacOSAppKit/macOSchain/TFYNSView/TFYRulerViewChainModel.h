//
//  TFYRulerViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYRulerViewChainModel;
@interface TFYRulerViewChainModel : TFYBaseViewChainModel<TFYRulerViewChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYRulerViewChainModel * (^ scrollView) (NSScrollView*);
TFY_PROPERTY_CHAIN_READONLY TFYRulerViewChainModel * (^ orientation) (NSRulerOrientation);
TFY_PROPERTY_CHAIN_READONLY TFYRulerViewChainModel * (^ ruleThickness) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYRulerViewChainModel * (^ reservedThicknessForMarkers) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYRulerViewChainModel * (^ reservedThicknessForAccessoryView) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYRulerViewChainModel * (^ measurementUnits) (NSRulerViewUnitName);
TFY_PROPERTY_CHAIN_READONLY TFYRulerViewChainModel * (^ originOffset) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYRulerViewChainModel * (^ clientView) (NSView*);
TFY_PROPERTY_CHAIN_READONLY TFYRulerViewChainModel * (^ markers) (NSArray<NSRulerMarker *> *);
TFY_PROPERTY_CHAIN_READONLY TFYRulerViewChainModel * (^ accessoryView) (NSView*);

@end
CG_INLINE void registerUnitWithName(NSRulerViewUnitName unitName,NSString *abbreviation,CGFloat conversionFactor,NSArray<NSNumber *> *stepUpCycle,NSArray<NSNumber *>*stepDownCycle){
   [NSRulerView registerUnitWithName:unitName abbreviation:abbreviation unitToPointsConversionFactor:conversionFactor stepUpCycle:stepUpCycle stepDownCycle:stepDownCycle];
}
TFY_CATEGORY_EXINTERFACE(NSRulerView, TFYRulerViewChainModel)
NS_ASSUME_NONNULL_END
