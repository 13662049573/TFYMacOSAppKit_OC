//
//  NSViewController+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


@interface NSViewController (Dejal)

/**
 为方便起见，返回接收器的窗口控制器。假设窗口的委托是窗口控制器，就像通常的情况一样。
 */

@property (nonatomic, weak, readonly) NSWindowController *tfy_windowController;

/**
 为了方便，返回接收器的最后一个子视图控制器(例如当只有一个时)。
 */

@property (nonatomic, strong, readonly) NSViewController *tfy_lastChildViewController;

/**
 执行视图控制器的两个兄弟子视图控制器之间的转换。和
 -transitionFromViewController:toViewController:options:completionHandler:方法，除了这个变体支持任何一个视图为nil，并自动添加和删除需要的视图控制器，除了他们的视图。

 子视图控制器，它的视图在视图控制器的视图层次结构中可见，如果还没有，则为nil。
 一个子视图控制器，它的视图不在视图控制器的视图层次结构中，或者nil从viewcontroller中移除。
options指定如何执行过渡动画的选项的位掩码。有关选项，请参阅NSViewControllerTransitionOptions枚举。
 在过渡动画完成后立即调用的块;可能是零。
 */

- (void)tfy_transitionSubviewFromViewController:(NSViewController *)fromViewController toViewController:(NSViewController *)toViewController options:(NSViewControllerTransitionOptions)options completionHandler:(void (^)(void))completion;

@end

