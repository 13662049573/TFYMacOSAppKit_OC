#import <Cocoa/Cocoa.h>

@class TFYProgressMacOSHUD;

typedef void(^TFYLayoutBlock)(TFYProgressMacOSHUD *hud);

@interface TFYLayoutManager : NSObject

- (void)registerLayout:(TFYLayoutBlock)layout forMode:(NSInteger)mode;
- (void)applyLayoutForMode:(NSInteger)mode toHUD:(TFYProgressMacOSHUD *)hud;
- (void)setupConstraintsForHUD:(TFYProgressMacOSHUD *)hud;
- (void)setupConstraintsForContainer:(NSView *)containerView;
- (void)setupAdaptiveLayoutForHUD:(TFYProgressMacOSHUD *)hud;
- (void)setupSubviewsConstraints:(TFYProgressMacOSHUD *)hud;
- (void)invalidateLayout;

@end
