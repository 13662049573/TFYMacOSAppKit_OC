#import "TFYPerformanceMonitor.h"
#import <mach/mach.h>

@interface TFYPerformanceMonitor ()

@property (nonatomic, assign) BOOL isPerformanceCritical;
@property (nonatomic, assign) BOOL isMonitoring;
@property (nonatomic, assign) NSTimeInterval performanceThreshold;
@property (nonatomic, assign) double memoryWarningThreshold;
@property (nonatomic, strong) NSTimer *monitoringTimer;
@property (nonatomic, assign) NSTimeInterval lastFrameTime;
@property (nonatomic, assign) double cpuUsage;
@property (nonatomic, assign) double memoryUsage;
@property (nonatomic, assign) CGFloat currentFPS;

@end

@implementation TFYPerformanceMonitor

- (instancetype)init {
    self = [super init];
    if (self) {
        _performanceThreshold = 1.0/30.0; // 30 FPS threshold
        _memoryWarningThreshold = 80.0; // 80% memory usage threshold
        _monitorInterval = 1.0; // 默认监控间隔为1秒
        _isMonitoring = NO;
        _isPerformanceCritical = NO;
    }
    return self;
}

- (void)startMonitoring {
    if (self.isMonitoring) return;
    
    self.isMonitoring = YES;
    self.monitoringTimer = [NSTimer scheduledTimerWithTimeInterval:self.monitorInterval
                                                          target:self
                                                        selector:@selector(checkPerformance)
                                                        userInfo:nil
                                                         repeats:YES];
}

- (void)stopMonitoring {
    [self.monitoringTimer invalidate];
    self.monitoringTimer = nil;
    self.isMonitoring = NO;
}

- (void)checkPerformance {
    // 获取性能数据
    CGFloat fps = 1.0 / [self getAverageFrameTime];
    CGFloat cpu = [self getCurrentCPUUsage];
    CGFloat memory = [self getCurrentMemoryUsage];
    
    // 更新性能状态
    self.currentFPS = fps;
    self.cpuUsage = cpu;
    self.memoryUsage = memory;
    
    // 检查是否达到性能临界值
    self.isPerformanceCritical = (fps < 30.0 || 
                                 cpu > 80.0 || 
                                 memory > self.memoryWarningThreshold);
    
    // 调用性能回调
    if (self.performanceCallback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.performanceCallback(fps, cpu, memory);
        });
    }
}

- (double)getCurrentCPUUsage {
    processor_info_array_t cpuInfo;
    mach_msg_type_number_t numCpuInfo;
    natural_t numCPUs = 0;
    
    kern_return_t err = host_processor_info(mach_host_self(),
                                          PROCESSOR_CPU_LOAD_INFO,
                                          &numCPUs,
                                          &cpuInfo,
                                          &numCpuInfo);
    
    if (err == KERN_SUCCESS) {
        float totalUsage = 0;
        for (unsigned i = 0; i < numCPUs; i++) {
            float usage = cpuInfo[CPU_STATE_USER + (CPU_STATE_MAX * i)] +
                         cpuInfo[CPU_STATE_SYSTEM + (CPU_STATE_MAX * i)];
            totalUsage += usage;
        }
        vm_deallocate(mach_task_self(), (vm_address_t)cpuInfo, sizeof(integer_t) * numCpuInfo);
        return totalUsage / numCPUs;
    }
    
    return 0.0;
}

- (double)getCurrentMemoryUsage {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    
    kern_return_t kernReturn = task_info(mach_task_self(),
                                       TASK_BASIC_INFO,
                                       (task_info_t)&taskInfo,
                                       &infoCount);
    
    if (kernReturn == KERN_SUCCESS) {
        return (taskInfo.resident_size / (double)NSPageSize()) / 1024.0 / 1024.0;
    }
    
    return 0.0;
}

- (NSTimeInterval)getAverageFrameTime {
    return CACurrentMediaTime() - self.lastFrameTime;
}

- (void)setPerformanceThreshold:(NSTimeInterval)threshold {
    _performanceThreshold = threshold;
}

- (void)setMemoryWarningThreshold:(double)threshold {
    _memoryWarningThreshold = threshold;
}

- (void)resetMetrics {
    self.cpuUsage = 0;
    self.memoryUsage = 0;
    self.lastFrameTime = 0;
    self.isPerformanceCritical = NO;
}

- (void)setMonitorInterval:(NSTimeInterval)monitorInterval {
    _monitorInterval = monitorInterval;
    
    // 如果正在监控，重新启动定时器使用新的间隔
    if (self.isMonitoring) {
        [self stopMonitoring];
        [self startMonitoring];
    }
}

@end 
