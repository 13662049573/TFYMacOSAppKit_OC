//
//  NSViewController+Hook.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFYAttributedImageInfo.h"

@interface NSMutableAttributedString (Parse)

// 检查并处理图片
- (NSMutableArray *)setImageAlignment:(TFYImageAlignment)imageAlignment
                          imageMargin:(NSEdgeInsets)imageMargin
                            imageSize:(CGSize)imageSize
                                 font:(NSFont *)font;
// 创建图片attString
- (NSMutableAttributedString *)createImageAttributedString:(TFYAttributedImageInfo *)imageInfo;

@end
