//
//  MSCellAccessory.m
//  MSCellAccessory
//
//  Created by SHIM MIN SEOK on 13. 6. 19..
//  Copyright (c) 2013 SHIM MIN SEOK. All rights reserved.
//

#import "MSCellAccessory.h"
#import "UIView+AccessViewController.h"

//if you change a UITableViewCell height, accessoryView this will affect change the right margin. so, the coordinates must be fixed. within layoutSubviews, drawRect. ( #issue prior to iOS7 )
#define kFixedPositionX                 (self.superview.frame.size.width - 38)
#define kFlatDetailFixedPositionX       (self.superview.frame.size.width - 58)

#define kAccessoryViewRect              CGRectMake(0, 0, 32.0, 32.0)
#define kCircleRect                     CGRectMake(6.0, 3.5, 21.0, 21.0)
#define kCircleOverlayRect              CGRectMake(2.0, 12.5, 29.0, 21.0)
#define kCircleShadowOverlayRect        CGRectMake(6.0, 3.0, 21.0, 22.2)
#define kStrokeWidth                    2.0
#define kShadowRadius                   4.5
#define kShadowOffset                   CGSizeMake(0.1, 1.2)
#define kShadowColor                    [UIColor colorWithWhite:.0 alpha:1.]
#define kDetailDisclosurePositon        CGPointMake(20.0, 14.0)
#define kDetailDisclosureRadius         5.5
#define kHighlightedColorGapH           9.0/360.0
#define kHighlightedColorGapS           9.5/100.0
#define kHighlightedFlatColorGapS       80.0/100.0
#define kHighlightedColorGapV          -4.5/100.0
#define kOverlayColorGapH               0.0/360.0
#define kOverlayColorGapS              -50.0/255.0
#define kOverlayColorGapV               15.0/255.0

#define kDisclosureStartX               CGRectGetMaxX(self.bounds)-7.0
#define kDisclosureStartY               CGRectGetMidY(self.bounds)
#define kDisclosureRadius               4.5
#define kDisclosureWidth                3.0
#define kDisclosureShadowOffset         CGSizeMake(.0, -1.0)
#define kDisclosurePositon              CGPointMake(18.0, 13.5)

#define kCheckMarkStartX                kAccessoryViewRect.size.width/2 + 1
#define kCheckMarkStartY                kAccessoryViewRect.size.height/2 - 1
#define kCheckMarkLCGapX                3.5
#define kCheckMarkLCGapY                5.0
#define kCheckMarkCRGapX                10.0
#define kCheckMarkCRGapY                -6.0
#define kCheckMarkWidth                 2.5

#define kToggleIndicatorStartX          CGRectGetMaxX(self.bounds)-10.0
#define kToggleIndicatorStartY          CGRectGetMidY(self.bounds)
#define kToggleIndicatorRadius          5.5
#define kToggleIndicatorLineWidth       3.5

#define kAddIndicatorShadowOffset         CGSizeMake(.0f, -1.f)

#define FLAT_ACCESSORY_VIEW_RECT                            CGRectMake(0, 0, 52.0, 32.0)
#define FLAT_STROKE_WIDTH                                   1.0
#define FLAT_DETAIL_CIRCLE_RECT                             CGRectMake(10.5, 5.5, 21.0, 21.0)
#define FLAT_DETAIL_BUTTON_DOT_FRAME                        CGRectMake(19.6, 9.5, 2.6, 2.6)
#define FLAT_DETAIL_BUTTON_VERTICAL_WIDTH                   2.0
#define FLAT_DETAIL_BUTTON_VERTICAL_START_POINT             CGPointMake(21, 13.5)
#define FLAT_DETAIL_BUTTON_VERTICAL_END_POINT               CGPointMake(21, 21.5)
#define FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH                 0.5
#define FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_START_POINT       CGPointMake(19.0, 13.5 + FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH * 0.5)
#define FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_END_POINT         CGPointMake(21.0, 13.5 + FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH * 0.5)
#define FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_START_POINT    CGPointMake(19.0, 21.5 + FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH * 0.5)
#define FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_END_POINT      CGPointMake(23.0, 21.5 + FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH * 0.5)

