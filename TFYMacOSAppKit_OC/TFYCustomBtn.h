//
//  TFYCustomBtn.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/10/31.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    
    TFYRectCornerTopLeft     = 1 << 0,
    TFYRectCornerTopRight    = 1 << 1,
    TFYRectCornerBottomLeft  = 1 << 2,
    TFYRectCornerBottomRight = 1 << 3,
    TFYRectCornerAllCorners  = ~0UL
} TFYRectCorner;

typedef enum {
    
    TFYTextAlignmentLeft  = 0, //左对齐
    TFYTextAlignmentCenter,    //居中
    TFYTextAlignmentRight      //右对齐
    
}TFYTextAlignment;

typedef enum {
    
    TFYTextUnderLineStyleNone  = 0,     //无下划线
    TFYTextUnderLineStyleSingle,        //单下划线
    TFYTextUnderLineStyleDouble,        //双下划线
    TFYTextUnderLineStyleDeleteSingle,  //单删除线
    TFYTextUnderLineStyleDeleteDouble   //双删除线
    
}TFYTextUnderLineStyle;

@interface TFYCustomBtn : NSView
@property (nullable, weak) id target;
@property (nullable) SEL action;

///当鼠标移动到控件时，是否显示"小手"
@property (nonatomic, assign) BOOL isHandCursor;

///圆角
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) TFYRectCorner rectCorners;

///按钮文字
@property (nonatomic, nullable, strong) NSString *defaultTitle;
@property (nonatomic, nullable, strong) NSString *selectedTitle;

///按钮文字对齐方式
@property (nonatomic, assign) TFYTextAlignment textAlignment;

///按钮文字下划线样式
@property (nonatomic, assign) TFYTextUnderLineStyle textUnderLineStyle;

///按钮文字颜色
@property (nonatomic, nullable, strong) NSColor  *defaultTitleColor;
@property (nonatomic, nullable, strong) NSColor  *selectedTitleColor;

///按钮字体
@property (nonatomic, nullable, strong) NSFont   *defaultFont;
@property (nonatomic, nullable, strong) NSFont   *selectedFont;

///当背景图片存在时，背景色无效
@property (nonatomic, nullable, strong) NSImage  *defaultBackgroundImage;
@property (nonatomic, nullable, strong) NSImage  *selectedBackgroundImage;

///当背景图片不存在时，显示背景色
@property (nonatomic, nullable, strong) NSColor  *defaultBackgroundColor;
@property (nonatomic, nullable, strong) NSColor  *selectedBackgroundColor;

@end

NS_ASSUME_NONNULL_END
