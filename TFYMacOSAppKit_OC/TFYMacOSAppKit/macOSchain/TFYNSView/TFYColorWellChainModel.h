//
//  TFYColorWellChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYColorWellChainModel;
@interface TFYColorWellChainModel : TFYBaseControlChainModel<TFYColorWellChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYColorWellChainModel * (^ color) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYColorWellChainModel * (^ colorWellStyle) (NSColorWellStyle) API_AVAILABLE(macos(13.0));
TFY_PROPERTY_CHAIN_READONLY TFYColorWellChainModel * (^ image) (NSImage*) API_AVAILABLE(macos(13.0));
TFY_PROPERTY_CHAIN_READONLY TFYColorWellChainModel * (^ pulldownTarget) (id) API_AVAILABLE(macos(13.0));
TFY_PROPERTY_CHAIN_READONLY TFYColorWellChainModel * (^ pulldownAction) (SEL) API_AVAILABLE(macos(13.0));

@end
TFY_CATEGORY_EXINTERFACE(NSColorWell, TFYColorWellChainModel)
NS_ASSUME_NONNULL_END
