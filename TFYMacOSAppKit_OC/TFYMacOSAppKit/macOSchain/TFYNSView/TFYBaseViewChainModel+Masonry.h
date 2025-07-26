//
//  TFYBaseViewChainModel+Masonry.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseViewChainModel.h"
#if __has_include(<Masonry.h>)
#import <Masonry.h>
#elif __has_include("Masonry.h")
#import "Masonry.h"
#endif

NS_ASSUME_NONNULL_BEGIN
@class MASConstraintMaker;
typedef void(^TFYMasonryLoad)(MASConstraintMaker *make);

@interface TFYBaseViewChainModel<ObjectType> (Masonry)
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ makeMasonry)(TFYMasonryLoad);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ updateMasonry)(TFYMasonryLoad);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ remakeMasonry)(TFYMasonryLoad);
@end

NS_ASSUME_NONNULL_END
