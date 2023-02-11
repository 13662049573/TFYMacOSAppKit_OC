//
//  NSScreen+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


@interface NSScreen (Dejal)
/**
 只读属性返回屏幕的唯一ID，即屏幕号。与屏幕列表索引不一样。

 @返回接收者唯一的显示ID。
 */

@property (nonatomic, readonly) NSUInteger tfy_displayID;
/**
 只读属性返回接收器的本地化名称。

 @返回屏幕的本地化名称，如果没有则为nil。
 */
@property (nonatomic, strong, readonly) NSString *tfy_screenName;
/**
 给定一个显示ID，返回本地化的屏幕名，如果没有可用的则返回nil。

 displayID屏幕的唯一ID，由displayID属性返回。
 @返回屏幕的本地化名称，如果没有则为nil。
 */
- (NSString *)tfy_screenNameForDisplayID:(NSUInteger)displayID;

@end

