//
//  NSButton+Dejal.h
//  MZKMedicalMacOs
//
//  Created by ç°é£æ on 2023/2/7.
//  Copyright Â© 2023 MZK. All rights reserved.
//

#import "NSButton+Dejal.h"
#import <objc/message.h>
#import <time.h>

@interface NSButton ()
/**
 *  ð¶nn    ð
 */
@property(nonatomic,strong)dispatch_source_t timer;
/**
 *  ð¶è®°å½å¤è¾¹çæ¶é´    ð
 */
@property(nonatomic,assign)NSInteger userTime;
@end

static NSInteger const TimeInterval = 60; // é»è®¤æ¶é´
static NSString * const ButtonTitleFormat = @"å©ä½%ldç§";
static NSString * const RetainTitle = @"éè¯";

@implementation NSButton (Dejal)

- (void)setTfy_time:(NSInteger)tfy_time{
    objc_setAssociatedObject(self, @selector(tfy_time), @(tfy_time), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)tfy_time {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return  number.integerValue;
}

- (void)setTfy_format:(NSString *)tfy_format {
    objc_setAssociatedObject(self, @selector(tfy_format), tfy_format, OBJC_ASSOCIATION_COPY);
}

- (NSString *)tfy_format {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN);
}

- (dispatch_source_t)timer {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setUserTime:(NSInteger)userTime {
    objc_setAssociatedObject(self, @selector(userTime), @(userTime), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)userTime {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return  number.integerValue;
}

- (void)setCompleteBlock:(void (^)(void))CompleteBlock {
    objc_setAssociatedObject(self, @selector(CompleteBlock), CompleteBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(void))CompleteBlock {
    return objc_getAssociatedObject(self, _cmd);
}


/**
 è¿åæ¥æ¶èææ¬çé¢è²ã
 */
- (NSColor *)tfy_textColor;
{
    NSAttributedString *attrTitle = self.attributedTitle;
    NSColor *textColor = [NSColor controlTextColor];
    
    if (attrTitle.length)
    {
        NSDictionary *attrs = [attrTitle fontAttributesInRange:NSMakeRange(0, 1)];
        
        if (attrs)
        {
            textColor = [attrs objectForKey:NSForegroundColorAttributeName];
        }
    }
    
    return textColor;
}

/**
 å°æ¥æ¶èçææ¬è®¾ç½®ä¸ºæå®çé¢è²ã
 */
- (void)tfy_setTextColor:(NSColor *)textColor;
{
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedTitle];
    NSRange range = NSMakeRange(0, attrTitle.length);
    
    if (textColor)
    {
        [attrTitle addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    }
    else
    {
        [attrTitle removeAttribute:NSForegroundColorAttributeName range:range];
    }
    [attrTitle addAttribute:NSFontAttributeName value:self.font range:range];
    [attrTitle fixAttributesInRange:range];
    
    self.attributedTitle = attrTitle;
}

- (kTextAligment)tfy_textAlignment
{
    NSNumber *number = objc_getAssociatedObject(self, "textAlignment");
    return number.integerValue;
}

- (void)setTfy_textAlignment:(kTextAligment)alignment
{
    objc_setAssociatedObject(self, "textAlignment", @(alignment), OBJC_ASSOCIATION_ASSIGN);
    NSMutableAttributedString *attributedString = [self.attributedTitle mutableCopy];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    switch (alignment) {
        case kTextAlignmentLeft:
            style.alignment = NSTextAlignmentLeft;
            break;
        case kTextAlignmentRight:
            style.alignment = NSTextAlignmentRight;
            break;
        case kTextAlignmentCenter:
            style.alignment = NSTextAlignmentCenter;
            break;
        default:
            break;
    }
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.title.length)];
    self.attributedTitle = attributedString;
}

/**
 æ¾ç¤ºæ¥æ¶å¨ä¸æ¹çèåã
 */
- (void)tfy_displayMenu:(NSMenu *)menu;
{
    [self tfy_displayMenu:menu withOffset:4];
}

/**
 æ¾ç¤ºæ¥æ¶å¨ä¸æ¹çèåã
 */

- (void)tfy_displayMenu:(NSMenu *)menu withOffset:(CGFloat)verticalOffset;
{
    [self tfy_displayMenu:menu withHorizontalOffset:0.0 verticalOffset:verticalOffset];
}

/**
 æ¾ç¤ºæ¥æ¶å¨ä¸æ¹çèåã
 
 è¦æ¾ç¤ºçèåã
 horizontalOffsetæ°´å¹³è°æ´çåç§»éã
 verticalOffsetåç´è°æ´çåç§»éã
 */

- (void)tfy_displayMenu:(NSMenu *)menu withHorizontalOffset:(CGFloat)horizontalOffset verticalOffset:(CGFloat)verticalOffset;
{
    NSPoint location = self.frame.origin;
    
    location.x += horizontalOffset;
    location.y -= verticalOffset;
    
    [menu popUpMenuPositioningItem:nil atLocation:location inView:self.superview];
}

- (void)tfy_startTimer {
    if (!self.tfy_time) {
        self.tfy_time = TimeInterval;
    }
    if (!self.tfy_format) {
        self.tfy_format = ButtonTitleFormat;
    }
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        if (self.tfy_time <= 1) {
            dispatch_source_cancel(self.timer);
        }else
        {
            self.tfy_time --;
            dispatch_async(mainQueue, ^{
                self.enabled = NO;
                self.title = [NSString stringWithFormat:self.tfy_format,self.tfy_time];
            });
        }
    });
    dispatch_source_set_cancel_handler(self.timer, ^{
        dispatch_async(mainQueue, ^{
            self.enabled = YES;
            self.title = RetainTitle;
            if (self.CompleteBlock) {
                self.CompleteBlock();
            }
            if (self.userTime) {
                self.tfy_time = self.userTime;
            }else
            {
                self.tfy_time = TimeInterval;
            }
        });
    });
    dispatch_resume(self.timer);
}

