//
//  macOScontainer.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#ifndef macOScontainer_h
#define macOScontainer_h

/** weakSelf */
#ifndef tfy_weakify
   #if DEBUG
       #if __has_feature(objc_arc)
           #define tfy_weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
       #else
           #define tfy_weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
      #endif
   #else
#if __has_feature(objc_arc)
          #define tfy_weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
      #else
          #define tfy_weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
      #endif
   #endif
#endif

/** strongSelf */
#ifndef tfy_strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define tfy_strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define tfy_strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
#if __has_feature(objc_arc)
           #define tfy_strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
           #define tfy_strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif


/***线程****/
///异步
NS_INLINE
void TFY_GCD_QUEUE_ASYNC(dispatch_block_t _Nonnull block) {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(queue)) == 0) {
        block();
    }else{
        dispatch_async(queue, block);
    }
}

///延迟加载
NS_INLINE
void TFY_GCD_QUEUE_TIME(NSInteger time,dispatch_block_t _Nonnull block) {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);//并发队列-延迟执行
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(queue)) == 0) {
        dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
        dispatch_after(when, queue, ^{
            block();
        });
    } else {
        dispatch_queue_t queuetime = dispatch_get_main_queue();//主队列--延迟执行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), queuetime, ^{
            block();
        });
    }
}
///主线程
NS_INLINE
void TFY_GCD_QUEUE_MAIN(dispatch_block_t _Nonnull block) {
    dispatch_queue_t queue = dispatch_get_main_queue();
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(queue)) == 0) {
        block();
    }else{
        if ([[NSThread currentThread] isMainThread]) {
            dispatch_async(queue, block);
        }else{
            dispatch_sync(queue, block);
        }
    }
}


#import "TFYButton.h"
#import "TFYLabel.h"
#import "TFYTextField.h"
#import "TFYUtils.h"
#import "TFYWKWebView.h"
#import "TFYOpenPanel.h"
#import "TFYSecureTextField.h"

#import "TFYGCDTimer.h"
#import "TFYGCDSemaphore.h"
#import "TFYStatusItem.h"

#endif /* macOScontainer_h */
