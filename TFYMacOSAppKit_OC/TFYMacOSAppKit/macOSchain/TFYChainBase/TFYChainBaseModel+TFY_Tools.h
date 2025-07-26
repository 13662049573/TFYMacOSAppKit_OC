//
//  TFYChainBaseModel+TFY_Tools.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYChainBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYChainBaseModel ()

//初始一个对象
- (instancetype)initWithModelObject:(id)object modelClass:(Class)modelClass;
//初始对象属性数组
- (instancetype)initWithModelObjects:(NSArray *)objects modelClass:(Class)modelClass;

@end

NS_ASSUME_NONNULL_END
