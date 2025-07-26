//
//  CAGradientLayer+Dejal.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/2.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN
/**
 渐变方式
 
 - GradientChangeDirectionLevel:              水平渐变
 - GradientChangeDirectionVertical:           竖直渐变
 - GradientChangeDirectionUpwardDiagonalLine: 向下对角线渐变
 - GradientChangeDirectionDownDiagonalLine:   向上对角线渐变
 */
typedef NS_ENUM(NSInteger, GradientMacOsDirection) {
    GradientMacOseDirectionLevel,
    GradientMacOsDirectionVertical,
    GradientMacOsDirectionUpwardDiagonalLine,
    GradientMacOsDirectionDownDiagonalLine,
};

@interface CAGradientLayer (Dejal)
/**
 *  创建渐变颜色 size  渐变的size direction 渐变方式 startcolor 开始颜色  endColor 结束颜色
 */
+(CAGradientLayer *)tfy_colorGradientChangeWithSize:(CGSize)size direction:(GradientMacOsDirection)direction colorsArr:(NSArray<NSColor *> *)colorsArr;

@end

NS_ASSUME_NONNULL_END
