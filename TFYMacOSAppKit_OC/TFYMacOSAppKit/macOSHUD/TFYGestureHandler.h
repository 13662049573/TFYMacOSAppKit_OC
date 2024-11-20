//
//  TFYProgressIndicator.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TFYGestureHandlerDelegate;

@interface TFYGestureHandler : NSObject

@property (nonatomic, weak) id<TFYGestureHandlerDelegate> delegate;
@property (nonatomic, assign) BOOL gesturesEnabled;

- (void)setupGesturesForView:(NSView *)view;
- (void)addTapGestureToView:(NSView *)view;
- (void)addSwipeGestureToView:(NSView *)view;
- (void)removeAllGestureRecognizers;
- (void)cleanup;

@end

@protocol TFYGestureHandlerDelegate <NSObject>
@required
- (void)gestureHandler:(TFYGestureHandler *)handler didRecognizeTapGesture:(NSGestureRecognizer *)gesture;
- (void)gestureHandler:(TFYGestureHandler *)handler didRecognizeSwipeGesture:(NSGestureRecognizer *)gesture;

@optional
- (BOOL)gestureHandler:(TFYGestureHandler *)handler shouldRecognizeTapGesture:(NSGestureRecognizer *)gesture;
- (BOOL)gestureHandler:(TFYGestureHandler *)handler shouldRecognizeSwipeGesture:(NSGestureRecognizer *)gesture;
@end

NS_ASSUME_NONNULL_END 
