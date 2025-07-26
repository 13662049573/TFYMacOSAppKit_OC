//
//  TFYStatusItem.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import "TFYStatusItem.h"
#import <Availability.h>
#import "TFYStatusItemDropView.h"
#import "TFYStatusItemWindowController.h"

static NSString *const TFYStatusItemFrameKeyPath = @"statusItem.button.window.frame";
static NSString *const TFYStatusItemWindowConfigurationPinnedPath = @"windowConfiguration.pinned";

@interface NSStatusBarButton (Tools)
@end

@implementation NSStatusBarButton (Tools)
- (void)rightMouseDown:(NSEvent *)theEvent {}
@end


#pragma mark - TFYStatusItemContainerView
#pragma mark -

@interface TFYStatusItemContainerView : NSView
@property (weak) id target;
@property SEL action;
@property NSColor *backgroundDefaultColor;
@property NSColor *backgroundHighlightColor;
@property BOOL highlighted;
@end

@implementation TFYStatusItemContainerView

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _highlighted = NO;
        _backgroundDefaultColor = [NSColor clearColor];
        _backgroundHighlightColor = [NSColor selectedContentBackgroundColor];

        _target = nil;
        _action = nil;
    }
    return self;
}

- (void)dealloc {
    _target = nil;
    _action = nil;
    _backgroundDefaultColor = nil;
    _backgroundHighlightColor = nil;
}

- (void)drawRect:(NSRect)dirtyRect {
    NSBezierPath *bgPath = [NSBezierPath bezierPathWithRect:self.bounds];
    [(_highlighted ? _backgroundHighlightColor : _backgroundDefaultColor) setFill];
    [bgPath fill];
}

- (void)mouseDown:(NSEvent *)theEvent {
    _highlighted = YES;
    [self setNeedsDisplay:YES];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (self.target && self.action) {
        [self.target performSelector:self.action withObject:self];
    }
#pragma clang diagnostic pop
}

- (void)mouseUp:(NSEvent *)theEvent {
    _highlighted = NO;
    [self setNeedsDisplay:YES];
    [super mouseUp:theEvent];
}

@end


#pragma mark - TFYStatusItemView
#pragma mark -

@interface TFYStatusItem () <NSWindowDelegate> {
    id _globalDragEventMonitor;
    BOOL _proximityDragCollisionHandled;
    NSBezierPath *_proximityDragCollisionArea;
    NSInteger _pbChangeCount;
    TFYStatusItemContainerView *_customViewContainer;
}
@property (strong) NSStatusItem *statusItem;
@property (nonatomic) NSView *customView;
@property (assign) TFYStatusItemPresentationMode presentationMode;
@property (assign, nonatomic) BOOL isStatusItemWindowVisible;
@property (strong) TFYStatusItemDropView *dropView;
@property (strong, nonatomic) TFYStatusItemWindowController *statusItemWindowController;
@end

@implementation TFYStatusItem

#pragma mark - Initialization

+ (instancetype)sharedInstance {
    static dispatch_once_t _onceToken;
    __strong static TFYStatusItem *_sharedInstance;
    dispatch_once(&_onceToken, ^{
        _sharedInstance = [[[self class] alloc] initSingleton];
    });
    return _sharedInstance;
}

- (instancetype)init {
    NSString *exceptionMessage = [NSString stringWithFormat:@"You must NOT init '%@' manually! Use class method 'sharedInstance' instead.", [self className]];
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:exceptionMessage userInfo:nil];
}

