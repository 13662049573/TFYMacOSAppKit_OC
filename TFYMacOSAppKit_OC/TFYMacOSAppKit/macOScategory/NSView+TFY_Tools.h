//
//  NSView+TFY_Tools.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (TFY_Tools)

@property (nonatomic, assign) CGPoint macos_origin;
@property (nonatomic, assign) CGFloat macos_x;
@property (nonatomic, assign) CGFloat macos_y;
@property (nonatomic, assign) CGSize macos_size;
@property (nonatomic, assign) CGFloat macos_width;
@property (nonatomic, assign) CGFloat macos_height;
@property (nonatomic) CGFloat macos_top;
@property (nonatomic) CGFloat macos_bottom;
@property (nonatomic) CGFloat macos_left;
@property (nonatomic) CGFloat macos_right;

- (void)tfy_removeAllSubViews;

- (NSViewController *)tfy_viewController;

- (CGFloat)tfy_visibleAlpha;

- (NSData *)tfy_snapshotPDF;

@end

NS_ASSUME_NONNULL_END