#define FLAT_DISCLOSURE_START_X                             CGRectGetMaxX(self.bounds)-1.5
#define FLAT_DISCLOSURE_START_Y                             CGRectGetMidY(self.bounds)+0.25
#define FLAT_DISCLOSURE_RADIUS                              4.8
#define FLAT_DISCLOSURE_WIDTH                               2.2
#define FLAT_DISCLOSURE_SHADOW_OFFSET                       CGSizeMake(.0, -1.0)
#define FLAT_DISCLOSURE_POSITON                             CGPointMake(18.0, 13.5)

#define FLAT_CHECKMARK_START_X                              kAccessoryViewRect.size.width/2 + 4.25
#define FLAT_CHECKMARK_START_Y                              kAccessoryViewRect.size.height/2 + 1.25
#define FLAT_CHECKMARK_LC_GAP_X                             2.5
#define FLAT_CHECKMARK_LC_GAP_Y                             2.5
#define FLAT_CHECKMARK_CR_GAP_X                             9.875
#define FLAT_CHECKMARK_CR_GAP_Y                             -4.375
#define FLAT_CHECKMARK_WIDTH                                2.125

#define FLAT_TOGGLE_INDICATOR_START_X                       CGRectGetMaxX(self.bounds)-7.0
#define FLAT_TOGGLE_INDICATOR_START_Y                       CGRectGetMidY(self.bounds)
#define FLAT_TOGGLE_INDICATOR_RADIUS                        5.0
#define FLAT_TOGGLE_INDICATOR_LINE_WIDTH                    2.0

#define kFlatDrawLineWidth                                  1.0
#define kFlatLineStartX                                     4.5
#define kFlatLineStartY                                     4.5
#define kFlatLineWidth                                     11.0
#define kFlatLineHeight                                     11.0

@interface MSCellAccessory()
@property (nonatomic, strong) UIColor *accessoryColor;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, strong) NSArray *accessoryColors;
@property (nonatomic, strong) NSArray *highlightedColors;
@end

@implementation MSCellAccessory

#pragma mark - Factory

+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType color:(UIColor *)color
{
    return [self accessoryWithType:accessoryType color:color highlightedColor:NULL];
}

+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor
{
    return [[MSCellAccessory alloc] initWithFrame:kAccessoryViewRect color:color highlightedColor:highlightedColor accessoryType:accessoryType];
}

+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType colors:(NSArray *)colors
{
    if(accessoryType != FLAT_DETAIL_DISCLOSURE)
        return [self accessoryWithType:accessoryType color:colors[0]];
    
    return [self accessoryWithType:accessoryType colors:colors highlightedColors:NULL];
}

