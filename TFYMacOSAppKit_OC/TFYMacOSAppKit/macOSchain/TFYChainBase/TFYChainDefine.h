//
//  TFYChainDefine.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#ifndef TFYChainDefine_h
#define TFYChainDefine_h

#import <Cocoa/Cocoa.h>
#import <objc/message.h>
#import <QuartzCore/QuartzCore.h>
#import <AppKit/AppKit.h>

#pragma mark-------------------------------------------属性对象---------------------------------------------

#define TFY_PROPERTY_CHAIN_READONLY          @property (nonatomic , copy , readonly)
#define TFY_PROPERTY_STRONG_READONLY         @property (nonatomic , strong , readonly)
#define TFY_PROPERTY_ASSIGN_READONLY         @property (nonatomic , assign , readonly)

#pragma mark -------------------------------------------属性快速声明-------------------------------------------

#define TFY_PROPERTY_CHAIN                    @property (nonatomic , copy)
#define TFY_PROPERTY_STRONG                   @property (nonatomic , strong)
#define TFY_PROPERTY_ASSIGN                   @property (nonatomic , assign)
#define TFY_PROPERTY_WEAK                     @property (nonatomic , weak)
#define TFY_PROPERTY_CHAIN_BLOCK(name,...)    @property (nonatomic , copy, nullable) void (^name)(__VA_ARGS__)

#define TFY_PROPERTY_BOOL(name)                TFY_PROPERTY_ASSIGN BOOL                  name
#define TFY_PROPERTY_NSString(name)            TFY_PROPERTY_CHAIN  NSString            * name
#define TFY_PROPERTY_NSUInteger(name)          TFY_PROPERTY_ASSIGN NSUInteger            name
#define TFY_PROPERTY_NSInteger(name)           TFY_PROPERTY_ASSIGN NSInteger             name
#define TFY_PROPERTY_Float(name)               TFY_PROPERTY_ASSIGN float                 name
#define TFY_PROPERTY_LongLong(name)            TFY_PROPERTY_ASSIGN long long             name
#define TFY_PROPERTY_NSDictionary(name)        TFY_PROPERTY_STRONG NSDictionary        * name
#define TFY_PROPERTY_NSArray(name)             TFY_PROPERTY_CHAIN  NSArray * name
#define TFY_PROPERTY_NSMutableArray(name)      TFY_PROPERTY_STRONG NSMutableArray      * name
#define TFY_PROPERTY_NSData(name)              TFY_PROPERTY_STRONG NSData * name
#define TFY_PROPERTY_NSMutableDictionary(name) TFY_PROPERTY_STRONG NSMutableDictionary * name

/**快捷创建对象属性 如 (Label) (name)*/
#define TFY_PROPERTY_OBJECT_STRONG(object,name)  TFY_PROPERTY_STRONG object  * name
#define TFY_PROPERTY_OBJECT_CHAIN(object,name)   TFY_PROPERTY_CHAIN  object  * name
#define TFY_PROPERTY_OBJECT_ASSIGN(object,name)  TFY_PROPERTY_ASSIGN object    name
#define TFY_PROPERTY_OBJECT_WEAK(object,name)    TFY_PROPERTY_WEAK   object    name

/**点语法*/
#pragma mark-------------------------------------------点语法链式编程---------------------------------------------

#define TFY_CATEGORY_CHAIN_IMPLEMENTATION(TFYMethod,TFYParaType, TFYModelType, TFYPropertyClass)\
- (TFYModelType  _Nonnull (^)(TFYParaType))TFYMethod {\
          return ^ (TFYParaType TFYMethod){\
                NSArray *array = self.effectiveObjects.copy;\
                for (TFYPropertyClass * obj in array) {\
                        obj.TFYMethod = TFYMethod;\
                }\
         return self;\
    };\
}

#define TFY_CATEGORY_EXINTERFACE(TFYMacOSClass, ModelType)\
CG_INLINE TFYMacOSClass *TFYMacOSClass##Set(void){\
       return [TFYMacOSClass new];\
}\
CG_INLINE ModelType *TFYMacOSClass##ModelSet(void){\
       return ((id (*)(id, SEL))objc_msgSend)([TFYMacOSClass new],sel_registerName("makeChain"));\
}\
CG_INLINE ModelType *TFYMacOSClass##NameSet(NSString *className){\
      Class clas = NSClassFromString(className);\
      if ([clas isKindOfClass:[TFYMacOSClass class]]) {\
      return [clas new];\
      }\
    return nil;\
}\
CG_INLINE ModelType *TFYMacOSClass##NameModelSet(NSString *className){\
      return ((id (*)(id, SEL))objc_msgSend)( TFYMacOSClass##NameSet(className),sel_registerName("makeChain"));\
}\
TFY_CATEGORY_EXINTERFACE_(TFYMacOSClass, ModelType)\
CG_INLINE ModelType * TFYMacOSClass##ModelWithArray(NSArray <TFYMacOSClass *>*objects)\
{\
    return ((id (*)(id, SEL,id,id))objc_msgSend)([ModelType alloc],sel_registerName("initWithModelObjects:modelClass:"),objects,[TFYMacOSClass class]);\
}

#define TFY_CATEGORY_EXINTERFACE_(TFYMacOSClass, ModelType)\
@interface TFYMacOSClass(EXT)\
TFY_PROPERTY_CHAIN_READONLY ModelType * makeChain;\
@end


#define TFY_CATEGORY_EXINTERFACE_MACOSI3(TFYMacOSClass, ModelType)\
API_AVAILABLE(macos(13.0))\
CG_INLINE TFYMacOSClass *TFYMacOSClass##Set(void){\
       return [TFYMacOSClass new];\
}\
API_AVAILABLE(macos(13.0))\
CG_INLINE ModelType *TFYMacOSClass##ModelSet(void){\
       return ((id (*)(id, SEL))objc_msgSend)([TFYMacOSClass new],sel_registerName("makeChain"));\
}\
API_AVAILABLE(macos(13.0))\
CG_INLINE ModelType *TFYMacOSClass##NameSet(NSString *className){\
      Class clas = NSClassFromString(className);\
      if ([clas isKindOfClass:[TFYMacOSClass class]]) {\
      return [clas new];\
      }\
    return nil;\
}\
API_AVAILABLE(macos(13.0))\
CG_INLINE ModelType *TFYMacOSClass##NameModelSet(NSString *className){\
      return ((id (*)(id, SEL))objc_msgSend)( TFYMacOSClass##NameSet(className),sel_registerName("makeChain"));\
}\
TFY_CATEGORY_EXINTERFACE__MACOSI3(TFYMacOSClass, ModelType)\
API_AVAILABLE(macos(13.0))\
CG_INLINE ModelType * TFYMacOSClass##ModelWithArray(NSArray <TFYMacOSClass *>*objects)\
{\
    return ((id (*)(id, SEL,id,id))objc_msgSend)([ModelType alloc],sel_registerName("initWithModelObjects:modelClass:"),objects,[TFYMacOSClass class]);\
}

#define TFY_CATEGORY_EXINTERFACE__MACOSI3(TFYMacOSClass, ModelType)\
API_AVAILABLE(macos(13.0))\
@interface TFYMacOSClass(EXT)\
TFY_PROPERTY_CHAIN_READONLY ModelType * makeChain;\
@end

#endif /* TFYChainDefine_h */
