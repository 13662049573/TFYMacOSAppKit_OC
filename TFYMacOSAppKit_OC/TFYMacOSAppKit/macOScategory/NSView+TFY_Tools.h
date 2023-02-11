//
//  NSView+TFY_Tools.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (TFY_Tools)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

- (void)tfy_removeAllSubViews;

- (NSViewController *)tfy_viewController;

- (CGFloat)tfy_visibleAlpha;

- (NSData *)tfy_snapshotPDF;

@end

NS_ASSUME_NONNULL_END