- (void)tfy_endTimer{
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
}


@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSButton (DejalRadios)

/**
 
 åè®¾æ¥æ¶èæ¯ä¸ä¸ªåéæé®ï¼å¨ç»ä¸­æ¾å°å¶ä»åéæé®(å³å¨ç¸åçç¶è§å¾ä¸­ï¼å·æç¸åçæä½)ï¼å¹¶éæ©å·ææå®æ ç­¾çåéæé®ãå¨ç»ä¸­çä»»ä½æ çº¿çµä¸è°ç¨æ­¤å½ä»¤ãæ¿æ¢-[NSMatrix selectCellWithTag:]ã
 */

- (void)tfy_selectRadioWithTag:(NSInteger)tag;
{
    [self tfy_enumerateRadiosUsingBlock:^(NSButton *radio, BOOL *stop)
     {
         radio.state = radio.tag == tag;
     }];
}

/**

 åè®¾æ¥æ¶èæ¯ä¸ä¸ªåéæé®ï¼å¨ç»ä¸­æ¾å°å¶ä»åéæé®(å³å¨ç¸åçç¶è§å¾ä¸­ï¼å·æç¸åçæä½)ï¼å¹¶è¿åæéåéçæ ç­¾å¼ãå¨ç»ä¸­çä»»ä½æ çº¿çµä¸è°ç¨æ­¤å½ä»¤ãæ¿æ¢-[NSMatrix selectedTag]ã
 */

- (NSInteger)tfy_selectedRadioTag;
{
    NSButton *foundRadio = [self tfy_radioPassingTest:^BOOL(NSButton *radio, BOOL *stop)
     {
         return radio.state;
     }];
    
    return foundRadio.tag;
}

/**
 å¦ææ çº¿çµç»å·²å¯ç¨ï¼åè¿åYESï¼å¦ææªå¯ç¨åè¿åNOãç®åå°è¿åæ¥æ¶èçç¶æ;å¶ä»çåè®¾é½æ¯ä¸æ ·çã(å¦æä½ æ³ç¥éå®ä»¬æ¯å¦å¨é¨å¯ç¨æç¦ç¨ï¼å¯è½æå¥½ä½¿ç¨-tfy_enumerateRadiosUsingBlock:æ¥æ«æç»ï¼å¹¶æ ¹æ®éè¦å¤çæ··åæåµã)

 */

