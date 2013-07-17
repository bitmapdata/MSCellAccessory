//
//  MSCellAccessory.m
//  MSCellAccessory
//
//  Created by SHIM MIN SEOK on 13. 6. 19..
//  Copyright (c) 2013 SHIM MIN SEOK. All rights reserved.
//

#import "MSCellAccessory.h"

#define kAccessoryViewRect              CGRectMake(0, 0, 32.0, 32.0)

#define kCircleRect                     CGRectMake(5.5, 3.5, 22.0, 22.0)
#define kCircleOverlayRect              CGRectMake(3.5, 14.5, 23.0, 23.0)
#define kStrokeWidth                    2.0
#define kShadowRadius                   4.6
#define kShadowOffset                   CGSizeMake(.08, .52)
#define kShadowColor                    [UIColor colorWithWhite:.0 alpha:1.]
#define kDetailDisclosurePositon        CGPointMake(20.0, 14.5)
#define kDetailDisclosureRadius         5.5
#define kHighlightedColorGapH           9.0/360.0
#define kHighlightedColorGapS           9.5/100.0
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


@interface MSCellAccessory()
@property (nonatomic, assign) AccessoryType type;
@property (nonatomic, strong) UIColor *accessoryColor;
@property (nonatomic, strong) UIColor *highlightedColor;
@end

@implementation MSCellAccessory

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor accType:(AccessoryType)accType
{
    if ((self = [super initWithFrame:frame]))
    {
		self.backgroundColor = [UIColor clearColor];
        self.accessoryColor = color;
        self.type = accType;
        if(!highlightedColor)
        {
            CGFloat h,s,v,a;
            [_accessoryColor getHue:&h saturation:&s brightness:&v alpha:&a];
            self.highlightedColor = [UIColor colorWithHue:h+kHighlightedColorGapH saturation:s+kHighlightedColorGapS brightness:v+kHighlightedColorGapV alpha:a];
        }
        else
        {
            self.highlightedColor = highlightedColor;
        }
        if(_type != DETAIL_DISCLOSURE)
        {
            self.userInteractionEnabled = NO;
        }
    }
    
    return self;
}

+ (MSCellAccessory *)accessoryWithType:(AccessoryType)accType color:(UIColor *)color
{
    return [self accessoryWithType:accType color:color highlightedColor:NULL];
}

+ (MSCellAccessory *)accessoryWithType:(AccessoryType)accType color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor
{
    MSCellAccessory *ret = [[MSCellAccessory alloc] initWithFrame:kAccessoryViewRect color:color highlightedColor:highlightedColor accType:accType];
    
	return ret;
}

- (void)drawRect:(CGRect)rect
{
    if(_type == DETAIL_DISCLOSURE)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIBezierPath *markCircle = [UIBezierPath bezierPathWithOvalInRect:kCircleRect];
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, markCircle.CGPath);
            CGFloat h,s,v,a;
            UIColor *color = NULL;
            color = self.touchInside?_highlightedColor:_accessoryColor;
            [color getHue:&h saturation:&s brightness:&v alpha:&a];
            UIColor *overlayColor = [UIColor colorWithHue:h saturation:s+kOverlayColorGapS brightness:v+kOverlayColorGapV alpha:a];
            CGContextSetFillColorWithColor(ctx, overlayColor.CGColor);
            CGContextSetShadowWithColor(ctx, kShadowOffset, kShadowRadius, kShadowColor.CGColor );
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextClip(ctx);
            CGContextAddRect(ctx, kCircleOverlayRect);
            CGContextSetFillColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, markCircle.CGPath);
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
    else if(_type == DISCLOSURE_INDICATOR)
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
    else if(_type == CHECKMARK)
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
    else
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();

        if(self.selected)
        {
            CGContextMoveToPoint(   ctx, kToggleIndicatorStartX-kToggleIndicatorRadius, kToggleIndicatorStartY+kToggleIndicatorRadius);
            CGContextAddLineToPoint(ctx, kToggleIndicatorStartX,                   kToggleIndicatorStartY);
            CGContextAddLineToPoint(ctx, kToggleIndicatorStartX+kToggleIndicatorRadius, kToggleIndicatorStartY+kToggleIndicatorRadius);
            CGContextSetLineCap(ctx, kCGLineCapSquare);
            CGContextSetLineJoin(ctx, kCGLineJoinMiter);
            CGContextSetLineWidth(ctx, kToggleIndicatorLineWidth);
        }
        else
        {
            CGContextMoveToPoint(   ctx, kToggleIndicatorStartX-kToggleIndicatorRadius, kToggleIndicatorStartY);
            CGContextAddLineToPoint(ctx, kToggleIndicatorStartX,                   kToggleIndicatorStartY+kToggleIndicatorRadius);
            CGContextAddLineToPoint(ctx, kToggleIndicatorStartX+kToggleIndicatorRadius, kToggleIndicatorStartY);
            CGContextSetLineCap(ctx, kCGLineCapSquare);
            CGContextSetLineJoin(ctx, kCGLineJoinMiter);
            CGContextSetLineWidth(ctx, kToggleIndicatorLineWidth);
        }
        [self.accessoryColor setStroke];

        CGContextStrokePath(ctx);
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
