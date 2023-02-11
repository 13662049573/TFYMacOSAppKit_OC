//
//  CALayer+TFY_Chain.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import <QuartzCore/QuartzCore.h>
#import "TFYCALayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (TFY_Chain)

TFY_PROPERTY_STRONG_READONLY TFYLayerChainModel *(^ addLayer)(void);

TFY_PROPERTY_STRONG_READONLY TFYShaperLayerChainModel *(^ addShaperLayer)(void);

TFY_PROPERTY_STRONG_READONLY TFYEmiiterLayerChainModel *(^ addEmiiterLayer)(void);

TFY_PROPERTY_STRONG_READONLY TFYScrollLayerChainModel *(^ addScrollLayer)(void);

TFY_PROPERTY_STRONG_READONLY TFYTextLayerChainModel *(^ addTextLayer)(void);

TFY_PROPERTY_STRONG_READONLY TFYTiledLayerChainModel *(^ addTiledLayer)(void);

TFY_PROPERTY_STRONG_READONLY TFYTransFormLayerChainModel *(^ addTransFormLayer)(void);

TFY_PROPERTY_STRONG_READONLY TFYGradientLayerChainModel *(^ addGradientLayer)(void);

TFY_PROPERTY_STRONG_READONLY TFYReplicatorLayerChainModel *(^ addReplicatorLayer)(void);

@end

NS_ASSUME_NONNULL_END
