//
//  TFYBaseViewChainModel+Masonry.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseViewChainModel+Masonry.h"

#define   TFY_CATEGORY_CHAIN_MASONRY_IMPLEMENTATION(methodName, masonryMethod) \
- (id (^)( void (^constraints)(MASConstraintMaker *)) )methodName    \
{   \
     return ^id ( void (^constraints)(MASConstraintMaker *) ) {  \
     [self enumerateObjectsUsingBlock:^(UIView*  _Nonnull obj) {\
     if (obj.superview) { \
     [obj masonryMethod:constraints];\
    }\
  }];\
  return self;\
};  \
}
#define     TFY_CATEGORY_CHAIN_MASONRY_IMPLEMENTATION_NULL(methodName, masonryMethod) \
- (id (^)( void (^constraints)(MASConstraintMaker *)) )methodName    \
{   \
return ^id ( void (^constraints)(MASConstraintMaker *) ) {  \
return self;    \
};  \
}

@implementation TFYBaseViewChainModel (Masonry)

#if __has_include(<Masonry.h>) || __has_include("Masonry.h")

TFY_CATEGORY_CHAIN_MASONRY_IMPLEMENTATION(makeMasonry, mas_makeConstraints);
TFY_CATEGORY_CHAIN_MASONRY_IMPLEMENTATION(updateMasonry, mas_updateConstraints);
TFY_CATEGORY_CHAIN_MASONRY_IMPLEMENTATION(remakeMasonry, mas_remakeConstraints);

#else

TFY_CATEGORY_CHAIN_MASONRY_IMPLEMENTATION_NULL(makeMasonry, mas_makeConstraints);
TFY_CATEGORY_CHAIN_MASONRY_IMPLEMENTATION_NULL(updateMasonry, mas_updateConstraints);
TFY_CATEGORY_CHAIN_MASONRY_IMPLEMENTATION_NULL(remakeMasonry, mas_remakeConstraints);

#endif

@end
#undef TFY_CATEGORY_CHAIN_MASONRY_IMPLEMENTATION
#undef TFY_CATEGORY_CHAIN_MASONRY_IMPLEMENTATION_NULL

