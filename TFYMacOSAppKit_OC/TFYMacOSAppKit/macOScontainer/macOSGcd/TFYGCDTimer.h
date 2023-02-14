//
//  TFYGCDTimer.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import <Foundation/Foundation.h>
#import "TFYGCDQueue.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYGCDTimer : NSObject

@property (strong, readonly, nonatomic) dispatch_source_t dispatchSource;

#pragma 初始化
- (instancetype)init;
- (instancetype)initInQueue:(TFYGCDQueue *)queue;

#pragma mark - 用法
- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval;
- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs;
- (void)start;
- (void)destroy;

@end

NS_ASSUME_NONNULL_END