- (instancetype)initSingleton {
    self = [super init];
    if (self) {
        _globalDragEventMonitor = nil;
        _proximityDragCollisionHandled = NO;

        _pbChangeCount = [NSPasteboard pasteboardWithName:NSPasteboardNameDrag].changeCount;
        _customViewContainer = nil;

        self.statusItem = nil;
        self.customView = nil;
        self.presentationMode = TFYStatusItemPresentationModeUndefined;
        self.isStatusItemWindowVisible = NO;
        self.statusItemWindowController = nil;
        self.windowConfiguration = [TFYStatusItemWindowConfiguration defaultConfiguration];
        self.appearsDisabled = NO;
        self.enabled = YES;

        self.dropTypes = @[NSPasteboardTypeFileURL];
        self.dropHandler = nil;
        self.proximityDragDetectionEnabled = NO;
        self.proximityDragZoneDistance = 23.0;
        self.proximityDragDetectionHandler = nil;

        //我们需要观察，因为当一个状态栏项目已经从状态栏中删除
        //和OS X重新组织所有项目，我们必须重新计算我们的_proximityDragCollisionArea。
        [self addObserver:self forKeyPath:TFYStatusItemFrameKeyPath options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:TFYStatusItemWindowConfigurationPinnedPath options:(NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];

        // 我们需要处理系统主题的变化，最终……
        [[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"AppleInterfaceThemeChangedNotification" object:nil queue:nil
                                                                 usingBlock:^(NSNotification *note) {
                                                                     [[NSNotificationCenter defaultCenter] postNotificationName:TFYSystemInterfaceThemeChangedNotification object:nil];
                                                                 }];
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:TFYStatusItemFrameKeyPath];
    [self removeObserver:self forKeyPath:TFYStatusItemWindowConfigurationPinnedPath];

    _statusItem = nil;
    _customView = nil;
    _statusItemWindowController = nil;
    _windowConfiguration = nil;
    _dropHandler = nil;
    _proximityDragDetectionHandler = nil;
    _proximityDragCollisionArea = nil;
    _customViewContainer = nil;
}

- (void)configureWithImage:(NSImage *)itemImage {
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.visible = YES;
    
    NSStatusBarButton *button = self.statusItem.button;
    button.target = self;
    button.action = @selector(handleStatusItemButtonAction:);
    button.image = itemImage;
}

- (void)configureWithView:(NSView *)itemView {
    self.customView = itemView;
    NSRect itemFrame = self.customView.frame;

    _customViewContainer = [[TFYStatusItemContainerView alloc] initWithFrame:itemFrame];
    _customViewContainer.autoresizingMask = (NSViewWidthSizable | NSViewHeightSizable);
    _customViewContainer.target = self;
    _customViewContainer.action = @selector(handleStatusItemButtonAction:);
    [_customViewContainer addSubview:self.customView];

    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSWidth(itemFrame)];
    self.statusItem.visible = YES;
    
    NSStatusBarButton *containerBtn = [[NSStatusBarButton alloc] initWithFrame:itemFrame];
    containerBtn.autoresizingMask = (NSViewWidthSizable | NSViewHeightSizable);
    containerBtn.target = self;
    containerBtn.action = @selector(handleStatusItemButtonAction:);
    [containerBtn addSubview:self.customView];
    
    
    NSStatusBarButton *button = self.statusItem.button;
    button.frame = itemFrame;
    [button addSubview:_customViewContainer];
    itemView.autoresizingMask = (NSViewWidthSizable | NSViewHeightSizable);
}

- (void)configureProximityDragCollisionArea {
    NSRect statusItemFrame = self.statusItem.button.window.frame;
    NSRect collisionFrame = NSInsetRect(statusItemFrame, -_proximityDragZoneDistance, -_proximityDragZoneDistance);
    _proximityDragCollisionArea = [NSBezierPath bezierPathWithRoundedRect:collisionFrame xRadius:NSWidth(collisionFrame) / 2 yRadius:NSHeight(collisionFrame) / 2];
}

- (void)configureDropView {
    [self.dropView removeFromSuperview];
    self.dropView = nil;

    if (!self.dropHandler) {
        return;
    };

    NSStatusBarButton *button = self.statusItem.button;
    NSRect buttonWindowFrame = button.window.frame;
    NSRect statusItemFrame = NSMakeRect(0.0, 0.0, NSWidth(buttonWindowFrame), NSHeight(buttonWindowFrame));
    self.dropView = [[TFYStatusItemDropView alloc] initWithFrame:statusItemFrame];
    self.dropView.statusItem = self;
    self.dropView.dropTypes = self.dropTypes;
    self.dropView.dropHandler = self.dropHandler;
    [button addSubview:self.dropView];
    self.dropView.autoresizingMask = (NSViewWidthSizable | NSViewHeightSizable);
}

#pragma mark - Creating and Displaying a StatusBarItem

- (void)presentStatusItemWithImage:(NSImage *)itemImage contentViewController:(NSViewController *)contentViewController {
    [self presentStatusItemWithImage:itemImage contentViewController:contentViewController dropHandler:nil];
}

- (void)presentStatusItemWithImage:(NSImage *)itemImage contentViewController:(NSViewController *)contentViewController dropHandler:(TFYStatusItemDropHandler)dropHandler {
    if (self.presentationMode != TFYStatusItemPresentationModeUndefined) return;

    [self configureWithImage:itemImage];
    [self configureProximityDragCollisionArea];

    self.dropHandler = dropHandler;
    self.presentationMode = TFYStatusItemPresentationModeImage;
    self.statusItemWindowController = [[TFYStatusItemWindowController alloc] initWithConnectedStatusItem:self
                                                                                   contentViewController:contentViewController
                                                                                     windowConfiguration:self.windowConfiguration];
}

- (void)presentStatusItemWithView:(NSView *)itemView contentViewController:(NSViewController *)contentViewController {
    [self presentStatusItemWithView:itemView contentViewController:contentViewController dropHandler:nil];
}

- (void)presentStatusItemWithView:(NSView *)itemView contentViewController:(NSViewController *)contentViewController dropHandler:(TFYStatusItemDropHandler)dropHandler {
    if (self.presentationMode != TFYStatusItemPresentationModeUndefined) return;

    [self configureWithView:itemView];
    [self configureProximityDragCollisionArea];

    self.dropHandler = dropHandler;
    self.presentationMode = TFYStatusItemPresentationModeCustomView;
    self.statusItemWindowController = [[TFYStatusItemWindowController alloc] initWithConnectedStatusItem:self
                                                                                   contentViewController:contentViewController
                                                                                     windowConfiguration:self.windowConfiguration];
}

- (void)updateContentViewController:(NSViewController *)contentViewController {
    [self.statusItemWindowController updateContenetViewController:contentViewController];
}

- (void)removeStatusItem {
    if (self.statusItem) {
        [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];

        self.statusItem = nil;
        self.presentationMode = TFYStatusItemPresentationModeUndefined;
        self.isStatusItemWindowVisible = NO;
        self.statusItemWindowController = nil;
    }
}


#pragma mark - Button Action Handling

- (void)handleStatusItemButtonAction:(id)sender {
    if (self.isStatusItemWindowVisible) {
        [self dismissStatusItemWindow];
    }
    else if (!self.shouldShowHandler || self.shouldShowHandler(self)) {
        [self showStatusItemWindow];
    }
}

#pragma mark - Custom Accessors

- (BOOL)isStatusItemWindowVisible {
    return (self.statusItemWindowController ? self.statusItemWindowController.windowIsOpen : NO);
}

- (void)setWindowConfiguration:(TFYStatusItemWindowConfiguration *)configuration {
    _windowConfiguration = configuration;
    self.statusItem.button.toolTip = configuration.toolTip;
}

- (BOOL)isDarkMode {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] persistentDomainForName:NSGlobalDomain];
    id style = [dict objectForKey:@"AppleInterfaceStyle"];
    return (style && [style isKindOfClass:[NSString class]] && NSOrderedSame == [style caseInsensitiveCompare:@"dark"]);
}

