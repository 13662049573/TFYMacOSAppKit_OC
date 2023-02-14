//
//  TFYUtils.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN
#pragma mark*******************************************判断获取网络数据****************************************
extern NSString *kReachabilityChangedNotification;

typedef NS_ENUM(NSUInteger, NetworkStatus) {
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableViaWWAN
};

@interface TFYUtils : NSObject

#pragma mark------------------------------------------手机获取网络监听方法---------------------------------------
/** v用于检查给定主机名的可访问性。*/
+ (instancetype)reachabilityWithHostName:(NSString *)hostName;

/** 用于检查给定IP地址的可达性。*/
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

/** 检查默认路由是否可用。应该由未连接到特定主机的应用程序使用。*/
+ (instancetype)reachabilityForInternetConnection;

/** 开始侦听当前运行循环的可达性通知。*/
- (BOOL)startNotifier;
- (void)stopNotifier;

- (NetworkStatus)currentReachabilityStatus;

/** WWAN可能可用，但在建立连接之前不会处于活动状态。 WiFi可能需要VPN on Demand连接。*/
- (BOOL)connectionRequired;


#pragma  mark - NSUserDefaults存取操作
/***  存储当前BOOL*/
+(void)saveBoolValueInUD:(BOOL)value forKey:(NSString *)key;

/***  存储当前NSString*/
+(void)saveStrValueInUD:(NSString *)str forKey:(NSString *)key;

/***  存储当前NSData*/
+(void)saveDataValueInUD:(NSData *)data forKey:(NSString *)key;

/***  存储当前NSDictionary*/
+(void)saveDicValueInUD:(NSDictionary *)dic forKey:(NSString *)key;

/***  存储当前NSArray*/
+(void)saveArrValueInUD:(NSArray *)arr forKey:(NSString *)key;

/***  存储当前NSDate*/
+(void)saveDateValueInUD:(NSDate *)date forKey:(NSString *)key;

/***  存储当前NSInteger*/
+(void)saveIntValueInUD:(NSInteger)value forKey:(NSString *)key;

/**存储当前CGFloat*/
+(void)saveFloatValueInUD:(CGFloat)value forKey:(NSString *)key;

/**存储当前Double*/
+(void)saveDoubleValueInUD:(CGFloat)value forKey:(NSString *)key;

/**存储当前Double*/
+(void)saveUrlValueInUD:(NSURL*)value forKey:(NSString *)key;

/***   保存模型id*/
+(void)saveValueInUD:(id)value forKey:(NSString *)key;

/**删除对应的KEY**/
+(void)removeValueInUDWithKey:(NSString *)key;

/***  获取保存的id*/
+(id)getValueInUDWithKey:(NSString *)key;

/***  获取保存的NSDate*/
+(NSDate *)getDateValueInUDWithKey:(NSString *)key;

/***  获取保存的NSString*/
+(NSString *)getStrValueInUDWithKey:(NSString *)key;

/***  获取保存的NSInteger*/
+(NSInteger )getIntValueInUDWithKey:(NSString *)key;

/**获取保存的CGFloat*/
+ (CGFloat)getFloatValueInUDWithKey:(NSString *)key;

/**获取保存的double*/
+ (double)getdoubleValueInUDWithKey:(NSString *)key;

/**获取保存的NSURL*/
+ (NSURL*)getURLValueInUDWithKey:(NSString *)key;

/***  获取保存的NSDictionary*/
+(NSDictionary *)getDicValueInUDWithKey:(NSString *)key;

/***  获取保存的NSArray*/
+(NSArray *)getArrValueInUDWithKey:(NSString *)key;

/***  获取保存的NSData*/
+(NSData *)getdataValueInUDWithKey:(NSString *)key;

/**获取保存的BOOL*/
+(BOOL)getBoolValueInUDWithKey:(NSString *)key;

/***   归档*/
+ (void)keyedArchiverObject:(id)object ToFile:(NSString *)path;

/***  反归档*/
+(id)keyedUnArchiverForKey:(id)object FromFile:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
