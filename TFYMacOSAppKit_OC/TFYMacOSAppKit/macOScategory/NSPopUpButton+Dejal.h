//
//  NSPopUpButton+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//
#import <Cocoa/Cocoa.h>

@interface NSPopUpButton (Dejal)
/**
 向菜单中添加分隔符项。
*/
- (void)tfy_addSeparatorItem;
/**
 类似于-addItemWithTitle:，但是允许指定一个标签。它不会像-[NSPopUpButton addItemWithTitle:]那样删除同名的任何其他项。它还返回创建的项。
*/

- (NSMenuItem *)tfy_addItemWithTitle:(NSString *)aString tag:(NSInteger)tag;
/**
 类似于-addItemWithTitle:，但是允许指定标记和表示对象。它不会像-[NSPopUpButton addItemWithTitle:]那样删除同名的任何其他项。它还返回创建的项。
*/

- (NSMenuItem *)tfy_addItemWithTitle:(NSString *)aString tag:(NSInteger)tag representedObject:(id)object;
/**
 给定一个文件路径数组，将项目添加到接收器。项目标题是最后一个没有扩展名的路径组件，项目标签是根据请求设置的。项表示的对象被设置为缩略路径或完整路径，基于缩写atedobject值。如果prefixDivider为YES，则在其他项之前添加分隔线(如果有的话)。可以调用- pathswitheextension:atPath:deepScan:(在NSFileManager+tfy中)获取路径。
*/
- (void)tfy_addItemsWithPaths:(NSArray *)paths prefixDivider:(BOOL)prefixDivider tag:(NSInteger)tag abbreviatedObject:(BOOL)abbreviatedObject defaultPath:(NSString *)defaultPath;
/**
 方法返回带有给定标记的菜单项。
*/

- (NSMenuItem *)tfy_itemWithTag:(NSInteger)aTag;
/**
 返回所选项目的标记的方便方法，类似于indexOfSelectedItem等。
 */

- (NSInteger)tfy_tagOfSelectedItem;
/**
 使用给定的表示对象选择菜单项的简便方法。
*/

- (NSInteger)tfy_selectItemWithRepresentedObject:(id)anObj;
/**
 返回所选项目的表示对象的方便方法，类似于indexOfSelectedItem等。
*/
- (id)tfy_representedObjectOfSelectedItem;

@end