+ (MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType colors:(NSArray *)colors highlightedColors:(NSArray *)highlightedColors
{
    if(accessoryType != FLAT_DETAIL_DISCLOSURE)
        return [self accessoryWithType:accessoryType color:colors[0] highlightedColor:highlightedColors[0]];
    
    return [[MSCellAccessory alloc] initWithFrame:FLAT_ACCESSORY_VIEW_RECT colors:colors highlightedColors:highlightedColors accessoryType:accessoryType];
}

#pragma mark -

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(_accType == FLAT_DETAIL_BUTTON || _accType == DETAIL_DISCLOSURE || _accType == PLUS_INDICATOR)
    {
        if(point.x > 0)
            return YES;
    }
    else if(_accType == FLAT_DETAIL_DISCLOSURE)
    {
        if(point.x > -3 && point.x < 46)
            return YES;
    }
    
    return [super pointInside:point withEvent:event];
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor accessoryType:(MSCellAccessoryType)accessoryType
{
    if ((self = [super initWithFrame:frame]))
    {
		self.backgroundColor = [UIColor clearColor];
        self.accessoryColor = color;
        self.accType = accessoryType;
        self.isAutoLayout = YES;
        
        if(!highlightedColor)
        {
            if(_accType >= FLAT_DETAIL_DISCLOSURE)
            {
                if(_accType == FLAT_DETAIL_BUTTON)
                {
                    CGFloat h = 0.f;
                    CGFloat s = 0.f;
                    CGFloat v = 0.f;
                    CGFloat a = 0.f;
                    // Crash below iOS 5
                    if ([_accessoryColor respondsToSelector:@selector(getHue:saturation:brightness:alpha:)])
                    {
                        [_accessoryColor getHue:&h saturation:&s brightness:&v alpha:&a];
                    }
                    self.highlightedColor = [UIColor colorWithHue:h saturation:s-kHighlightedFlatColorGapS brightness:v alpha:a];
                }
                else
                {
                    self.highlightedColor = self.accessoryColor;
                }
            }
            else
            {
                CGFloat h = 0.f;
                CGFloat s = 0.f;
                CGFloat v = 0.f;
                CGFloat a = 0.f;
                // Crash below iOS 5
                if ([_accessoryColor respondsToSelector:@selector(getHue:saturation:brightness:alpha:)])
                {
                    [_accessoryColor getHue:&h saturation:&s brightness:&v alpha:&a];
                }
                self.highlightedColor = [UIColor colorWithHue:h+kHighlightedColorGapH saturation:s+kHighlightedColorGapS brightness:v+kHighlightedColorGapV alpha:a];
            }
        }
        else
        {
            self.highlightedColor = highlightedColor;
        }
        
        self.userInteractionEnabled = NO;
        if(_accType == DETAIL_DISCLOSURE || _accType == FLAT_DETAIL_BUTTON)
        {
            [self addTarget:self action:@selector(accessoryButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
            self.userInteractionEnabled = YES;
        }
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame colors:(NSArray *)colors highlightedColors:(NSArray *)highlightedColors accessoryType:(MSCellAccessoryType)accessoryType
{
    if ((self = [super initWithFrame:frame]))
    {
		self.backgroundColor = [UIColor clearColor];
        self.accessoryColors = colors;
        self.accType = accessoryType;
        self.isAutoLayout = YES;

        if(!highlightedColors)
        {
            CGFloat h,s,v,a;
            [colors[0] getHue:&h saturation:&s brightness:&v alpha:&a];
            self.highlightedColors = @[[UIColor colorWithHue:h saturation:s-kHighlightedFlatColorGapS brightness:v alpha:a],colors[1]];
        }
        else
        {
            self.highlightedColors = highlightedColors;
        }
        
        [self addTarget:self action:@selector(accessoryButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!_isAutoLayout) return;
    //iOS5, iOS6
    if(![NSClassFromString(@"UIMotionEffect") class])
    {
        UITableView *tb = (UITableView *)self.superview.superview;
        
        if(tb.style == UITableViewStylePlain)
        {
            CGRect frame = self.frame;
            if(_accType != FLAT_DETAIL_DISCLOSURE)
                frame.origin.x = kFixedPositionX;
            else
                frame.origin.x = kFlatDetailFixedPositionX;
            self.frame = frame;
        }
    }
}

- (void)accessoryButtonTapped:(id)sender event:(UIEvent *)event
{
    UITableView *superTableView = NULL;
    id<UITableViewDelegate> tableDelegate = NULL;
    UITableViewCell *superTableViewCell = NULL;
    NSIndexPath *indexPath = NULL;
    
    superTableView = (UITableView *)self.superview;
    while (![superTableView isKindOfClass:[UITableView class]]) {
        superTableView = (UITableView *)superTableView.superview;
    }
    tableDelegate = superTableView.delegate;
    
    superTableViewCell = (UITableViewCell *)self.superview;
    while (![superTableViewCell isKindOfClass:[UITableViewCell class]]) {
        superTableViewCell = (UITableViewCell *)superTableViewCell.superview;
    }
    indexPath = [superTableView indexPathForCell:superTableViewCell];
    
    if ([tableDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [tableDelegate tableView:superTableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
    else {
        NSAssert(0, @"superController must implement tableView:accessoryButtonTappedForRowWithIndexPath:");
    }
}

- (void)drawRect:(CGRect)rect
{
    if(_accType == DETAIL_DISCLOSURE)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIBezierPath *ddCircle = [UIBezierPath bezierPathWithOvalInRect:kCircleRect];
        
        CGContextSaveGState(ctx);
        {
            CGContextAddEllipseInRect(ctx, kCircleShadowOverlayRect);
            CGContextSetShadowWithColor(ctx, kShadowOffset, kShadowRadius, kShadowColor.CGColor );
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGFloat h,s,v,a;
            UIColor *color = NULL;
            color = self.touchInside?_highlightedColor:_accessoryColor;
            [color getHue:&h saturation:&s brightness:&v alpha:&a];
            UIColor *overlayColor = [UIColor colorWithHue:h saturation:s+kOverlayColorGapS brightness:v+kOverlayColorGapV alpha:a];
            CGContextSetFillColorWithColor(ctx, overlayColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextClip(ctx);
            CGContextAddEllipseInRect(ctx, kCircleOverlayRect);
            CGContextSetFillColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextSetLineWidth(ctx, kStrokeWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextDrawPath(ctx, kCGPathStroke);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, kDisclosureShadowOffset, .0, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextMoveToPoint(ctx, kDetailDisclosurePositon.x-kDetailDisclosureRadius, kDetailDisclosurePositon.y-kDetailDisclosureRadius);
            CGContextAddLineToPoint(ctx, kDetailDisclosurePositon.x, kDetailDisclosurePositon.y);
            CGContextAddLineToPoint(ctx, kDetailDisclosurePositon.x-kDetailDisclosureRadius, kDetailDisclosurePositon.y+kDetailDisclosureRadius);
            CGContextSetLineWidth(ctx, kDisclosureWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == DISCLOSURE_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctx, kDisclosureStartX-kDisclosureRadius, kDisclosureStartY-kDisclosureRadius);
        CGContextAddLineToPoint(ctx, kDisclosureStartX, kDisclosureStartY);
        CGContextAddLineToPoint(ctx, kDisclosureStartX-kDisclosureRadius, kDisclosureStartY+kDisclosureRadius);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, kDisclosureWidth);
        
        if (self.highlighted)
        {
            [self.highlightedColor setStroke];
        }
        else
        {
            [self.accessoryColor setStroke];
        }
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == CHECKMARK)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctx, kCheckMarkStartX, kCheckMarkStartY);
        CGContextAddLineToPoint(ctx, kCheckMarkStartX + kCheckMarkLCGapX, kCheckMarkStartY + kCheckMarkLCGapY);
        CGContextAddLineToPoint(ctx, kCheckMarkStartX + kCheckMarkCRGapX, kCheckMarkStartY + kCheckMarkCRGapY);
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextSetLineJoin(ctx, kCGLineJoinRound);
        CGContextSetLineWidth(ctx, kCheckMarkWidth);
        
        if (self.highlighted)
        {
            [self.highlightedColor setStroke];
        }
        else
        {
            [self.accessoryColor setStroke];
        }
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == UNFOLD_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(   ctx, kToggleIndicatorStartX-kToggleIndicatorRadius, kToggleIndicatorStartY);
        CGContextAddLineToPoint(ctx, kToggleIndicatorStartX,                   kToggleIndicatorStartY+kToggleIndicatorRadius);
        CGContextAddLineToPoint(ctx, kToggleIndicatorStartX+kToggleIndicatorRadius, kToggleIndicatorStartY);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, kToggleIndicatorLineWidth);
        
        [self.accessoryColor setStroke];
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == FOLD_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(   ctx, kToggleIndicatorStartX-kToggleIndicatorRadius, kToggleIndicatorStartY+kToggleIndicatorRadius);
        CGContextAddLineToPoint(ctx, kToggleIndicatorStartX,                   kToggleIndicatorStartY);
        CGContextAddLineToPoint(ctx, kToggleIndicatorStartX+kToggleIndicatorRadius, kToggleIndicatorStartY+kToggleIndicatorRadius);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, kToggleIndicatorLineWidth);
        
        [self.accessoryColor setStroke];
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == PLUS_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIBezierPath *ddCircle = [UIBezierPath bezierPathWithOvalInRect:kCircleRect];
        
        CGContextSaveGState(ctx);
        {
            CGContextAddEllipseInRect(ctx, kCircleShadowOverlayRect);
            CGContextSetShadowWithColor(ctx, kShadowOffset, kShadowRadius, kShadowColor.CGColor );
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGFloat h,s,v,a;
            UIColor *color = NULL;
            color = self.touchInside?_highlightedColor:_accessoryColor;
            [color getHue:&h saturation:&s brightness:&v alpha:&a];
            UIColor *overlayColor = [UIColor colorWithHue:h saturation:s+kOverlayColorGapS brightness:v+kOverlayColorGapV alpha:a];
            CGContextSetFillColorWithColor(ctx, overlayColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextClip(ctx);
            CGContextAddEllipseInRect(ctx, kCircleOverlayRect);
            CGContextSetFillColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextSetLineWidth(ctx, kStrokeWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextDrawPath(ctx, kCGPathStroke);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, kAddIndicatorShadowOffset, 0, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextMoveToPoint(ctx, kDetailDisclosurePositon.x-3.5, kDetailDisclosurePositon.y-kDetailDisclosureRadius-1.0);
            CGContextAddLineToPoint(ctx, kDetailDisclosurePositon.x-3.5, kDetailDisclosurePositon.y+6.5);
            CGContextMoveToPoint(ctx, kDetailDisclosurePositon.x-10, kDetailDisclosurePositon.y);
            CGContextAddLineToPoint(ctx, kDetailDisclosurePositon.x+3, kDetailDisclosurePositon.y);
            CGContextSetLineWidth(ctx, kDisclosureWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == MINUS_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIBezierPath *ddCircle = [UIBezierPath bezierPathWithOvalInRect:kCircleRect];
        
        CGContextSaveGState(ctx);
        {
            CGContextAddEllipseInRect(ctx, kCircleShadowOverlayRect);
            CGContextSetShadowWithColor(ctx, kShadowOffset, kShadowRadius, kShadowColor.CGColor );
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGFloat h,s,v,a;
            UIColor *color = NULL;
            color = self.touchInside?_highlightedColor:_accessoryColor;
            [color getHue:&h saturation:&s brightness:&v alpha:&a];
            UIColor *overlayColor = [UIColor colorWithHue:h saturation:s+kOverlayColorGapS brightness:v+kOverlayColorGapV alpha:a];
            CGContextSetFillColorWithColor(ctx, overlayColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextClip(ctx);
            CGContextAddEllipseInRect(ctx, kCircleOverlayRect);
            CGContextSetFillColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextSetLineWidth(ctx, kStrokeWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextDrawPath(ctx, kCGPathStroke);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, kAddIndicatorShadowOffset, 0, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextMoveToPoint(ctx, kDetailDisclosurePositon.x-10, kDetailDisclosurePositon.y);
            CGContextAddLineToPoint(ctx, kDetailDisclosurePositon.x+3, kDetailDisclosurePositon.y);
            CGContextSetLineWidth(ctx, kDisclosureWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == FLAT_DISCLOSURE_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctx, FLAT_DISCLOSURE_START_X-FLAT_DISCLOSURE_RADIUS, FLAT_DISCLOSURE_START_Y-FLAT_DISCLOSURE_RADIUS);
        CGContextAddLineToPoint(ctx, FLAT_DISCLOSURE_START_X, FLAT_DISCLOSURE_START_Y);
        CGContextAddLineToPoint(ctx, FLAT_DISCLOSURE_START_X-FLAT_DISCLOSURE_RADIUS, FLAT_DISCLOSURE_START_Y+FLAT_DISCLOSURE_RADIUS);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, FLAT_DISCLOSURE_WIDTH);
        
        if (self.highlighted)
        {
            [self.highlightedColor setStroke];
        }
        else
        {
            [self.accessoryColor setStroke];
        }
        
        CGContextStrokePath(ctx);
        
    }
    else if(_accType == FLAT_DETAIL_DISCLOSURE)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIBezierPath *markCircle = [UIBezierPath bezierPathWithOvalInRect:FLAT_DETAIL_CIRCLE_RECT];
        
        UIColor *color1 = (UIColor *)_accessoryColors[0];
        UIColor *color2 = (UIColor *)_highlightedColors[0];
        UIColor *color3 = (UIColor *)_accessoryColors[1];
        UIColor *color4 = (UIColor *)_highlightedColors[1];
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextSetLineWidth(ctx, FLAT_STROKE_WIDTH);
            CGContextSetStrokeColorWithColor(ctx, self.touchInside?color2.CGColor:color1.CGColor);
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextSetLineCap(ctx, kCGLineCapSquare);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetFillColorWithColor(ctx, self.touchInside?color2.CGColor:color1.CGColor);
            
            CGContextFillEllipseInRect(ctx, FLAT_DETAIL_BUTTON_DOT_FRAME);
            
            CGContextSetStrokeColorWithColor(ctx, self.touchInside?color2.CGColor:color1.CGColor);
            
            CGContextSetLineWidth(ctx, FLAT_DETAIL_BUTTON_VERTICAL_WIDTH);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_VERTICAL_START_POINT.x, FLAT_DETAIL_BUTTON_VERTICAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_VERTICAL_END_POINT.x, FLAT_DETAIL_BUTTON_VERTICAL_END_POINT.y);
            CGContextStrokePath(ctx);
            
            CGFloat lineWidth = FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH;
            CGContextSetLineWidth(ctx, lineWidth);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_START_POINT.x, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_END_POINT.x, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_END_POINT.y);
            
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_START_POINT.x, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_END_POINT.x, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_END_POINT.y);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextMoveToPoint(ctx, FLAT_DISCLOSURE_START_X-FLAT_DISCLOSURE_RADIUS, FLAT_DISCLOSURE_START_Y-FLAT_DISCLOSURE_RADIUS);
            CGContextAddLineToPoint(ctx, FLAT_DISCLOSURE_START_X, FLAT_DISCLOSURE_START_Y);
            CGContextAddLineToPoint(ctx, FLAT_DISCLOSURE_START_X-FLAT_DISCLOSURE_RADIUS, FLAT_DISCLOSURE_START_Y+FLAT_DISCLOSURE_RADIUS);
            CGContextSetLineCap(ctx, kCGLineCapSquare);
            CGContextSetLineJoin(ctx, kCGLineJoinMiter);
            CGContextSetLineWidth(ctx, FLAT_DISCLOSURE_WIDTH);
            
            if (self.highlighted)
            {
                [color4 setStroke];
            }
            else
            {
                [color3 setStroke];
            }
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == FLAT_DETAIL_BUTTON)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIBezierPath *markCircle = [UIBezierPath bezierPathWithOvalInRect:FLAT_DETAIL_CIRCLE_RECT];
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextSetLineWidth(ctx, FLAT_STROKE_WIDTH);
            CGContextSetStrokeColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextSetLineCap(ctx, kCGLineCapSquare);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetFillColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            
            CGContextFillEllipseInRect(ctx, FLAT_DETAIL_BUTTON_DOT_FRAME);
            
            CGContextSetStrokeColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            
            CGContextSetLineWidth(ctx, FLAT_DETAIL_BUTTON_VERTICAL_WIDTH);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_VERTICAL_START_POINT.x, FLAT_DETAIL_BUTTON_VERTICAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_VERTICAL_END_POINT.x, FLAT_DETAIL_BUTTON_VERTICAL_END_POINT.y);
            CGContextStrokePath(ctx);
            
            CGFloat lineWidth = FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH;
            CGContextSetLineWidth(ctx, lineWidth);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_START_POINT.x, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_END_POINT.x, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_END_POINT.y);
            
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_START_POINT.x, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_END_POINT.x, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_END_POINT.y);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == FLAT_CHECKMARK)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctx, FLAT_CHECKMARK_START_X, FLAT_CHECKMARK_START_Y);
        CGContextAddLineToPoint(ctx, FLAT_CHECKMARK_START_X + FLAT_CHECKMARK_LC_GAP_X, FLAT_CHECKMARK_START_Y + FLAT_CHECKMARK_LC_GAP_Y);
        CGContextMoveToPoint(ctx, FLAT_CHECKMARK_START_X + FLAT_CHECKMARK_LC_GAP_X + 0.5, FLAT_CHECKMARK_START_Y + FLAT_CHECKMARK_LC_GAP_Y);
        CGContextAddLineToPoint(ctx, FLAT_CHECKMARK_START_X + FLAT_CHECKMARK_CR_GAP_X, FLAT_CHECKMARK_START_Y + FLAT_CHECKMARK_CR_GAP_Y);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, FLAT_CHECKMARK_WIDTH);
        
        if (self.highlighted)
        {
            [self.highlightedColor setStroke];
        }
        else
        {
            [self.accessoryColor setStroke];
        }
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == FLAT_UNFOLD_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(   ctx, FLAT_TOGGLE_INDICATOR_START_X-FLAT_TOGGLE_INDICATOR_RADIUS, FLAT_TOGGLE_INDICATOR_START_Y);
        CGContextAddLineToPoint(ctx, FLAT_TOGGLE_INDICATOR_START_X, FLAT_TOGGLE_INDICATOR_START_Y+FLAT_TOGGLE_INDICATOR_RADIUS);
        CGContextAddLineToPoint(ctx, FLAT_TOGGLE_INDICATOR_START_X+FLAT_TOGGLE_INDICATOR_RADIUS, FLAT_TOGGLE_INDICATOR_START_Y);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, FLAT_TOGGLE_INDICATOR_LINE_WIDTH);
        
        [self.accessoryColor setStroke];
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == FLAT_FOLD_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(   ctx, FLAT_TOGGLE_INDICATOR_START_X-FLAT_TOGGLE_INDICATOR_RADIUS, FLAT_TOGGLE_INDICATOR_START_Y+FLAT_TOGGLE_INDICATOR_RADIUS);
        CGContextAddLineToPoint(ctx, FLAT_TOGGLE_INDICATOR_START_X, FLAT_TOGGLE_INDICATOR_START_Y);
        CGContextAddLineToPoint(ctx, FLAT_TOGGLE_INDICATOR_START_X+FLAT_TOGGLE_INDICATOR_RADIUS, FLAT_TOGGLE_INDICATOR_START_Y+FLAT_TOGGLE_INDICATOR_RADIUS);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, FLAT_TOGGLE_INDICATOR_LINE_WIDTH);
        
        [self.accessoryColor setStroke];
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == FLAT_PLUS_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        UIBezierPath *markCircle = [UIBezierPath bezierPathWithOvalInRect:FLAT_DETAIL_CIRCLE_RECT];

        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, CGSizeMake(0, 2.5), 0, [UIColor colorWithWhite:243/255.0 alpha:1.0].CGColor);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextDrawPath(ctx, kCGPathFill);
            CGContextSetBlendMode (ctx, kCGBlendModeNormal);
        }
        CGContextRestoreGState(ctx);

        CGContextSaveGState(ctx);
        {
            CGContextSetStrokeColorWithColor(ctx, _accessoryColor.CGColor);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextSetFillColorWithColor(ctx, _accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            CGContextFillPath(ctx);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, kAddIndicatorShadowOffset, 0, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + FLAT_DETAIL_CIRCLE_RECT.size.width/2.0 - kFlatDrawLineWidth/2.0, FLAT_DETAIL_CIRCLE_RECT.origin.y + kFlatLineStartY);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + FLAT_DETAIL_CIRCLE_RECT.size.width/2.0 - kFlatDrawLineWidth/2.0, FLAT_DETAIL_CIRCLE_RECT.origin.y + kFlatLineStartY + kFlatLineHeight);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + kFlatLineStartX, FLAT_DETAIL_CIRCLE_RECT.origin.y + FLAT_DETAIL_CIRCLE_RECT.size.height/2.0 - kFlatDrawLineWidth/2.0);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + kFlatLineStartX + kFlatLineWidth, FLAT_DETAIL_CIRCLE_RECT.origin.y + FLAT_DETAIL_CIRCLE_RECT.size.height/2.0 - kFlatDrawLineWidth/2.0);
            CGContextSetLineWidth(ctx, kFlatDrawLineWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == FLAT_MINUS_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        UIBezierPath *markCircle = [UIBezierPath bezierPathWithOvalInRect:FLAT_DETAIL_CIRCLE_RECT];
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, CGSizeMake(0, 2.5), 0, [UIColor colorWithWhite:243/255.0 alpha:1.0].CGColor);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextDrawPath(ctx, kCGPathFill);
            CGContextSetBlendMode (ctx, kCGBlendModeNormal);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetStrokeColorWithColor(ctx, _accessoryColor.CGColor);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextSetFillColorWithColor(ctx, _accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            CGContextFillPath(ctx);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, kAddIndicatorShadowOffset, 0, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + kFlatLineStartX, FLAT_DETAIL_CIRCLE_RECT.origin.y + FLAT_DETAIL_CIRCLE_RECT.size.height/2.0 - kFlatDrawLineWidth/2.0);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + kFlatLineStartX + kFlatLineWidth, FLAT_DETAIL_CIRCLE_RECT.origin.y + FLAT_DETAIL_CIRCLE_RECT.size.height/2.0 - kFlatDrawLineWidth/2.0);
            CGContextSetLineWidth(ctx, kFlatDrawLineWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    
    if(!_isAutoLayout) return;

    //iOS5, iOS6
    if(![NSClassFromString(@"UIMotionEffect") class])
    {
        UITableView *tb = (UITableView *)self.superview.superview;
        
        if(tb.style == UITableViewStylePlain)
        {
            CGRect frame = self.frame;
            if(_accType != FLAT_DETAIL_DISCLOSURE)
                frame.origin.x = kFixedPositionX;
            else
                frame.origin.x = kFlatDetailFixedPositionX;
            self.frame = frame;
        }
        else
        {
            CGRect frame = self.frame;
            if(_accType != FLAT_DETAIL_DISCLOSURE)
                frame.origin.x = kFixedPositionX - 10;
            else
                frame.origin.x = kFlatDetailFixedPositionX;
            self.frame = frame;
        }
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
    
	[self setNeedsDisplay];
}

- (UIColor *)accessoryColor
{
	if (!_accessoryColor)
	{
		return [UIColor blackColor];
	}
    
	return _accessoryColor;
}

- (UIColor *)highlightedColor
{
	if (!_highlightedColor)
	{
		return [UIColor whiteColor];
	}
    
	return _highlightedColor;
}

@end
