//
//  TFYReplicatorLayerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseLayerChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYReplicatorLayerChainModel;
@interface TFYReplicatorLayerChainModel : TFYBaseLayerChainModel<TFYReplicatorLayerChainModel *>
TFY_PROPERTY_CHAIN_READONLY TFYReplicatorLayerChainModel * (^ instanceCount) (NSInteger instanceCount);
TFY_PROPERTY_CHAIN_READONLY TFYReplicatorLayerChainModel * (^ preservesDepth) (BOOL preservesDepth);
TFY_PROPERTY_CHAIN_READONLY TFYReplicatorLayerChainModel * (^ instanceDelay) (CFTimeInterval instanceDelay);
TFY_PROPERTY_CHAIN_READONLY TFYReplicatorLayerChainModel * (^ instanceTransform) (CATransform3D instanceTransform);
TFY_PROPERTY_CHAIN_READONLY TFYReplicatorLayerChainModel * (^ instanceColor) (CGColorRef instanceColor);
TFY_PROPERTY_CHAIN_READONLY TFYReplicatorLayerChainModel * (^ instanceRedOffset) (float instanceRedOffset);
TFY_PROPERTY_CHAIN_READONLY TFYReplicatorLayerChainModel * (^ instanceGreenOffset) (float instanceGreenOffset);
TFY_PROPERTY_CHAIN_READONLY TFYReplicatorLayerChainModel * (^ instanceBlueOffset) (float instanceBlueOffset);
TFY_PROPERTY_CHAIN_READONLY TFYReplicatorLayerChainModel * (^ instanceAlphaOffset) (float instanceAlphaOffset);
@end
TFY_CATEGORY_EXINTERFACE(CAReplicatorLayer, TFYReplicatorLayerChainModel)
NS_ASSUME_NONNULL_END