- (void)setAppearsDisabled:(BOOL)appearsDisabled {
    self.statusItem.button.appearsDisabled = appearsDisabled;
}

- (BOOL)appearsDisabled {
    return self.statusItem.button.appearsDisabled;
}

- (void)setEnabled:(BOOL)enabled {
    self.statusItem.button.enabled = enabled;
}

- (BOOL)enabled {
    return self.statusItem.button.enabled;
}

- (void)setProximityDragDetectionEnabled:(BOOL)proximityDraggingDetectionEnabled {
    if (_proximityDragDetectionEnabled != proximityDraggingDetectionEnabled) {
        _proximityDragDetectionEnabled = proximityDraggingDetectionEnabled;

        if (_proximityDragDetectionEnabled && !self.windowConfiguration.isPinned) {
            [self configureProximityDragCollisionArea];
            [self enableDragEventMonitor];
        }
        else {
            [self disableDragEventMonitor];
        }
    }
}

- (void)setProximityDragZoneDistance:(NSInteger)proximityDragZoneDistance {
    if (_proximityDragZoneDistance != proximityDragZoneDistance) {
        _proximityDragZoneDistance = proximityDragZoneDistance;
        [self configureProximityDragCollisionArea];
    }
}

- (void)setDropHandler:(TFYStatusItemDropHandler)dropHandler {
    _dropHandler = [dropHandler copy];
    [self configureDropView];
}

