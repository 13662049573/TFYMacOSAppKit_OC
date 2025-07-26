//
//  TFYBaseControlChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TFYTargetActionBlock)(__kindof NSControl *sender);

@interface TFYBaseControlChainModel<__covariant ObjectType> : TFYBaseViewChainModel<ObjectType>

TFY_PROPERTY_STRONG_READONLY __kindof NSControl *controlview;

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ makeTag) (NSInteger);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addTarget)(id, SEL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ ignoresMultiClick) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ continuous) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ enabled) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ refusesFirstResponder) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ highlighted) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ controlSize) (NSControlSize);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ formatter) (NSFormatter*);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ objectValue) (id);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ stringValue) (NSString *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ attributedStringValue) (NSAttributedString *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ integerValue) (NSInteger);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ intValue) (int);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ floatValue) (float);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ doubleValue) (double);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ lineBreakMode) (NSLineBreakMode);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ font) (NSFont*);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ usesSingleLineMode) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ alignment) (NSTextAlignment);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ baseWritingDirection) (NSWritingDirection);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ allowsExpansionToolTips) (BOOL);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ cell) (NSCell *);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ sizeToFit) (void);

@end

NS_ASSUME_NONNULL_END
