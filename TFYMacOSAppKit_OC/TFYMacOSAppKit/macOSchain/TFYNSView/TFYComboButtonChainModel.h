//
//  TFYComboButtonChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TFYComboButtonChainModel;
@interface TFYComboButtonChainModel : TFYBaseControlChainModel<TFYComboButtonChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYComboButtonChainModel * (^ title) (NSString*) API_AVAILABLE(macos(13.0));
TFY_PROPERTY_CHAIN_READONLY TFYComboButtonChainModel * (^ image) (NSImage*) API_AVAILABLE(macos(13.0));
TFY_PROPERTY_CHAIN_READONLY TFYComboButtonChainModel * (^ imageScaling) (NSImageScaling) API_AVAILABLE(macos(13.0));
TFY_PROPERTY_CHAIN_READONLY TFYComboButtonChainModel * (^ menu) (NSMenu*) API_AVAILABLE(macos(13.0));
TFY_PROPERTY_CHAIN_READONLY TFYComboButtonChainModel * (^ style) (NSComboButtonStyle) API_AVAILABLE(macos(13.0));

@end
TFY_CATEGORY_EXINTERFACE_MACOSI3(NSComboButton, TFYComboButtonChainModel)
NS_ASSUME_NONNULL_END



