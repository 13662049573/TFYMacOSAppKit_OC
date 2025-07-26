//
//  TFYCollectionViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYCollectionViewChainModel;
@interface TFYCollectionViewChainModel : TFYBaseViewChainModel<TFYCollectionViewChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ dataSource) (id<NSCollectionViewDataSource>);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ prefetchDataSource) (id<NSCollectionViewPrefetching>);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ content) (NSArray<id> *);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ delegate) (id<NSCollectionViewDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ backgroundView) (NSView*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ backgroundViewScrollsWithContent) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ backgroundColors) (NSArray<NSColor *>*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ collectionViewLayout) (NSCollectionViewLayout*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ selectable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ allowsEmptySelection) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ allowsMultipleSelection) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ selectionIndexes) (NSIndexSet*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ selectionIndexPaths) (NSSet<NSIndexPath *>*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ selectItemsAtIndexPaths_scrollPosition) (NSSet<NSIndexPath *> *,NSCollectionViewScrollPosition);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ deselectItemsAtIndexPaths) (NSSet<NSIndexPath *>*);

TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ registerClass_forItemIdentifier) (Class,NSUserInterfaceItemIdentifier);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ registerNib_forItemIdentifier) (NSNib*,NSUserInterfaceItemIdentifier);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ registerClass_forOfKind_identifier) (Class,NSCollectionViewSupplementaryElementKind,NSUserInterfaceItemIdentifier);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ registerNib_forOfKind_identifier) (NSNib*,NSCollectionViewSupplementaryElementKind,NSUserInterfaceItemIdentifier);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ insertSections) (NSIndexSet*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ deleteSections) (NSIndexSet*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ reloadSections) (NSIndexSet*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ moveSection_toSection) (NSInteger,NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ insertItemsAtIndexPaths) (NSSet<NSIndexPath *>*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ deleteItemsAtIndexPaths) (NSSet<NSIndexPath *>*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ reloadItemsAtIndexPaths) (NSSet<NSIndexPath *>*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ moveItemAtIndexPath_toIndexPath) (NSIndexPath*,NSIndexPath*);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ scrollToItemsAtIndexPaths_scrollPosition) (NSSet<NSIndexPath *>*,NSCollectionViewScrollPosition);
TFY_PROPERTY_CHAIN_READONLY TFYCollectionViewChainModel * (^ setDraggingSourceOperationMask_forLocal) (NSDragOperation,BOOL);

@end
TFY_CATEGORY_EXINTERFACE(NSCollectionView, TFYCollectionViewChainModel)
NS_ASSUME_NONNULL_END
