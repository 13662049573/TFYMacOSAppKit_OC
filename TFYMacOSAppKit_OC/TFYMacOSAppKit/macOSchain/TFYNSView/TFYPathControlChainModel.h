//
//  TFYPathControlChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYPathControlChainModel;
@interface TFYPathControlChainModel : TFYBaseControlChainModel<TFYPathControlChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYPathControlChainModel * (^ editable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYPathControlChainModel * (^ allowedTypes) (NSArray<NSString *> *);
TFY_PROPERTY_CHAIN_READONLY TFYPathControlChainModel * (^ placeholderString) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYPathControlChainModel * (^ placeholderAttributedString) (NSAttributedString*);
TFY_PROPERTY_CHAIN_READONLY TFYPathControlChainModel * (^ URL) (NSURL*);
TFY_PROPERTY_CHAIN_READONLY TFYPathControlChainModel * (^ doubleAction) (SEL);
TFY_PROPERTY_CHAIN_READONLY TFYPathControlChainModel * (^ pathStyle) (NSPathStyle);
TFY_PROPERTY_CHAIN_READONLY TFYPathControlChainModel * (^ pathItems) (NSArray<NSPathControlItem *> *);
TFY_PROPERTY_CHAIN_READONLY TFYPathControlChainModel * (^ backgroundColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYPathControlChainModel * (^ delegate) (id <NSPathControlDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYPathControlChainModel * (^ menu) (NSMenu*);

@end
TFY_CATEGORY_EXINTERFACE(NSPathControl, TFYPathControlChainModel)
NS_ASSUME_NONNULL_END
