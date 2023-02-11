//
//  NSGestureRecognizer+TFY_Tools.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "NSGestureRecognizer+TFY_Tools.h"
#import <objc/runtime.h>

static const int block_key;

@interface TFYGetureTarget : NSObject
@property (nonatomic, copy) GestureTargetAction action;
@end

@implementation TFYGetureTarget

- (instancetype)initWithBlock:(GestureTargetAction)action{
    if (self = [super init]) {
        _action = action;
    }
    return self;
}

- (void)sendGesture:(NSGestureRecognizer *)ges{
    if (_action) {
        _action(ges);
    }
}

@end

@implementation NSGestureRecognizer (TFY_Tools)

- (instancetype)initWithActionBlock:(void (^)(id sender))block {
    self = [self init];
    [self tfy_addTargetBlock:block];
    return self;
}

- (void)tfy_addTargetBlock:(GestureTargetAction)block{
    TFYGetureTarget *target = [[TFYGetureTarget alloc]initWithBlock:block];
    self.target = target;
    self.action = @selector(sendGesture:);
    [[self TFY_getstureTagetsArr] addObject:target];
}

- (void)tfy_addTargetBlock:(GestureTargetAction)block tag:(NSString *)tag{
    if (!block) return;
    if (!tag) {
        [self tfy_addTargetBlock:block];
    }else{
      [self tfy_removeTargetBlockByTag:tag];
      TFYGetureTarget *target = [[TFYGetureTarget alloc]initWithBlock:block];
        self.target = target;
        self.action = @selector(sendGesture:);
      [[self TFY_getstureTagetsDic] setObject:target forKey:tag];
    }
}

- (void)tfy_removeTargetBlockByTag:(NSString *)tag{
    if (!tag) return;
    NSMutableDictionary *targets = [self TFY_getstureTagetsDic];
    TFYGetureTarget *target = [targets objectForKey:tag];
    if (!target) return;
    self.target = nil;
    self.action = nil;
    [targets removeObjectForKey:tag];
}

- (void)tfy_removeAllTargetBlock{
    [[self TFY_getstureTagetsDic] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        self.target = nil;
        self.action = nil;
    }];
    [[self TFY_getstureTagetsArr] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.target = nil;
        self.action = nil;
    }];
}

- (NSMutableArray *)TFY_getstureTagetsArr{
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

- (NSMutableDictionary *)TFY_getstureTagetsDic{
    NSMutableDictionary *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
