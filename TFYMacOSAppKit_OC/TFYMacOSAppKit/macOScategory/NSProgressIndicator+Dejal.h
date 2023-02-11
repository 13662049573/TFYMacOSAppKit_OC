//
//  NSProgressIndicator+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


@interface NSProgressIndicator (Dejal)
/**
 启动一个不确定指示器的动画，其alpha值设置为零，并在指定的持续时间内逐渐消退。

 淡入需要多长时间。
 */

- (void)tfy_startAnimationWithFadeInDuration:(NSTimeInterval)fadeInDuration;

@end

