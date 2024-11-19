#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 定义性能监控回调block类型
typedef void(^TFYPerformanceCallback)(CGFloat fps, CGFloat cpu, CGFloat memory);

@interface TFYPerformanceMonitor : NSObject

@property (nonatomic, assign, readonly) BOOL isPerformanceCritical;
@property (nonatomic, assign, readonly) BOOL isMonitoring;
@property (nonatomic, assign) NSTimeInterval monitorInterval;
@property (nonatomic, copy, nullable) TFYPerformanceCallback performanceCallback;  // 添加回调属性

// 性能监控方法
- (void)startMonitoring;
- (void)stopMonitoring;
- (void)resetMetrics;

// 性能阈值设置
- (void)setPerformanceThreshold:(NSTimeInterval)threshold;
- (void)setMemoryWarningThreshold:(double)threshold;

// 性能数据获取
- (double)getCurrentCPUUsage;
- (double)getCurrentMemoryUsage;
- (NSTimeInterval)getAverageFrameTime;

@end

NS_ASSUME_NONNULL_END 