- (BOOL)tfy_radiosEnabled;
{
    return self.enabled;
}

/**
 å°ç»ä¸­çæææ çº¿çµè®¾ç½®ä¸ºå¯ç¨æç¦ç¨ãæ¿æ¢-[NSMatrix setEnabled:]ã
 */

- (void)tfy_setRadiosEnabled:(BOOL)enabled;
{
    [self tfy_enumerateRadiosUsingBlock:^(NSButton *radio, BOOL *stop)
     {
         radio.enabled = enabled;
     }];
}

/**
 åè®¾æ¥æ¶å¨æ¯ä¸ä¸ªåéæé®ï¼å¨ç»ä¸­æ¾å°å¶ä»åéæé®(å³å¨ç¸åçç¶è§å¾ä¸­ï¼å·æç¸åçæä½)ï¼å¹¶ä¸ºæ¯ä¸ªæé®æ§è¡åï¼å°åéæé®ä¼ éç»åãè¿åè¿åYESçå¼ï¼å¦æåå¨å®æåè¯·æ±åæ­¢ï¼åè¿ånilï¼æèåå¨æ²¡æè¿åYESçæåµä¸å®æãå¨ç»ä¸­çä»»ä½æ çº¿çµä¸è°ç¨æ­¤å½ä»¤ã

 ä¸ä¸ªä»¥åéæé®ååæ­¢å¸å°å¼ç¨ä½ä¸ºåæ°å¹¶è¿åå¸å°å¼çåã
 @è¿åæ¾å°çåéæé®ï¼å¦ææ²¡ææ¾å°ï¼åè¿ånilã
 */

- (NSButton *)tfy_radioPassingTest:(BOOL (^)(NSButton *radio, BOOL *stop))predicate;
{
    for (NSButton *radio in self.superview.subviews)
    {
        // æ²¡æå¯é çæ¹æ³æ¥ç¡®å®ä¸ä¸ªæé®æ¯å¦å®éä¸æ¯åéæé®ï¼ä½å¯ä»¥åçå°åè®¾æ²¡æéåéæé®å°å·æç¸åçå¨ä½(å·æç¸åçå¨ä½ä½¿å¶æä¸ºç»çæå):
        if ([radio isKindOfClass:[NSButton class]] && radio.action == self.action && predicate)
        {
            BOOL stop = NO;
            
            if (predicate(radio, &stop))
            {
                return radio;
            }
            
            if (stop)
            {
                return nil;
            }
        }
    }
    
    return nil;
}

/**
 åè®¾æ¥æ¶å¨æ¯ä¸ä¸ªåéæé®ï¼å¨ç»ä¸­æ¾å°å¶ä»åéæé®(å³å¨ç¸åçç¶è§å¾ä¸­ï¼å·æç¸åçæä½)ï¼å¹¶ä¸ºæ¯ä¸ªæé®æ§è¡åï¼å°åéæé®ä¼ éç»åãå¨ç»ä¸­çä»»ä½æ çº¿çµä¸è°ç¨æ­¤å½ä»¤ã

 ä¸ä¸ªä»¥åéæé®ååæ­¢å¸å°å¼ç¨ä½ä¸ºåæ°å¹¶è¿åvoidçåã
 */

- (void)tfy_enumerateRadiosUsingBlock:(void (^)(NSButton *radio, BOOL *stop))block;
{
    for (NSButton *radio in self.superview.subviews)
    {
        // æ²¡æå¯é çæ¹æ³æ¥ç¡®å®ä¸ä¸ªæé®æ¯å¦å®éä¸æ¯åéæé®ï¼ä½å¯ä»¥åçå°åè®¾æ²¡æéåéæé®å°å·æç¸åçå¨ä½(å·æç¸åçå¨ä½ä½¿å¶æä¸ºç»çæå):
        if ([radio isKindOfClass:[NSButton class]] && radio.action == self.action && block)
        {
            BOOL stop = NO;
            
            block(radio, &stop);
            
            if (stop)
            {
                return;
            }
        }
    }
}

@end