#pragma mark - Helper

- (void)enableDragEventMonitor {
    if (_globalDragEventMonitor) return;

    __weak typeof(self) wSelf = self;
    _globalDragEventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskLeftMouseDragged handler:^(NSEvent *event) {
        NSPoint eventLocation = [event locationInWindow];
        if ([self->_proximityDragCollisionArea containsPoint:eventLocation]) {
            //这是为了检测文件是否被拖拽。如果发生这种情况，NSPasteboard的changeCount将会增加。
            //拖动一个窗口将保持changeCount不变。
            NSInteger currentChangeCount = [NSPasteboard pasteboardWithName:NSPasteboardNameDrag].changeCount;
            if (self->_pbChangeCount == currentChangeCount) {
                return;
            }

            if (!self->_proximityDragCollisionHandled) {
                if (wSelf.proximityDragDetectionHandler) {
                    wSelf.proximityDragDetectionHandler(wSelf, eventLocation, TFYProximityDragStatusEntered);
                    self->_proximityDragCollisionHandled = YES;
                    self->_pbChangeCount = currentChangeCount;
                }
            }
        }
        else {
            if (self->_proximityDragCollisionHandled) {
                if (wSelf.proximityDragDetectionHandler) {
                    wSelf.proximityDragDetectionHandler(wSelf, eventLocation, TFYProximityDragStatusExited);
                    self->_proximityDragCollisionHandled = NO;
                    self->_pbChangeCount--;
                }
            }
        }
    }];
}

- (void)disableDragEventMonitor {
    [NSEvent removeMonitor:_globalDragEventMonitor];
    _globalDragEventMonitor = nil;
}


#pragma mark - Handling the Status Item Window

- (void)showStatusItemWindow {
    [self.statusItemWindowController showStatusItemWindow];
}

- (void)dismissStatusItemWindow {
    [self.statusItemWindowController dismissStatusItemWindow];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    if ([keyPath isEqualToString:TFYStatusItemFrameKeyPath]) {
        [self configureProximityDragCollisionArea];
    }
    else if ([keyPath isEqualToString:TFYStatusItemWindowConfigurationPinnedPath]) {
        if ([(NSString *)change[NSKeyValueChangeOldKey] integerValue] == NSControlStateValueOff) {
            [self disableDragEventMonitor];
        }
        else {
            [self dismissStatusItemWindow];
            if (self.proximityDragDetectionEnabled) {
                [self enableDragEventMonitor];
            }
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
