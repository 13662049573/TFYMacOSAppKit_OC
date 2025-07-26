//
//  TFYBaseControlChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseControlChainModel.h"

#define TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, id ,NSControl)

@interface TFYBaseControlChainModel ()
TFY_PROPERTY_NSInteger(tag);
@end

@implementation TFYBaseControlChainModel

- (instancetype)initWithTag:(NSInteger)tag andView:(NSControl *)view modelClass:(Class)modelClass {
    if (self = [super initWithTag:tag andView:view modelClass:modelClass]) {
        _tag = tag;
        view.tag = tag;
    }
    return self;
}

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(ignoresMultiClick, BOOL)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(continuous, BOOL)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(enabled, BOOL)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(refusesFirstResponder, BOOL)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(highlighted, BOOL)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(controlSize, NSControlSize)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(formatter, NSFormatter*)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(objectValue, id)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(stringValue, NSString*)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(attributedStringValue, NSAttributedString*)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(intValue, int)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(integerValue, NSInteger)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(doubleValue, double)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(lineBreakMode, NSLineBreakMode)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(font, NSFont*)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(usesSingleLineMode, BOOL)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(alignment, NSTextAlignment)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(baseWritingDirection, NSWritingDirection)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(allowsExpansionToolTips, BOOL)

TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION(cell, NSCell*)

- (id  _Nonnull (^)(NSInteger))makeTag {
    return ^ (NSInteger tag){
        [self enumerateObjectsUsingBlock:^(NSControl * _Nonnull obj) {
            obj.tag = tag;
        }];
        self.tag = tag;
        return self;
    };
}


- (id  _Nonnull (^)(id, SEL))addTarget {
    return ^(id target, SEL action){
        self.controlview.target = target;
        self.controlview.action = action;
        return self;
    };
}

- (id  _Nonnull (^)(void))sizeToFit{
    return ^ (){
        [self enumerateObjectsUsingBlock:^(NSControl * _Nonnull obj) {
            [obj sizeToFit];
        }];
        return self;
    };
}

- (__kindof NSControl *)controlview {
    return self.effectiveObjects.firstObject;
}

@end
#undef TFY_CATEGORY_CHAIN_CONTROL_IMPLEMENTATION
