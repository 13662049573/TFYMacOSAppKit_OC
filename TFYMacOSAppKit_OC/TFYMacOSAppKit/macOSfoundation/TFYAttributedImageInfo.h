//
//  TFYAttributedImageInfo.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 同一行文图混搭时，图片相对于同一行的文字的对齐模式，包含（上、中、下对齐）
 */
typedef NS_ENUM(NSInteger, TFYImageAlignment){
    TFYImageAlignmentTop = 0,
    TFYImageAlignmentCenter,
    TFYImageAlignmentBottom,
};

/**
 显示的类型，包括普通图片和动图(GIF)
 */
typedef NS_ENUM(NSInteger, TFYImageType){
    TFYImageNormalType = 0,
    TFYImageGIFType,
};

/**
 文件的来源,包括项目内文件和本地下载以及网络上的
 */
typedef NS_ENUM(NSInteger, TFYImageFrom){
    TFYImageLocalType = 0,
    TFYImageDownLoadType,
    TFYImageNetType,
};


@interface TFYAttributedImageInfo : NSObject

@property (nonatomic, copy) NSString *imageName;  // 图片名字

@property (nonatomic, copy) NSString *imagePath;  // 图片的路径地址

@property (nonatomic, assign) CGSize imageSize;     // 图片大小

@property (nonatomic, assign) CTFontRef fontRef;    // 文字字体

@property (nonatomic, assign)  NSEdgeInsets imageMargin;        // 图片与文字之间的间距

@property (nonatomic, assign) TFYImageAlignment imageAlignment;  // 图片相对于文字的排版样式

@property (nonatomic, assign) TFYImageType imageType;   // 类型（UIImage或者UIView）

@property (nonatomic, assign) TFYImageFrom imageFrom;   // 来源类型（本地,数据库,远程）


@end

NS_ASSUME_NONNULL_END
