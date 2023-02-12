//
//  TFYCollectionViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYCollectionViewChainModel.h"

#define TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYCollectionViewChainModel *,NSCollectionView)

@implementation TFYCollectionViewChainModel

TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(dataSource, id<NSCollectionViewDataSource>)
TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(prefetchDataSource, id<NSCollectionViewPrefetching>)
TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(content, NSArray<id> *)
TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(delegate, id<NSCollectionViewDelegate>)
TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(backgroundViewScrollsWithContent, BOOL)
TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(backgroundColors, NSArray<NSColor *>*)
TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(collectionViewLayout, NSCollectionViewLayout*)
TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(selectable, BOOL)
TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(allowsEmptySelection, BOOL)
TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(allowsMultipleSelection, BOOL)
TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(selectionIndexes, NSIndexSet*)
TFY_CATEGORY_CHAIN_COLLECTION_IMPLEMENTATION(selectionIndexPaths, NSSet<NSIndexPath *>*)

- (TFYCollectionViewChainModel * _Nonnull (^)(NSSet<NSIndexPath *> *,NSCollectionViewScrollPosition))selectItemsAtIndexPaths_scrollPosition{
    return ^(NSSet<NSIndexPath *> * indexPaths,NSCollectionViewScrollPosition scrollPosition)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj selectItemsAtIndexPaths:indexPaths scrollPosition:scrollPosition];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSSet<NSIndexPath *> *))deselectItemsAtIndexPaths{
    return ^(NSSet<NSIndexPath *> * indexPaths)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj deselectItemsAtIndexPaths:indexPaths];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(Class,NSUserInterfaceItemIdentifier))registerClass_forItemIdentifier{
    return ^(Class itemClass,NSUserInterfaceItemIdentifier identifier)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj registerClass:itemClass forItemWithIdentifier:identifier];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSNib *,NSUserInterfaceItemIdentifier))registerNib_forItemIdentifier{
    return ^(NSNib * nib,NSUserInterfaceItemIdentifier identifier)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj registerNib:nib forItemWithIdentifier:identifier];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(Class,NSCollectionViewSupplementaryElementKind,NSUserInterfaceItemIdentifier))registerClass_forOfKind_identifier{
    return ^(Class viewClass,NSCollectionViewSupplementaryElementKind kind,NSUserInterfaceItemIdentifier identifier)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj registerClass:viewClass forSupplementaryViewOfKind:kind withIdentifier:identifier];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSNib *,NSCollectionViewSupplementaryElementKind,NSUserInterfaceItemIdentifier))registerNib_forOfKind_identifier{
    return ^(NSNib * nib,NSCollectionViewSupplementaryElementKind kind,NSUserInterfaceItemIdentifier identifier)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj registerNib:nib forSupplementaryViewOfKind:kind withIdentifier:identifier];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSIndexSet *))insertSections{
    return ^(NSIndexSet* sections)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj insertSections:sections];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSIndexSet*))deleteSections{
    return ^(NSIndexSet * sections)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj deleteSections:sections];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSIndexSet *))reloadSections{
    return ^(NSIndexSet * sections)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj reloadSections:sections];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSInteger,NSInteger))moveSection_toSection{
    return ^(NSInteger section,NSInteger newSection)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj moveSection:section toSection:newSection];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSSet<NSIndexPath *> *))insertItemsAtIndexPaths{
    return ^(NSSet<NSIndexPath *> * indexPaths)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj insertItemsAtIndexPaths:indexPaths];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSSet<NSIndexPath *> *))deleteItemsAtIndexPaths{
    return ^(NSSet<NSIndexPath *> * indexPaths)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj deleteItemsAtIndexPaths:indexPaths];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSSet<NSIndexPath *> *))reloadItemsAtIndexPaths{
    return ^(NSSet<NSIndexPath *> * indexPaths)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj reloadItemsAtIndexPaths:indexPaths];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSIndexPath *,NSIndexPath*))moveItemAtIndexPath_toIndexPath{
    return ^(NSIndexPath * indexPath,NSIndexPath *newIndexPath)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSSet<NSIndexPath *> *,NSCollectionViewScrollPosition))scrollToItemsAtIndexPaths_scrollPosition{
    return ^(NSSet<NSIndexPath *> * indexPaths,NSCollectionViewScrollPosition scrollPosition)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj scrollToItemsAtIndexPaths:indexPaths scrollPosition:scrollPosition];
        }];
        return self;
    };
}

- (TFYCollectionViewChainModel * _Nonnull (^)(NSDragOperation,BOOL))setDraggingSourceOperationMask_forLocal{
    return ^(NSDragOperation dragOperationMask,BOOL localDestination)
    {
        [self enumerateObjectsUsingBlock:^(NSCollectionView * _Nonnull obj) {
            [obj setDraggingSourceOperationMask:dragOperationMask forLocal:localDestination];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSCollectionView, TFYCollectionViewChainModel)
#undef TFY_CATEGORY_CHAIN_DATEPICKER_IMPLEMENTATION
