//
//  CAGradientLayer+Dejal.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/2.
//

#import "CAGradientLayer+Dejal.h"

@implementation CAGradientLayer (Dejal)

/**
 *  创建渐变颜色 size  渐变的size direction 渐变方式 startcolor 开始颜色  endColor 结束颜色
 */
+(CAGradientLayer *)tfy_colorGradientChangeWithSize:(CGSize)size direction:(GradientMacOsDirection)direction colorsArr:(NSArray<NSColor *> *)colorsArr {
    if (CGSizeEqualToSize(size, CGSizeZero) || colorsArr.count == 0) {
        return nil;
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointZero;
    if (direction == GradientMacOsDirectionDownDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    gradientLayer.startPoint = startPoint;
    
    CGPoint endPoint = CGPointZero;
    switch (direction) {
        case GradientMacOseDirectionLevel:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case GradientMacOsDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case GradientMacOsDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case GradientMacOsDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            break;
    }
    gradientLayer.endPoint = endPoint;

    NSMutableArray *dataArray = NSMutableArray.array;
    [colorsArr enumerateObjectsUsingBlock:^(NSColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dataArray addObject:(__bridge id)obj.CGColor];
    }];
    gradientLayer.colors = dataArray;
    return gradientLayer;
}

@end
