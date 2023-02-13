//
//  TFYMatrixChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYMatrixChainModel;
@interface TFYMatrixChainModel : TFYBaseControlChainModel<TFYMatrixChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ cellClass) (Class);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ prototype) (NSCell*);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ mode) (NSMatrixMode);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ allowsEmptySelection) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ selectionByRect) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ cellSize) (NSSize);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ intercellSpacing) (NSSize);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ backgroundColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ drawsCellBackground) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ drawsBackground) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ doubleAction) (SEL);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ autosizesCells) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ autoscroll) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ delegate) (id<NSMatrixDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ autorecalculatesCellSize) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ tabKeyTraversesCells) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYMatrixChainModel * (^ keyCell) (NSCell*);

@end
TFY_CATEGORY_EXINTERFACE(NSMatrix, TFYMatrixChainModel)
NS_ASSUME_NONNULL_END
